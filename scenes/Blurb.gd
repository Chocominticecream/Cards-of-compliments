extends RichTextLabel

@onready var animation : AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func despawn():
    animation.play("fade")
    await get_tree().create_timer(1.0).timeout
    self.queue_free()
