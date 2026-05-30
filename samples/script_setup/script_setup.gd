extends CanvasLayer

@onready var dropdowns: VBoxContainer = %Dropdowns


func _ready() -> void:
	var keys_1: Array[String] = ["OPTION_1", "OPTION_2", "OPTION_3"]
	add_dropdown(keys_1)

	var keys_2: Array[String] = ["ANOTHER_OPTION_1", "SHORT_OPT_2", "THIRD_OPTION_3"]
	add_dropdown(keys_2)

	var keys_3: Array[String] = ["EASY", "MEDIUM", "HARD", "EXTREME", "IMPOSSIBLY_UNFAIR"]
	add_dropdown(keys_3)


func add_dropdown(keys: Array[String]) -> void:
	var dropdown = ButtonsSelect.new()
	dropdowns.add_child(dropdown)

	for key in keys:
		var txt = " ".join((key.split("_") as Array[String]).map(func(x): return x.to_pascal_case()))
		var data := ButtonsSelectItem.new().with_data(key, txt)
		dropdown.add_item(data)

	dropdown.select(keys[0])
	dropdown.item_selected.connect(on_item_selected)


func on_item_selected(item_id: String) -> void:
	print("Item ID selected: %s" % item_id)
