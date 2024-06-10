extends CanvasLayer

@onready var tutorialNode = $tutorial
var tutorialStep = 0
var tutorial = true

# Called when the node enters the scene tree for the first time.
func _ready():
    EventsBus.connect("showTutorial", show_tutorial)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func _input(event):
   if Input.is_action_just_released("ui_left_click") and tutorial:
       tutorialNode.get_child(tutorialStep).visible = false
       if tutorialStep < 4:
         tutorialStep += 1
         tutorialNode.get_child(tutorialStep).visible = true
       else:
         tutorial = false
         Singleton.tutorial = false
         self.visible = false
 
func show_tutorial():
    tutorial = true
    self.visible = true
    tutorialNode.get_child(tutorialStep).visible = true
