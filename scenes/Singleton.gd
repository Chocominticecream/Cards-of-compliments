extends Node

var data_cbd


#data for current category + status
var client = ""
var clients = []

#reset this everytime you write a new card
var usedWords = []
var tutorial = true

#reset these after returning to title
var currentClient = 0
var end : bool = false
var score : int = 0
var maxscore : int = 0
# Called when the node enters the scene tree for the first time.

var textures = [ResourceLoader.load("res://assets/graphics/panel_brown.png"), ResourceLoader.load("res://assets/graphics/panel_blue.png")]

var currentCardTexture
var currentOpenTexture

func _ready():
    copyDatabase()
    data_cbd = readDatabase()
    getListofClients()
    SoundManager.play()
    clueWords()
    


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func copyDatabase():
    var original_sql_file = FileAccess.open("res://assets/JameGamData.cdb", FileAccess.READ)
    var original_sql_file_buffer = original_sql_file.get_buffer(original_sql_file.get_length())
    original_sql_file.close()
    
    var dir = DirAccess.open("user://")
    dir.make_dir("data")
    var new_sql_file = FileAccess.open("user://JameGamData.cdb", FileAccess.WRITE)
    new_sql_file.store_buffer(original_sql_file_buffer)
    new_sql_file.close()
    
#read the dataabase
func readDatabase():
     #var data_read 
     #if OS.get_name() == "HTML5":
        ##fix for web versions
        ##not save data so it should be ok
        #data_read =  FileAccess.open("res://assets/gamedata.cdb", FileAccess.READ)
     #else:
     var data_read = FileAccess.open("user://JameGamData.cdb", FileAccess.READ)
     var test_json_conv = JSON.new()
     test_json_conv.parse(data_read.get_as_text())
     var data_cbd = test_json_conv.get_data()
     data_read.close()
     return data_cbd

#using a for loop, this function will find a card or effect in the database using the id value
#returns a dictionary
func findCompliment(word, sheettype, data_cbd = data_cbd):
     var targetentry = null
     var blurb = null
    
     for wordset in usedWords:
         if wordset in word:
            print("word already used!")
            blurb = wordset + " is already used or similar word used!"
            return [targetentry, blurb]
                
     
     for sheet in data_cbd["sheets"]:
         if sheet["name"] == sheettype:
            for entry in sheet["lines"]:
                for newword in entry["word"]:
                  if newword["words"] in word.to_lower():
                     targetentry = entry["writtenText"]
                     for item in entry["word"]:
                         usedWords.append(item["words"])
                
     if targetentry != null:
       blurb = "you found " + word + "!"
     else:
       blurb = word + " is not a related word!"
     return [targetentry, blurb]
    
#finds the amount of words a category has
func findSheetCount(sheettype):
    var count = 0
    for sheet in data_cbd["sheets"]:
         if sheet["name"] == sheettype:
            for entry in sheet["lines"]:
                count += 1
    return count

func getListofClients():
    for sheet in data_cbd["sheets"]:
        clients.append(sheet["name"])
    var removalArray = []
    clients = clients.filter(func(item):
        return "@" not in item and "other" not in item)

func nextClient():
    currentClient += 1
    if clients.size()-1 >= currentClient:
       client = clients[currentClient]
    else:
       end = true

func reset():
    client = clients[0]
    currentClient = 0
    score = 0
    maxscore = 0
    end = false

func grabDescription(client):
    for sheet in data_cbd["sheets"]:
        if sheet["name"] == "other":
          for entry in sheet["lines"]:
            if client == entry["ability"]:
               return entry["description"]

func clueWords():
      var clueArray = []
      for sheet in data_cbd["sheets"]:
         if sheet["name"] == Singleton.client:
            for entry in sheet["lines"]:
                for newword in entry["word"]:
                    clueArray.append(newword["words"])
      clueArray.shuffle()
      for clue in clueArray:
          var stoppingFlag = false
          for usedword in usedWords:
              if clue == usedword:
                 stoppingFlag = true
          if !stoppingFlag:
             var clueSentence = "This word is " + str(clue.length()) + " letters long and begins with " + clue[0] + clue[1]
             EventsBus.emit_signal("spawnBlurb", clueSentence)
             return
            
