# It Gets Better

This is a simple unfinished project for the Godot Wild Jam 69 that uses an ECS framework in the godot engine. This was mostly used to find the good and the bad of the [ECS framework I had built](https://github.com/LeftCircle/GodotECS)

## Findings and future work

### General Workflow
Creating components and systems was a bit cumbersome because it required a script for the class and a resource for the component to be placed in a specific folder. The process for attaching components to systems and entities was also different. For systems, the resource within the folder had to be used, and with entities a new resource had to be created. Forgetting this step would cause components to be shared between entities which is undesirable. 

The main reason for this disconnect is due to component scenes, which are .tscn files that act as components but really only exist for convenience and generally don’t function in the way ECS is intended. For example, there is a constant_motion_component that has an export variable that points to the node to be moved. This is sub optimal because when looping through all constant_motion_components, the nodes to be moved won’t be packed tightly together in memory like the components are, which negates the optimization benefit of the ECS architecture. It would be better to have a pure data position component that exists on each entity, then this position component could be used to update other .tscn files such as a CharacterBody2D, and we can reduce the updates of scattered data to a single system.

 Creating a plugin to make the creation of systems and components as easy as pressing a custom button in the editor would also be worth considering. 

#### Events
The jam required cooldowns to be used, and I approached different abilities on a cooldown by creating systems for each cooldown. One of these systems was a simple “Jump” system, where if the ability is not on cooldown and jump is pressed, then the character's velocity is set to the jump speed. The downside of this is that this system checks _every game tick_ to see if jump is pressed. Game logic like this probably fits better as more of an event driven update as opposed to a system that operates on all jump components in bulk every single frame. 

#### Systems
Another problem area at the moment is that all systems execute every frame in whatever order they are called from the dictionary of systems. Being able to have more control of when/if a system should execute would also be desirable. 

#### General questions
One major concern I have is whether or not this system scales well. Because all components are stored in tightly packed component arrays, but not all components are used in each system, it is very possible for cache misses to still occur as more entities are registered. Another question is how cache efficient it is to be grabbing components from several component arrays at once. If a given system operates on four different components, would neighboring components from each component array be pulled into the cache to be used on the next entity update? Here’s the move system as an example:

```
var character_body_array : ComponentArray = EcsCoordinator.get_component_array(ECSCharacterBody2D)
var inputs : ComponentArray = EcsCoordinator.get_component_array(InputAction)
var abilities_arr : ComponentArray = EcsCoordinator.get_component_array(RunAbilityComponent)
var empty_input = InputAction.new()

func update(delta : float) -> void:
    for entity in entities.keys():
   	 var run : RunAbilityComponent = abilities_arr.components[abilities_arr.entity_to_index[entity]]
   	 var input : InputAction = inputs.components[inputs.entity_to_index[entity]]
   	 var cbd : ECSCharacterBody2D = character_body_array.components[character_body_array.entity_to_index[entity]]
   	 if run.ready and input.is_direction_pressed():
   		 _trigger_ability(run, true)
   		 move_left_right(cbd, input, delta)
   	 else:
   		 move_left_right(cbd, empty_input, delta)
   	 _update_cooldwons(run, delta)
```
The question then becomes how cache efficient it is to call components from three different arrays like this. I’m not entirely sure how to find out. 
