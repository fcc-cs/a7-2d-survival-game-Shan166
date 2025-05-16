extends StaticBody2D
func _ready():
	fallfromtree()
	
func fallfromtree():
	$AnimationPlayer.play("Apple_Falling")
	await get_tree().create_timer(1.5).timeout
	$AnimationPlayer.play("Fade_Animation")
	print("+1 apple")
	await get_tree().create_timer(0.3).timeout
	queue_free()
