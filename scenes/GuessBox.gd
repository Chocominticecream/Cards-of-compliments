extends LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func GuessWord():
    #to be changed to dynamically include other stuff
    return Singleton.findCompliment(text, Singleton.client)

func _input(event):
    if Input.is_action_just_pressed("ui_accept") and editable:
       var word = GuessWord()
       if word[0] != null:
         EventsBus.emit_signal("changeWriting", word[0])
         EventsBus.emit_signal("addWords", 1)
       EventsBus.emit_signal("spawnBlurb", word[1])
       clear()


func _on_enter_pressed():
       var word = GuessWord()
       if word[0] != null:
         EventsBus.emit_signal("changeWriting", word[0])
         EventsBus.emit_signal("addWords", 1)
       EventsBus.emit_signal("spawnBlurb", word[1])
       clear()
