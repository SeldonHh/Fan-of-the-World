extends RichTextLabel

func _process(_delta: float) -> void:
	self.text = "[color=crimson]%s Joules[/color] 
[color=beige](52°C)[/color]
Above regular temperatures"%format_joules(Global.joules)

func format_joules(amount):
	var ftext = str(amount)
	if len(ftext) > 4:
		ftext = ftext.insert(2,".")
	elif len(ftext) > 3:
		ftext = ftext.insert(1,".")
	return ftext
