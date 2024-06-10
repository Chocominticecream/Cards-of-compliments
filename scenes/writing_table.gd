extends Node2D

@onready var card = $GreetingCard
@onready var guessbox = $GuessBox
@onready var winScreen = $WinScreen
@onready var foundWords = $FoundWords
@onready var countdown = $CountDown
@onready var sendCard = $SendCard
@onready var ability = $Ability
@onready var title = $TitleScreenGroup

# Called when the node enters the scene tree for the first time.
func _ready():
    EventsBus.connect("makeBoxVisible", makeBoxVisible)
    EventsBus.connect("makeSendCardVisible", makeSendCardVisible)
    EventsBus.emit_signal("setWords")
    card.slideCard()
    foundWords.visible = true
    ability.visible = true
    


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func makeBoxVisible():
    guessbox.visible = true

func makeSendCardVisible():
    sendCard.visible = true
    
#deprecated
func _on_timer_timeout():
    pass


func _on_texture_button_pressed():
    title.visible = false


func _on_send_card_pressed():
    guessbox.editable = false
    winScreen.foundWords = foundWords.foundWords
    winScreen.maxWords = foundWords.allWords
    winScreen.winPuzzle()


func _on_clue_pressed():
    Singleton.clueWords()
