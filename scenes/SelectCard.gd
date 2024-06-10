extends Node2D
@onready var descGroup = $DescriptionGroup
@onready var cardGroup = $CardSelectGroup
@onready var description = $DescriptionGroup/description

# Called when the node enters the scene tree for the first time.
func _ready():
    description.text = Singleton.grabDescription(Singleton.client)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_texture_button_pressed():
    descGroup.visible = false
    cardGroup.visible = true


func _on_greeting_card_button_pressed():
    Singleton.currentCardTexture = ResourceLoader.load("res://assets/graphics/greetingcard1.png")
    Singleton.currentOpenTexture =  ResourceLoader.load("res://assets/graphics/openCard1.png")


func _on_greeting_card_button_2_pressed():
    Singleton.currentCardTexture = ResourceLoader.load("res://assets/graphics/greetingcard2.png")
    Singleton.currentOpenTexture =  ResourceLoader.load("res://assets/graphics/openCard2.png")
