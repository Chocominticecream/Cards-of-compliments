extends Node2D

@onready var writtenText : RichTextLabel = $Open/Greeting
@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var open: Node2D = $Open
@onready var closed: Node2D = $Closed
@onready var audioOpen: AudioStreamPlayer2D = $CardOpen
@onready var audioSlide: AudioStreamPlayer2D = $CardSlide
@onready var audioWrite : AudioStreamPlayer2D = $CardWrite

var currentpos : Vector2
var tween : Tween
var slidingTween : Tween

# Called when the node enters the scene tree for the first time.
func _ready():
    EventsBus.connect("changeWriting", change_Writing)
    currentpos = position
    $Open/Sprite2D.texture = Singleton.currentOpenTexture
    $Closed/Sprite2D.texture = Singleton.currentCardTexture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func change_Writing(text : String):
    writtenText.text = writtenText.text + " " + text + " and"
    audioWrite.play()
    
    
func openCard():
    writtenText.text = "Dear " + Singleton.client + "," + "\n I think you are pretty cool! I like"
    tween = create_tween()
    var shake = 5
    var shake_duration = 0.02
    var shake_count = 20
    for i in shake_count:
        tween.tween_property(self, "position", Vector2(randf_range(-shake, shake)+currentpos.x, randf_range(-shake, shake)+currentpos.y), shake_duration)
    
    await get_tree().create_timer(shake_duration*shake_count).timeout
    closed.visible = false
    open.visible = true
    EventsBus.emit_signal("makeBoxVisible")
    EventsBus.emit_signal("makeSendCardVisible")
    EventsBus.emit_signal("countdown", 61)
    audioOpen.play()
    if Singleton.tutorial:
       EventsBus.emit_signal("showTutorial")

func slideCard():
    slidingTween = create_tween()
    tween = create_tween()
    #starting from 288, -632
    slidingTween.tween_property(self, "position", Vector2(288,10), 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
    tween.tween_property(self, "rotation_degrees", 10, 2.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
    audioSlide.play()
    await get_tree().create_timer(1.2).timeout
    currentpos = position
    openCard()
    
    
