# GDScript Input Field Plugin

This is a plugin for Godot 4 that adds a GDScript input field
to the bottom of the editor output panel.

## Installation

Copy the directory `addons/gdscript_input_field`
into the directory `[your project]/addons`,
such that you wind up with `[your project]/addons/gdscript_input_field`.

You can then enable or disable the plugin in Godot under
`Project -> Project Settings... -> Plugins`.

Enabling it should place a new input field in the `Output` panel,
underneath `Filter Messages`, with the placeholder text
`Evaluate GDScript`.

## Usage

The field functions like a REPL: you may type a GDScript expression
or statement there and then a line break (return / enter), and the expression
or statement will be consumed and evaluated, and its result printed
to the log above.

In the context of the expressions and statements evaluated,
`self` is an object with a single instance variable, `_vars`: a Dictionary.
You may declare and assign other variables, and they will persist
between inputs; `_vars` is the means by which they do so.
However, because this requires some string manipulation prior to evaluation,
there are some less-than-intuitive caveats:

1. A variable declaration must be the only statement in its input line,
 or else it will not persist after the input line is processed.
 This will preserve `x`: `var x = 6`; this will not: `var x = 6; print(x)`.
2. If the input line contains a series of statements
 including a `return` statement, and that statement is reached,
 any variable assignments prior in the input line,
 even to preexisting variables, will be undone.
 This will preserve `x`: `x = 6`. This will not: `x = 6; return x`.
3. For the sake of shorthand, an assignment statement alone on its input line
 and assigning to a nonexistent variable will act like a declaration instead.
 That is to say, if `x` does not exist, `x = 6` all by itself
 will act like `var x = 6`, but `x = 6; print(x)` will be an error.

You may not declare classes.

You can declare functions, but any functions you declare
will become `Callable`s and must be called with `.call()`.
E.g. if you've previously entered `func f(x): return x**2`,
then `f(2)` is invalid, but `f.call(2)` is valid and will return `4`.
