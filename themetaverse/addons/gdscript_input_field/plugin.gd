@tool
extends EditorPlugin
## Adds a GDScript input field to the EditorLog.

var _field: CodeEdit
var _session_script: GDScript
var _session: Object
var _expression: Expression
var _assignment_regex: RegEx
var _function_regex: RegEx


## Traverses the editor's interface tree in search of the EditorLog.
func _find_editor_log(start: Node = null) -> Node:
	if not start:
		start = get_editor_interface().get_base_control()
	var result: Node = null
	if start.get_class() == 'EditorLog':
		result = start
	else:
		for child in start.get_children():
			result = _find_editor_log(child)
			if result:
				break
	return result


## Our desired parent should be the second child of the EditorLog.
func _find_parent_for_field() -> VBoxContainer:
	var editor_log := _find_editor_log()
	if editor_log:
		return editor_log.get_child(1) as VBoxContainer
	else:
		return null


## Creates and executes a GDScript function from a given code string.
func _exec(code: String) -> Variant:
	var result: Variant
	var varnames := PackedStringArray([])
	var varvals := []
	var oneliner = code.replace("\n", ' ').replace("\r", ' ')
	var rxmatch: RegExMatch
	# First check if it's a variable assignment.
	if oneliner.find(';') < 0:
		rxmatch = _assignment_regex.search(oneliner)
		if rxmatch:
			_session._vars[rxmatch.get_string(1)] = _exec(
				rxmatch.get_string(2)
			)
			return null
	# Otherwise:
	# Collect varnames and varvals.
	for varname in _session._vars:
		varnames.append(varname)
		varvals.append(_session._vars[varname])
	# Check if it's a function declaration.
	rxmatch = _function_regex.search(oneliner)
	if rxmatch:
		var src := "return func (%s):\n" % rxmatch.get_string(2)
		for varname in varnames:
			src += "\tvar %s = _vars['%s']\n" % [varname, varname]
		src += rxmatch.get_string(3).indent("\t") + "\n"
		for varname in varnames:
			src += "\t_vars['%s'] = %s\n" % [varname, varname]
		_session._vars[rxmatch.get_string(1)] = _exec(src)
		return null
	# Otherwise:
	# Try executing the code as an Expression.
	# This way we can distinguish cases where code is a valid Expression,
	# and thus allow for omitting `return` in those cases.
	var is_expression := true
	if _expression.parse(code, varnames) == OK:
		result = _expression.execute(varvals, _session, false)
		if _expression.has_execute_failed():
			is_expression = false
	else:
		is_expression = false
	# If the code is not an Expression, execute it as full-blown GDScript.
	# Gratitude to user @derkork on the official Godot Discord server
	# for explaining to me that it's possible to dynamically create
	# a GDScript resource rather than try to do everything with Expressions.
	if not is_expression:
		var src := """
			var _vars := {}
			func exec():
		""".dedent()
		for varname in varnames:
			src += "\tvar %s = _vars['%s']\n" % [varname, varname]
		src += code.indent("\t") + "\n"
		for varname in varnames:
			src += "\t_vars['%s'] = %s\n" % [varname, varname]
		_session_script.source_code = src
		_session_script.reload(true)
		result = _session.exec()
	return result


## Executes and clears the field the instant it contains line breaks.
func _on_field_text_changed() -> void:
	if _field.text.contains("\n") or _field.text.contains("\r"):
		var code := _field.text.replace("\n", '').replace("\r", '')
		_field.text = ""
		if not code.is_empty():
			print("> %s" % code)
			var result := _exec(code)
			print("=> %s" % var_to_str(result))


func _enter_tree() -> void:
	# Create and connect input field.
	_field = CodeEdit.new()
	_field.text_changed.connect(_on_field_text_changed)
	_field.caret_blink = true
	_field.scroll_fit_content_height = true
	_field.placeholder_text = "Evaluate GDScript"
	# Create other vars.
	_session_script = GDScript.new()
	_session_script.source_code = """
		var _vars := {}
		func exec(): pass
	""".dedent()
	_session_script.reload()
	_session = _session_script.new()
	_expression = Expression.new()
	_assignment_regex = RegEx.new()
	_assignment_regex.compile("^\\s*(?:var)?\\s*([a-zA-Z0-9_]+)\\s*=(.+)$")
	_function_regex = RegEx.new()
	_function_regex.compile(
		"^\\s*func\\s*([a-zA-Z0-9_]+)\\s*\\((.+?)\\)\\s*:\\s*(.+)$"
	)
	# Add input field to tree.
	var parent := _find_parent_for_field()
	if parent:
		parent.add_child(_field)
	else:
		push_error("Couldn't find the EditorLog's first VBoxContainer")
		_field.text_changed.disconnect(_on_field_text_changed)
		_field.queue_free()
		_field = null
		queue_free()


func _exit_tree() -> void:
	if _field:
		_field.text_changed.disconnect(_on_field_text_changed)
		_field.queue_free()
