extends Node2D


func _on_trigger_entered(body):
	if body.name == "Player":
		$Sprite2D.modulate = Color.MEDIUM_PURPLE
		$Platform.process_mode = Node.PROCESS_MODE_INHERIT
		$Platform/Sprite2D.visible = true
