## 🧭 Introduction
Genetic Flight Simulator is an interactive, genetic algorithm-based simulation playground where you attempt to teach a flock of flying creatures to fly. Its mechanics are inspired by the [Flappy Bird Game](https://en.wikipedia.org/wiki/Flappy_Bird) and the concept of using genetic algorithms to teach AI agents to play the game originally comes from [this video](https://www.youtube.com/watch?v=aeWmdojEJf0&t=2s) by Srdjan Susnic. I am thankful to both projects for serving as the inspiration for my own. However, apart from high-level concepts, no part of this project (including code, asests, and implementation details) was borrowed from any of the aforementioned projects.

## 🚀 Quickstart
To see the live project in action, head over to the project's [Itch page](https://cupidofdeath.itch.io/genetic-flight-simulator).

To make changes to this project, clone this repository and open the project using the [4.4.1-stable version of the Godot game engine](https://github.com/godotengine/godot/releases/tag/4.4.1-stable).

## 🏗️ Architecture
Since this project was originally created as a learning experience, I wanted to keep the architecture as simple as possible to be able to understand everything that was happening under the hood. To that end, each agent's gene contains a mere three floating point values that dicate its behavior. This first two are the weights connecting two neurons in the input layer to one neuron in the output layer. The two neurons in the input layer represent the horizontal distance from the closest pipe to the agent and the vertical distance from the center of the closest pipe gap. The output layer is converted into a boolean that determines whether the agent should flap or not flap by applying the sigmoid function and checking if the resulting value is greater than 0.5.
Expressed as a mathematical equation, the agent's decision-making can be summed up as below:
```
flap = sigmoid((h_distance_from_closest_pipe)*gene1 + (v_distance_from_center_of_closest_pipe_gap)*gene2 + gene3) > 0.5
```

Here is a diagram illustrating the architecture as a layered perceptron:

<img width="415" height="331" alt="architecture" src="https://github.com/user-attachments/assets/d35b3247-06d0-4289-916e-7ec56252a32c" />

## 🛡️ Licensing
This project is licensed under the [GNU General Public License v3.0 (GPL v3)](./LICENSE) except for external assets that obey their own licensing terms listed in the [ATTRIBUTIONS file](./ATTRIBUTIONS.md).
