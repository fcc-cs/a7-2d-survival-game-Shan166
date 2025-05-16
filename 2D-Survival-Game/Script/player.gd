extends CharacterBody2D
var speed=100
var player_state
@export var inv: Inv
var bow_equiped=false
var bow_cooldown=true
var arrow=preload("res://Scene/arrow.tscn")

func _physics_process(delta):
	var direction=Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if direction.x==0 and direction.y==0:
		player_state="Idle"
	elif direction.x !=0 or direction.y !=0:
		player_state="Walking"
	velocity=direction*speed
	move_and_slide()
	if Input.is_action_just_pressed("e"):
		if bow_equiped:
			bow_equiped=false
		else:
			bow_equiped=true
	
	var mouse_pos=get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	
	if Input.is_action_just_pressed("left_mouse") and bow_equiped and bow_cooldown:
		bow_cooldown=false
		var arrow_instance=arrow.instantiate()
		arrow_instance.rotation=$Marker2D.rotation
		arrow_instance.global_position=$Marker2D.global_position
		add_child(arrow_instance)
		await get_tree().create_timer(0.4).timeout
		bow_cooldown=true

	play_anim(direction)
	
func play_anim(dir):
	if player_state=="Idle":
		$AnimatedSprite2D.play("Idle")
	if player_state == "Walking":
		if dir.y == -1:
			$AnimatedSprite2D.play("N-Walk")
		if dir.y < -0.5 and dir.x > 0.5:
			$AnimatedSprite2D.play("NE-Walk")
		if dir.x == +1:
			$AnimatedSprite2D.play("E-Walk")
		if dir.y > 0.5 and dir.x > 0.5:
			$AnimatedSprite2D.play("SE-Walk")
		if dir.y == 1:
			$AnimatedSprite2D.play("S-Walk")
		if dir.y > 0.5 and dir.x < -0.5:
			$AnimatedSprite2D.play("SW-Walk")
		if dir.x == -1:
			$AnimatedSprite2D.play("W-Walk")
		if dir.y < -0.5 and dir.x < -0.5:
			$AnimatedSprite2D.play("NW-Walk")

func player():
	pass

func collect(item):
	inv.insert(item)
