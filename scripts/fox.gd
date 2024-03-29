extends Area2D

var happy_eyes  = preload("res://textures/nwn.svg")
var normal_eyes = preload("res://textures/eyes.svg")
var sad_eyes    = preload("res://textures/uwu.svg")

onready var face   = $face setget set_face
onready var eyes   = $eyes
onready var heart  = $heart
onready var flower = $flower
onready var hat    = $hat
onready var blush  = $blush
onready var tear   = $tear
onready var sfx    = $sfx

onready var tree = get_tree()

var pet_time = 0
var sad_time = 0

var being_pet = false

func _process(delta):
	if not tree.paused:
		if being_pet:
			pet_time += delta
		else:
			sad_time += delta
		
		# mf-ing easter egg lol
		if pet_time >= 100 and Tracker.pets == 69 and Tracker.not_playing():
			eyes.set_texture(sad_eyes) 
			Tracker.play()
	
		if pet_time >= 60 and not blush.visible:
			# try to add a tween in here to have it fade in
			blush.show()
		elif pet_time >= 30 and not heart.visible:
			# see above comment
			heart.show()
	
		if being_pet and eyes.texture != happy_eyes and Tracker.not_playing():
			eyes.set_texture(happy_eyes)
			tear.hide()
		elif not being_pet:
			if sad_time > 15:
				eyes.set_texture(sad_eyes)
				tear.show()
			
			if not Tracker.not_playing():
				Tracker.stop()

func _on_fox_collision_entered(body):
	if body.is_in_group("hand"):
		sfx.play()
		being_pet = true
		sad_time = 0
		Tracker.pets += 1

func _on_fox_collision_exited(body):
	if body.is_in_group("hand"):
		being_pet = false
		eyes.set_texture(normal_eyes)
		pet_time = 0
		heart.hide()
		blush.hide()

func show_flower():
	if flower.visible:
		flower.hide()
	else:
		flower.show()

func set_face(face_num):
	face.set_texture(load(Info.faces[face_num]))

func set_hat(hat_num):
	var new_hat = load(Info.hats[hat_num])
	
	# a 'toggle' for the hats
	if hat.get_texture() != new_hat:
		hat.set_texture(new_hat)
	else:
		hat.set_texture(null)