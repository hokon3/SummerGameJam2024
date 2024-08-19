extends Node2D

@export var player : Player
@export var enemy : Enemy
@export var topButton : Button
@export var middleButton : Button
@export var bottomButton : Button
@export var victoryLabel : Label
@export var DeathLabel : Label
@export var playerHealthLabel : Label
@export var enemyHealthLabel : Label
@export var credits : Label
@export var enemyVFX : AnimatedSprite2D
@export var playerVFX : AnimatedSprite2D
@export var musicPlayer : AudioStreamPlayer

var musicTracks = [
	"res://Assets/Music/Pixel Summer.mp3",
	"res://Assets/Music/Shadow Child.mp3",
	"res://Assets/Music/Rise of the Righteous.mp3",
	"res://Assets/Music/Final Dominion.mp3"
]

var game_started = false

var playerHealth = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	musicPlayer.stream = load(musicTracks[0])
	musicPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_top_button_button_down() -> void:
	if (!game_started):
		player.loadNextPlayer()
	else:
		damageEnemy(3 - enemy.current)


func _on_middle_button_button_down() -> void:
	if (!game_started):
		game_started = true
		var attacks = player.attacks[player.current]
		topButton.text = attacks[0]
		middleButton.text = attacks[1]
		bottomButton.text = attacks[2]
		bottomButton.visible = true
		enemyHealthLabel.visible = true
		playerHealthLabel.visible = true
		enemy.visible = true
		musicPlayer.stream = load(musicTracks[enemy.current + 1])
		musicPlayer.play()
		credits.visible = false
	else:
		damageEnemy(randi() % 5)


func _on_bottom_button_button_down() -> void:
	if (DeathLabel.visible || victoryLabel.visible):
		get_tree().reload_current_scene()
	else:
		damageEnemy(enemy.current*2)
	
func disableButtons() -> void:
	topButton.disabled = true
	middleButton.disabled = true
	bottomButton.disabled = true
	
func enableButtons() -> void:
	topButton.disabled = false
	middleButton.disabled = false
	bottomButton.disabled = false
	
func damageEnemy(damage : int) -> void:
	disableButtons()
	var isAlive = enemy.takeDamage(damage)
	enemyHealthLabel.text = "Health: " + str(enemy.health)
	enemyVFX.play("water")
	if (!isAlive):
		var hasNext = enemy.loadNextEnemy()
		if (!hasNext):
			victoryLabel.visible = true
			topButton.visible = false
			middleButton.visible = false
			bottomButton.text = "Restart"
			enemy.visible = false
		else:
			enemyHealthLabel.text = "Health: " + str(enemy.health)
			musicPlayer.stream = load(musicTracks[enemy.current + 1])
			musicPlayer.play()
	else:
		playerHealth -= 1
		playerHealthLabel.text = "Health: " + str(playerHealth)
		playerVFX.play("blood")
		if (playerHealth <= 0):
			DeathLabel.visible = true
			topButton.visible = false
			middleButton.visible = false
			bottomButton.text = "Restart"
	enableButtons()
