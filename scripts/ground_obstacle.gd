extends Area2D


signal ground_hit


func _on_groundbody_entered(body: Node2D) -> void:
	ground_hit.emit()
	print("area entered!")
