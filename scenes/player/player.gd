extends CharacterBody2D

signal player_shoot_laser(pos, direction)
signal player_shoot_grenade(pos, direction)

var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 500
var speed: int = max_speed

func hit():
	Globals.health -= 10

func _process(_delta):
	
	#input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position

#laser shooting input
	look_at(get_global_mouse_position())

	var player_direction = (get_global_mouse_position() - position).normalized()

	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()] #selecting random item from the list
		can_laser = false
		$LaserReloadTimer.start()
		player_shoot_laser.emit(selected_laser.global_position, player_direction)
		
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		can_grenade = false
		$GrenadeReloadTimer.start()
		var pos = $LaserStartPositions.get_children()[0].global_position
		player_shoot_grenade.emit(pos, player_direction)

func _on_timer_timeout():
	can_laser = true
	

func _on_grenade_reload_timer_timeout():
	can_grenade = true
