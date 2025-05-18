extends Control
signal quest_menu_closed
var quest1_active=false
var quest1_completed=false
var quest2_active=false
var quest2_completed=false
var quest3_active=false
var quest3_completed=false
var stick=0
var slime=0
var apple=0

func _ready():
	$quest1_ui.visible = false
	$quest2_ui.visible = false
	$quest3_ui.visible = false
	$no_quest.visible = false
	$finished_quest.visible = false
	
func _process(delta):
	if quest1_active:
		if apple==1:
			print("quest 1 completed")
			quest1_active=false
			quest1_completed=true
			play_finished_quest_anim()
	elif quest2_active:
		if stick==3:
			print("quest 2 completed")
			quest2_active=false
			quest2_completed=true
			play_finished_quest_anim()
	elif quest3_active:
		if slime==5:
			print("quest 3 completed")
			quest3_active=false
			quest3_completed=true
			play_finished_quest_anim()
func quest1_chat():
	$quest1_ui.visible=true
	
func quest2_chat():
	$quest2_ui.visible=true
	
func quest3_chat():
	$quest3_ui.visible=true

func next_quest():
	if !quest1_completed:
		quest1_chat()
	elif !quest2_completed:
		quest2_chat()
	elif !quest3_completed:
		quest3_chat()
	else:
		$no_quest.visible=true
		await get_tree().create_timer(3).timeout
		$no_quest.visible=false
		
func _on_yesbutton_1_pressed() -> void:
	print("quest has started")
	$quest1_ui.visible=false
	quest1_active=true
	apple=0
	emit_signal("quest_menu_closed")

func _on_nobutton_1_pressed() -> void:
	$quest1_ui.visible=false
	quest1_active=false
	emit_signal("quest_menu_closed")

func stick_collected():
	stick+=1
	print("stick for quest")
	
func slime_collected():
	slime+=1
	print("slime for quest")
	
func apple_collected():
	apple+=1
	print("apple for quest")
	
func play_finished_quest_anim():
	$finished_quest.visible=true
	await get_tree().create_timer(3).timeout
	$finished_quest.visible=false

func _on_yesbutton_2_pressed() -> void:
	print("quest has started")
	$quest2_ui.visible=false
	quest2_active=true
	stick=0
	emit_signal("quest_menu_closed")

func _on_nobutton_2_pressed() -> void:
	$quest2_ui.visible=false
	quest2_active=false
	emit_signal("quest_menu_closed")

func _on_yesbutton_3_pressed() -> void:
	print("quest has started")
	$quest3_ui.visible=false
	quest3_active=true
	slime=0
	emit_signal("quest_menu_closed")

func _on_nobutton_3_pressed() -> void:
	$quest3_ui.visible=false
	quest3_active=false
	emit_signal("quest_menu_closed")
