extends Area2D

var rotation_speed: int = 2
var avilable_options = ['laser', 'laser', 'laser', 'grenade', 'health']
var type = avilable_options[randi()%len(avilable_options)]

var direction: Vector2
var distance: int = randi_range(150, 250)

func _ready():
	
	if type == 'laser':
		$Sprite2D.modulate = Color(0.1,0.1,0.4)
		
	if type == 'grenade':
		$Sprite2D.modulate = Color(0.5,0.1,0.2)
		
	if type == 'health':
		$Sprite2D.modulate = Color(0.1,0.4,0.2)

#tweens
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5)
	tween.tween_property(self, "scale", Vector2(1,1), 0.3).from(Vector2(0,0))



func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(_body):
	if type == 'health':
		Globals.health += 10
	
	if type == 'laser':
		Globals.laser_amount += 5
		
	if type == 'grenade':
		Globals.grenade_amount += 1
	
	queue_free()
	
	
