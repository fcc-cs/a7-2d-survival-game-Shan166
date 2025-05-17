extends Node2D
@onready var animplayer=$world2openingcutscene/AnimationPlayer
var is_openingcutscene=false
var has_player_entered_area=false
var player=null

func _on_player_detection_body_entered(body):
	if body.has_method("player"):
		player=body
		if !has_player_entered_area:
			has_player_entered_area=true
			cutsceneopening()
			
func cutsceneopening():
	is_openingcutscene=true
	animplayer.play("cover_fade")
	player.camera.enabled=false
	
