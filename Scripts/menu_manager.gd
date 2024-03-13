extends Control

@export var animator: AnimationPlayer


func _on_start_btn_pressed():
	animator.play("hide_menu")


func _on_how_to_play_btn_pressed():
	animator.play("show_howto")


func _on_back_btn_pressed():
	animator.play("hide_howto")


func _on_reset_btn_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu_level.tscn")
