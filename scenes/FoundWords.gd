extends RichTextLabel

var allWords : int = 0 
var foundWords : int = 0: get = foundWordsget, set = foundWordsset 
# Called when the node enters the scene tree for the first time.
func _ready():
    EventsBus.connect("addWords", addWord)
    EventsBus.connect("setWords", setWords)
    

func foundWordsget():
    return foundWords

func foundWordsset(number):
    foundWords = number
    text = "Words Found: " + str(foundWords) + "/" + str(allWords)

func addWord(amount):
    foundWordsset(foundWords+amount)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func setWords():
    allWords = Singleton.findSheetCount(Singleton.client)
    foundWordsset(0)
    
func _process(delta):
    pass
