# TU856/TU857/TU858/TU984 Games Engines 1 2023 


[![Video](http://img.youtube.com/vi/NMDupdv85FE/0.jpg)](http://www.youtube.com/watch?NMDupdv85FE)

Join the class on the World Videophone using the following link:

[![World Videophone](images/wvp.jpg)](https://teams.microsoft.com/l/meetup-join/19%3ameeting_OWNkOTU5MWMtZGRkYi00ZDIxLWI3NzAtZjFjMjc3Y2NiMmVl%40thread.v2/0?context=%7b%22Tid%22%3a%22766317cb-e948-4e5f-8cec-dabc8e2fd5da%22%2c%22Oid%22%3a%2261aab78b-a857-4647-9668-83d4cca5de03%22%7d)

## Resources

- [Assignment](assignment.md)
- [Godot Quick Reference](godot_ref.md)
- [Unity Quick Reference](unityref.md)
- [Markdown Tutorial](assignmentreadme.md)
- [git Tutorial](gitlab.md)
- [Past Papers](pastpapers.zip)

## Contact me
* Email: bryan.duggan@tudublin.ie
* [My website & other ways to contact me](http://bryanduggan.org)

- [Discord](https://discord.gg/vQEgsb4E)

## Week 5 - Quaternions & the Metaverse
- [The Archaic Revival - Read the essay "Virtual Reality and Electronic Highs"](https://archive.org/stream/pdfy-CVSFsGW3fYSFP1wM/McKenna%2C%20Terence%20-%20The%20Archaic%20Revival_djvu.txt)
- [Slides on quaternions](https://drive.google.com/file/d/11-KFbodaAl9dRSs9ljzdDyTDp1QWWnsZ/view?usp=sharing)
- [Vectors](https://docs.unity3d.com/Manual/UnderstandingVectorArithmetic.html)

My popular Quaternions in Unity Video:

[![YouTube](http://img.youtube.com/vi/IXySkVFNhdk/0.jpg)](http://www.youtube.com/watch?v=IXySkVFNhdk)

An ode to Quaternions

A quaternion is like a vector, but with a "w"

To construct one, use an axis and an angle, that's what we do

For rotations it must be normal, or otherwise its pure

So we normalise, divide by length, just to be sure

To invert a normal quaternion, we negate x, y and z

Multiply quaternion, vector, inverse quaternion and it rotates don't you see

A rotation of 0 radians is the same as two pi

To convert a quaternion to a matrix, we use the API

So here's a health to old Hamilton, your inventor it would appear

And to imaginary numbers floating in the hypersphere

- Dr Bryan Duggan

## Lab

Today lets make this system:

[![YouTube](http://img.youtube.com/vi/utJ5uUouxuA/0.jpg)](http://www.youtube.com/watch?v=utJ5uUouxuA)

The system is a turret AI system for a game such as a tower defence game. In the video below, the red "tower" will turn to face the players tank and start shooting as soon as the player comes in range. To create this system:

- Make the turret from two cubes and set a spawn point for bullets on the turret
- Add a TurretController component to the turret. Add fields for rotationSpeed and fireRate (and any others you might need)
- Use a SphereCollider on the turret and set isTrigger to be true
- Override OnTriggerEnter and OnTriggerStay to detect the player
- Use quaternions to rotate the turret
- Use a co-routine to shoot multiple times per second


## Week 4 - Vectors
- [Recording](https://tudublin-my.sharepoint.com/:v:/r/personal/bryan_duggan_tudublin_ie/Documents/Recordings/Game%20Engines%20Class-20231013_140831-Meeting%20Recording.mp4?csf=1&web=1&e=bm3ggk&nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZyIsInJlZmVycmFsQXBwUGxhdGZvcm0iOiJXZWIiLCJyZWZlcnJhbE1vZGUiOiJ2aWV3In19)

## Week 3 
- [Recording](https://tudublin-my.sharepoint.com/:v:/g/personal/bryan_duggan_tudublin_ie/EeYq8HOEu7JLk1Ye7TCXIcQBQvlp4_UCS78iR-X323Ox6Q?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZyIsInJlZmVycmFsQXBwUGxhdGZvcm0iOiJXZWIiLCJyZWZlcnJhbE1vZGUiOiJ2aWV3In19&e=h71mOT)

Lab 

### Learning Outcomes
- Build a simple agent with perception
- Develop computation thinking
- Use trigonometry
- Use vectors
- Use the Godot API
- Practice GDScript

Today you will be making this (click the image for video):

[![YouTube](http://img.youtube.com/vi/kC_W1WBB7uY/0.jpg)](http://www.youtube.com/watch?v=kC_W1WBB7uY)

To start, switch to the master branch of your fork, update your forks to get the starter code and create a new branch for your work today:

```bash
git checkout master
git pull upstream master
git checkout -b mylab4
```

If you are on a lab computer, you will need to clone your forks. I have updated my version of Unity to be the same as the version installed in the labs, so opening the project should be fast now!

Open the scene lab2 to get the starter scene and code for today. 

What is happening:
- The red tank has a script attached called AITank that has radius and numWaypoints fields that control the generation of waypoints in a circle around it. These waypoints will be stored in a List. (Like an ArrayList in Java). It draws sphere gizmos so you can see where the waypoints will be.
- The red tank will move from waypoint to waypoint starting at the 0th one and looping back when it reaches the last waypoint.
- The red tank prints the messages using the Unity GUI system to indicate:
    - Whether the blue tank is in front or behind
    - Whether the front tank is inside a 45 degree FOV
    - Use the [Godot reference](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html) to figure out what API's to call!

I suggest you work on these tasks:

### Task 1

Add code to OnDrawGizmos in the script AITank.cs to draw gizmos for the waypoints. Use sin and cod to calculate the waypoints. Don't add them to the list here, just draw a sphere gizmos at the position where each waypoint should be

### Task 2

Write code in Awake that populates the waypoints List with the waypoints. Use a for loop, sin, cos and ```transform.TransformPoint```. 

### Task 3

Write code in Update to move the AITank towards the current waypoint. When it comes within 1 unit of the waypoint, you should advance to the next waypoint. You can use transform.Translate, transform.Rotate, transform.position =, transform.rotation = Quaternion.LookRotation. Look up the Unity documentation to see what these API's do

### Task 4
Write code in Update to print whether the player tank is in front or or behind the AI tank

### Task 5
Write code in Update to print whether the player tank is inside a 45 degree FOV of the AI tank and whether the player tank is in range of the AI tank. In range means that the player tank is < 10 units away from the AI tank

You will use the following API's in your solution:

```C#
Quaternion.Slerp
Quaternion.LookRotation
Vector3.Normalize
Vector3.Dot
Transform.Translate
```

## Week 2 - Learning Godot
- [Trigonometry Problem Set](https://1.cdn.edl.io/IDqRlI8C9dRkoqehbbdHBrcGT6m87gkCQuMKTkp0U7JvHvuG.pdf)
- [Week 2 Recording](https://tudublin-my.sharepoint.com/:v:/g/personal/bryan_duggan_tudublin_ie/EYkCd5ALm3BFvsAamhfMrYUBvxxlS0AYrU8oZ23hvNwMVg?e=zhZ2D1&nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZyIsInJlZmVycmFsQXBwUGxhdGZvcm0iOiJXZWIiLCJyZWZlcnJhbE1vZGUiOiJ2aWV3In19)

### Lab 

## Learning Outcomes
- Make a procedural system in Godot
- Use trigonometry and vectors
- Use the Godot Editor & VS Code
- Make commits on your repo
- Use the Godot API's


Here is a video of what you can make today (click the image for the video):

[![YouTube](http://img.youtube.com/vi/tL6ux8isdgY/0.jpg)](https://www.youtube.com/watch?v=tL6ux8isdgY)

I suggest you try and make a single circle of dodecahedrons first and then use a nested loop to make all the circles. You will be using the following Unity API calls in your solution:

```C#
Mathf.Sin(angle)
Mathf.Cos(angle)
GameObject.Instantiate()
transform.Rotate()
```

You will also need to know about the [Unit circle](https://www.khanacademy.org/math/algebra2/x2ec2f6f830c9fb89:trig/x2ec2f6f830c9fb89:unit-circle/v/unit-circle-definition-of-trig-functions-1) and also how to [calculate the circumference of a circle](https://www.wikihow.com/Calculate-the-Circumference-of-a-Circle)


## Week 1 - Introduction

## Lecture

- [Introduction Slides](https://tudublin-my.sharepoint.com/:p:/g/personal/bryan_duggan_tudublin_ie/EdrNh-GMMW1Esv3VTsNExNsBY_sSMZKGPorMZMwoXr5PMg?e=1CLgbf)
- [Recording of the class](https://tudublin-my.sharepoint.com/:v:/g/personal/bryan_duggan_tudublin_ie/ESfPwPySin1Aq7jnYK7AtbAB_UC2h7Cm4a-vox1_c4spxQ?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZyIsInJlZmVycmFsQXBwUGxhdGZvcm0iOiJXZWIiLCJyZWZlcnJhbE1vZGUiOiJ2aWV3In19&e=b8xzMa)

### Learning Outcomes
- Install Godot & git for Windows
- Get Godot running on the lab computers
- Set up the fork, clone it, merge the upstream, commit and push into your fork
- Create a little thing in Godot 

### Instructions
- Install Godot on your laptop or get Godot going on the lab computers. 
- Fork the repository for the course (click the fork button above)
- Clone the repository and cd into the folder  you cloned:

```bash
git clone http://github.com/YOUR_GIT_NAME/GE1-2023
cd GE1-2023
```

- Check to ensure the remotes are setup correctly. You should see both origin and upstream remotes. The origin remote should be the url to your repo and the upstream remote should be the url to my repo

```bash
git remote -v
```

- If you don't see the upstream remote, you can add it by typing:

```bash
git remote add upstream https://github.com/skooter500/GE1-2023/
```

- Switch to a new branch

```bash
git checkout -b mylab1
```

- Now launch Godot and see if you can open the scene we made in class today and run it.

Make some changes and do a final commit

[Submit the link to your fork](https://forms.office.com/Pages/ResponsePage.aspx?id=yxdjdkjpX06M7Nq8ji_V2ou3qmFXqEdGlmiD1Myl3gNUMUZWTzVSQldVVVpONDBFTTdYQUtNWExNTC4u)
