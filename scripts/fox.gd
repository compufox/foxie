extends Area2D

var happy_eyes  = preload("res://sprites/nwn.svg")
var normal_eyes = preload("res://sprites/eyes.svg")
var sad_eyes    = preload("res://sprites/uwu.svg")

onready var face = $face
onready var eyes = $eyes
onready var heart = $heart
onready var flower = $flower
onready var hat = $hat
onready var blush = $blush

var pet_time = 0

var being_pet = false

func _process(delta):
	if being_pet:
		pet_time += delta
	
	# mf-ing easter egg lol
	if pet_time >= 100 and tracker.pets == 69 and tracker.not_playing():
		eyes.set_texture(sad_eyes) # actually looks a bit creepy :c
		tracker.play()
	
	if pet_time >= 60 and not blush.visible:
		# try to add a tween in here to have it fade in
		blush.show()
	elif pet_time >= 30 and not heart.visible:
		# see above comment
		heart.show()
	
	if being_pet and eyes.texture != happy_eyes and tracker.not_playing():
		eyes.set_texture(happy_eyes)
	elif not being_pet:
		if not tracker.not_playing():
			tracker.stop()
		
		eyes.set_texture(normal_eyes)
		pet_time = 0
		heart.hide()
		blush.hide()

func _on_fox_collision_entered(body):
	if body.is_in_group("hand"):
		being_pet = true
		tracker.pets += 1

func _on_fox_collision_exited(body):
	if body.is_in_group("hand"):
		being_pet = false