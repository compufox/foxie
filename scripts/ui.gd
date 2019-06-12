extends CanvasLayer

onready var count_label = $container/h_box_container/count

func _process(delta):
	count_label.set_text(str(tracker.pets))