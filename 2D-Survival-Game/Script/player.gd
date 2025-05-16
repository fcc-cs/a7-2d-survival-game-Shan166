extends CharacterBody2D
var speed=100
var player_state

func _physics_process(delta):
	var direction=Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if direction.x==0 and direction.y==0:
		player_state="Idle"
	elif direction.x !=0 or direction.y !=0:
		player_state="Walking"
	
	velocity=direction*speed
	move_and_slide()

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
