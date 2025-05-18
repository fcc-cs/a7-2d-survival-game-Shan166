extends CharacterBody2D
const speed=30
var current_state=IDLE
var is_roaming=true
var is_chatting=false
var dir=Vector2.RIGHT
var start_pos
var player
var player_in_chat_zone=false

enum{IDLE,NEW_DIR,MOVE}

func _ready():
	randomize()
	start_pos=position

func _process(delta):
	if current_state == IDLE or current_state == NEW_DIR:
		$AnimatedSprite2D.play("idle")
	elif current_state == MOVE and !is_chatting:
		if dir.y < -0.5 and dir.x > 0.5:
			$AnimatedSprite2D.play("NE-Walk")
		elif dir.y > 0.5 and dir.x > 0.5:
			$AnimatedSprite2D.play("SE-Walk")
		elif dir.y > 0.5 and dir.x < -0.5:
			$AnimatedSprite2D.play("SW-Walk")
		elif dir.y < -0.5 and dir.x < -0.5:
			$AnimatedSprite2D.play("NW-Walk")
		elif dir.y == -1:
			$AnimatedSprite2D.play("N-Walk")
		elif dir.x == +1:
			$AnimatedSprite2D.play("E-Walk")
		elif dir.y == 1:
			$AnimatedSprite2D.play("S-Walk")
		elif dir.x == -1:
			$AnimatedSprite2D.play("W-Walk")
		else:
			$AnimatedSprite2D.play("idle")
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir=choose([Vector2.RIGHT,Vector2.UP,Vector2.LEFT,Vector2.DOWN,Vector2.RIGHT+Vector2.UP,Vector2.UP+Vector2.LEFT,Vector2.LEFT+Vector2.DOWN,Vector2.DOWN+Vector2.RIGHT])
			MOVE:
				move(delta)
				
	if Input.is_action_just_pressed("chat"):
		print("chatting with npc")
		$Dialogue.start()
		is_roaming=false
		is_chatting=true
		$AnimatedSprite2D.play("idle")
	if Input.is_action_just_pressed("quest"):
		print("quest has started")
		$npc_quest.next_quest()
		is_roaming=false
		is_chatting=true
		$AnimatedSprite2D.play("idle")
	
func choose(array):
	array.shuffle()
	return array.front()
	
func move (delta):
	if !is_chatting:
		velocity=dir*speed
		move_and_slide()
		
func _on_chat_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player=body
		player_in_chat_zone=true

func _on_chat_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_chat_zone=false

func _on_timer_timeout() -> void:
	$Timer.wait_time=choose([1,1.5,2])
	current_state=choose([IDLE,NEW_DIR,MOVE])

func _on_dialogue_dialogue_finished() -> void:
	is_chatting=false
	is_roaming=true

func _on_npc_quest_quest_menu_closed() -> void:
	is_chatting=false
	is_roaming=true


func _on_player_stick_collected() -> void:
	$npc_quest.stick_collected()


func _on_player_slime_collected() -> void:
	pass # Replace with function body.


func _on_player_apple_collected() -> void:
	pass # Replace with function body.
