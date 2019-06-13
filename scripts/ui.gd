extends CanvasLayer

onready var count_label = $container/h_box_container/count
onready var shop_button = $"container/shop and button/shop_button"
onready var tweener     = $tween
onready var shop_shown  = $container/shop_shown
onready var shop_hidden = $container/shop_hidden
onready var shop        = $"container/shop and button"

var menu_shown = false

func _process(delta):
	count_label.set_text(str(tracker.pets))
	
	if tracker.pets >= 10 and shop_button.disabled:
		shop_button.get_material().set_shader_param("enabled", true)
		shop_button.disabled = false

func _on_shop_button_pressed():
	
	print(shop_hidden.position)
	print(shop_shown.position)
	if menu_shown:
		hide_shop()
	else:
		show_shop()

func show_shop():
	tweener.interpolate_property(shop, "rect_position",
	                             shop_hidden.position,
	                             shop_shown.position,
	                             1.5,
	                             Tween.TRANS_QUAD,
	                             Tween.EASE_IN_OUT)
	tweener.interpolate_property(shop_button, "rect_rotation",
	                             0,
	                             180,
	                             1.5,
	                             Tween.TRANS_LINEAR,
	                             Tween.EASE_OUT)
	tweener.start()
	menu_shown = true

func hide_shop():
	tweener.interpolate_property(shop, "rect_position",
	                             shop_shown.position,
	                             shop_hidden.position,
	                             1.5,
	                             Tween.TRANS_QUAD,
	                             Tween.EASE_IN_OUT)
	tweener.interpolate_property(shop_button, "rect_rotation",
	                             180,
	                             0,
	                             1.5,
	                             Tween.TRANS_LINEAR,
	                             Tween.EASE_OUT)
	
	tweener.start()
	menu_shown = false
	get_tree().paused = false


func _on_tween_completed(object, key):
	if object == shop and menu_shown:
		get_tree().paused = true
