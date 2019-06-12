extends Node

var music = AudioStreamPlayer.new()
var owo = preload("res://music/OWO.ogg")
var pets = 0
var played = false

func _ready():
	music.autoplay = false
	music.stream = owo
	music.connect("finished", self, "music_finished")
	add_child(music)

func play():
	music.play()

func music_finished():
	played = true

func not_playing():
	return not played and not music.playing 