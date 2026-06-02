extends CanvasLayer

@onready var buttons_select: Button = %ButtonsSelect

## Potentially can increase the height of ButtonsSelect. Used in Tests.
@onready var tall_control: ColorRect = %TallControl


func _ready() -> void:
	for mode in ["OFFLINE", "MIX", "ONLINE"]:
		buttons_select.add_item(ButtonsSelectItem.new().with_data(mode, mode))

	buttons_select.select("ONLINE")
	buttons_select.item_selected.connect(on_item_selected)


func on_item_selected(item_id: String) -> void:
	print("Item ID selected: %s" % item_id)
