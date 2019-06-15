extends Node

onready var bg_music = get_tree().root.find_node("music", true, false)

var music = AudioStreamPlayer.new()
var owo = preload("res://music/OWO.ogg")
# warning-ignore:unused_class_variable
var pets = 0
var played = false

func _ready():
	music.set_bus("easter egg")
	music.autoplay = false
	music.stream = owo
	music.connect("finished", self, "music_finished")
	add_child(music)

func play():
	bg_music.set_stream_paused(true)
	music.play()

func stop():
	bg_music.set_stream_paused(false)
	music.stop()

func music_finished():
	bg_music.set_stream_paused(false)
	played = true

func not_playing():
	return not played and not music.playing 