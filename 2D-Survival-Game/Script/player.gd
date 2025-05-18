extends CharacterBody2D
signal stick_collected
signal apple_collected
signal slime_collected

var speed=100
var player_state
var bow_equiped=false
var bow_cooldown=true
var arrow=preload("res://Scene/arrow.tscn")
var mouse_loc_from_player=null
@export var inv: Inv
@onready var camera=$Camera2D

func _physics_process(delta):
	mouse_loc_from_player=get_global_mouse_position()-self.position

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
	if !bow_equiped:
		speed=100
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
	if bow_equiped:
		speed=0
		if mouse_loc_from_player.x>=-25 and mouse_loc_from_player.x<=25 and mouse_loc_from_player.y<0:
			$AnimatedSprite2D.play("N-Attack")
		if mouse_loc_from_player.x>=25 and mouse_loc_from_player.y<=-25:
			$AnimatedSprite2D.play("NE-Attack")
		if mouse_loc_from_player.y>=-25 and mouse_loc_from_player.y<=25 and mouse_loc_from_player.x>0:
			$AnimatedSprite2D.play("E-Attack")
		if mouse_loc_from_player.x>=0.5 and mouse_loc_from_player.y>=25:
			$AnimatedSprite2D.play("SE-Attack")
		if mouse_loc_from_player.x>=-25 and mouse_loc_from_player.x<=25 and mouse_loc_from_player.y>0:
			$AnimatedSprite2D.play("S-Attack")
		if mouse_loc_from_player.x<=-0.5 and mouse_loc_from_player.y>=25:
			$AnimatedSprite2D.play("SW-Attack")
		if mouse_loc_from_player.y>=-25 and mouse_loc_from_player.y<=25 and mouse_loc_from_player.x<0:
			$AnimatedSprite2D.play("W-Attack")
		if mouse_loc_from_player.x<=-25 and mouse_loc_from_player.y<=-25:
			$AnimatedSprite2D.play("NW-Attack")
func player():
	pass

func collect(item):
	inv.insert(item)
	print(item)
	if str(item)=="<Resource#-9223372001672952406>":#stick
		print("Picked up stick")
		emit_signal("stick_collected")
	if str(item)=="<Resource#-9223372000817314381>":#slime
		print("Picked up slime")
		emit_signal("slime_collected")
	if str(item)=="<Resource#-9223371997864524318>":#apple
		print("Picked up apple")
		emit_signal("apple_collected")
