extends CanvasLayer

onready var count_label = $container/h_box_container/count
onready var shop_button = $"container/shop and button/shop_button"
onready var tweener     = $tween
onready var shop_shown  = $container/shop_shown
onready var shop_hidden = $container/shop_hidden
onready var shop        = $"container/shop and button"
onready var fox         = get_tree().root.find_node("fox", true, false)

var menu_shown = false

func _ready():
	var counter = 0
	
	
	for item in $"container/shop and button/shop_bg/scroll_container/shop/".get_children():
		item.get_node("button").connect("pressed", self, 
		                                "_shop_item_selected",
		                                [counter, Info.prices[counter]])
		counter += 1

# warning-ignore:unused_argument
func _process(delta):
	count_label.set_text(str(Tracker.pets))

func _on_shop_button_pressed():
	if menu_shown:
		hide_shop()
	else:
		show_shop()

func show_shop():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
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
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
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


# warning-ignore:unused_argument
func _on_tween_completed(object, key):
	if object == shop and menu_shown:
		get_tree().paused = true

func _shop_item_selected(item_num, item_price):
	# 1-15 are faces,
	# 17-NaN are hats
	# 16 is the flower, which is already there but hidden
	
	if Tracker.pets >= item_price:
		if item_num < 17:
			fox.set_face(item_num)
		elif item_num == 17:
			fox.show_flower()
		elif item_num > 17:
			fox.set_hat(item_num - 18)