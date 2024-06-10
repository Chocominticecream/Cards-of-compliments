extends CanvasLayer

@onready var animation = $AnimationPlayer
@onready var resultingText = $Results
@onready var success = $SuccessJingle
var maxWords = 0
var foundWords = 0
# Called when the node enters the scene tree for the first time.
func _ready():
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func processResults():
    var winningText = ""
    var resultsText = ""
    var winFactor
    Singleton.score += foundWords
    Singleton.maxscore += maxWords
    
    if foundWords > 8:
       winningText = "The card you written was beautiful, the " + Singleton.client + " LOVES it!"
    elif foundWords > 5:
       winningText = "This card really made the " + Singleton.client + "'s day! Nice work!"
    elif foundWords > 2:
       winningText = Singleton.client + " was very happy to recieve your card!"
    else:
       winningText = "Its the thought that counts!"
    
    resultsText = "[center]Results!\n" + str(foundWords) + "/" + str(maxWords) + "\n" + winningText
    
    return resultsText
    
func winPuzzle():
    animation.play("transition")
    resultingText.text = processResults()
    Singleton.nextClient()
    Singleton.usedWords.clear()
    success.play()


func _on_texture_button_pressed():
    if !Singleton.end:
       get_tree().change_scene_to_file("res://scenes/SelectCard.tscn")
    else:
       get_tree().change_scene_to_file("res://scenes/Epilouge.tscn")
