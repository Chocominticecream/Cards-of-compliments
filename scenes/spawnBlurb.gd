extends Control

var blurb = preload("res://scenes/Blurb.tscn").instantiate()
var tween : Tween 

# Called when the node enters the scene tree for the first time.
func _ready():
    EventsBus.connect("spawnBlurb", spawnBlurb)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func spawnBlurb(word : String):
     tween = create_tween()
     var child = blurb.duplicate()
     child.text = word
     add_child(child)
     tween.tween_property(child, "position", child.position+Vector2(0,-35), 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
     await get_tree().create_timer(1.0).timeout
     child.despawn()
     
