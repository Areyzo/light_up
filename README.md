# Light Up 

A puzzle game built with Godot where you manipulate light rays to reach a goal.

## Game Objective

Direct a light beam to hit the goal target by using mirrors and careful angle positioning. Once the light touches the goal, you win!


## Controls


| Action | Key |
|--------|-----|
| Move Left | A or Left Arrow |
| Move Right | D or Right Arrow |
| Jump | W or Up Arrow |
| Shoot Light Ray | Left Mouse Button (Hold) |

## How to Play

1. **Position Your Character**: Use arrow keys or WASD to move left and right, and jump to reach different heights.

2. **Aim the Light**: Hold down the left mouse button to cast a light ray from your position.

3. **Use Mirrors**: The light will bounce off mirrors to redirect its path. Position yourself and adjust your aim to make the light bounce toward the goal.

4. **Hit the Goal**: When the light ray reaches the goal target, a "You Win!" dialog will appear.

5. **Next Steps**: Choose "Play Again" to restart the level or "Quit" to exit the game.

## Game Features

- **Dynamic Light Physics**: Light rays bounce realistically off mirrors with a maximum of 10 bounces per shot
- **Mirror Mechanics**: Mirrors temporarily disable themselves after being hit to prevent infinite bounces
- **Player Movement**: Fluid character movement with gravity and jumping
- **Win Condition**: Visual feedback with a dialog when you successfully hit the goal

## Project Structure

```
lightup2/
├── player.gd          # Main player script with light ray logic
├── map.tscn           # Game scene with player, terrain, mirrors, and goal
├── sprites/           # Visual assets (player, terrain, mirrors, goal)
└── project.godot      # Godot project configuration
```

## Technical Details

- **Engine**: Godot 4.x
- **Language**: GDScript
- **Light System**: Uses RayCast2D for accurate light path detection
- **Mirror Bounce**: Implements reflection physics using normal vector bounce calculations
- **Collision Groups**: Mirrors are tracked separately to enable dynamic collision toggling

## Tips for Solving Puzzles

- Mirrors are your best friend - use them to redirect light around obstacles
- The light bounces a maximum of 10 times, so plan your strategy accordingly
- You can move while aiming - this doesn't affect an already-cast ray
- Experiment with different angles and mirror positions to find the optimal path
