## A collection of metadata values for a single [code]ButtonsSelect[/code] option item.
class_name ButtonsSelectItem
extends Resource

## ID of an item. [br]
## [code]name[/code] property of the item [code]Button[/code] will use this value. [br]
## [b]Compared to OptionButton, this is String! Uniqueness is not guaranteed![b]
@export var id: String

## Item text to be displayed. [br]
## [code]text[/code] property of the item [code]Button[/code] will use this value.
@export var text: String

## Item [code]Button[/code] will be created in either disabled or enabled state.
@export var disabled: bool = false


## Allows creation of `ButtonsSelectItem` in a single line:
## [codeblock]
## var item: ButtonsSelectItem = ButtonsSelectItem.new().with_data("OPTION_1", "Option 1")
## [/codeblock]
func with_data(_id: String, _text: String, _disabled: bool = false) -> ButtonsSelectItem:
	id = _id
	text = _text
	disabled = _disabled
	return self
