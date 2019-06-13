extends CanvasLayer

onready var count_label = $container/h_box_container/count
onready var shop_button = $"container/shop and button/shop_button"
onready var tweener     = $tween

var menu_shown = false

func _process(delta):
	count_label.set_text(str(tracker.pets))
	
	if tracker.pets >= 100 and shop_button.disabled:
		shop_button.get_material().set_shader_param("enabled", true)
		shop_button.disabled = false

func _on_shop_button_pressed():
	if menu_shown:
		hide_shop()
	else:
		show_shop()

func show_shop():
	pass

func hide_shop():
	pass
