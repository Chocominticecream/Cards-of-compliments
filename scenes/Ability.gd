extends RichTextLabel
 
# Called when the node enters the scene tree for the first time.
func _ready():
    EventsBus.connect("setAbility", setAbility)
    setAbility()
    
#this is soooo stupid
func setAbility():
    if Singleton.client == "plumber":
       text = "[right]ability: plumbing"
    elif Singleton.client == "chef":
       text = "[right]ability: cooking"
