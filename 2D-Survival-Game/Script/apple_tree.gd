extends Node2D
var state = "no apple"
var player_in_area = false
var apple = preload("res://scene/apple_colectible.tscn")
func _ready():
	if state == "no apple":
		$Growth_Timer.start()
		
func _process(delta):
	if state == "no apple":
		$AnimatedSprite2D.play("No_Apples")
	if state == "apple":
		$AnimatedSprite2D.play("Apples")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no apple"
				drop_apple()

func drop_apple():
	var apple_instance = apple.instantiate()
	apple_instance.global_position = $Marker2D.global_position
	get_parent().add_child(apple_instance)
	await get_tree().create_timer(3).timeout
	$Growth_Timer.start()

func _on_pick_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true

func _on_pick_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false

func _on_growth_timer_timeout() -> void:
	if state == "no apple":
		state = "apple"
