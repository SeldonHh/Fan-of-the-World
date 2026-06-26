extends Control
@onready var bg: TextureRect = %BG
@onready var button_container: VBoxContainer = $book_bg/Button_container
@onready var question: AutoSizeRichTextLabel = $book_bg/question
@onready var button_1: AutoSizeButton = $book_bg/Button_container/button1
@onready var button_2: AutoSizeButton = $book_bg/Button_container/button2
@onready var button_3: AutoSizeButton = $book_bg/Button_container/button3
@onready var price: AutoSizeLabel = $book_bg/price
@onready var correct: AudioStreamPlayer = $correct
@onready var wrong: AudioStreamPlayer = $wrong
@onready var notif_sfx: AudioStreamPlayer = $notif_sfx

var stop_shii := false
var able_to_answer := false
var question_index := 0
var joule_requirements := [99998,99000,92000,75000,40000,20000]
var joule_price := [100,1000,3000,5000,7000,10000]
var questions := ["How many trees are destroyed each year?","How many watts is used by an average fan every hour?","What is this game","How many degrees can the planet warm up before it's basically inhospitable?","What's the max temperature a human can live in indefinitely with infinite water?","Be honest, did you make the cat happy?"]
var answer1 := ["5.2 billion","75","A masterpiece","52°C (96°F)","35°C (65°F)","Yes"]
var answer2 :=["2.8 billion","120","A Very Serious Game","8°C (14.4°F)","38°C (68.4°F)","No"]
var answer3 :=["15 billion",'40',"A fan ?","17°C (30.6°F)","42°C (75.6°F)","You can make the cat happy?"]
var correct_answer :=[3,1,2,2,1,1]
const BOOK_IMPORTANT = preload("uid://bsenpcmp8weut")
const BOOK = preload("uid://pj01bcwrwlub")

func _on_exit_pressed() -> void:
	Global.stop_lowering_joules = false
	Global.book.texture_normal = BOOK
	self.hide()

func _process(_delta: float) -> void:
	self.modulate = bg.modulate
	if !stop_shii:
		if !able_to_answer:
			price.hide()
			for child in button_container.get_children():
				child.disabled = true
				child.button_text = ""
			question.text = "Temperatures must go down to %s joules for next question"%joule_requirements[question_index]
			if Global.joules <= joule_requirements[question_index]:
				able_to_answer = true
				Global.book.texture_normal = BOOK_IMPORTANT
				notif_sfx.play()
		else:
			price.show()
			question.text = questions[question_index]
			price.text = "For %s Joules"%joule_price[question_index]
			button_1.button_text = answer1[question_index]
			button_2.button_text = answer2[question_index]
			button_3.button_text = answer3[question_index]
			button_1.disabled = false
			button_2.disabled = false
			button_3.disabled = false

func _on_button_1_pressed() -> void:
	if able_to_answer:
		if correct_answer[question_index] == 1:
			Global.stop_lowering_joules = false
			Global.lower_joules(joule_price[question_index])
			Global.stop_lowering_joules = true
			correct.play()
		else:
			wrong.play()
		able_to_answer = false
		question_index += 1
		if question_index > len(questions):
			stop()

func _on_button_2_pressed() -> void:
	if able_to_answer:
		if correct_answer[question_index] == 2:
			Global.stop_lowering_joules = false
			Global.lower_joules(joule_price[question_index])
			Global.stop_lowering_joules = true
			correct.play()
		else:
			wrong.play()
		able_to_answer = false
		question_index += 1
		if question_index > len(questions):
			stop()

func _on_button_3_pressed() -> void:
	if able_to_answer:
		if correct_answer[question_index] == 3:
			Global.stop_lowering_joules = false
			Global.lower_joules(joule_price[question_index])
			Global.stop_lowering_joules = true
			correct.play()
		else:
			wrong.play()
		able_to_answer = false
		question_index += 1
		if question_index > len(questions):
			stop()

func stop():
	stop_shii = true
	button_1.disabled = true
	button_2.disabled = true
	button_3.disabled = true
	question.text = "You answered all the questions"
