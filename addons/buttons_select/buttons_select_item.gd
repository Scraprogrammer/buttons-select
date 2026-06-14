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

## A callback that will be called on the item button to customize its properties. [br]
## Used when [code]add_button[/code] or [code]select[/code] is called on a [code]ButtonsSelect[/code]. [br]
## Expected callback function format: [code]func(btn: Button, is_selected: bool) -> void:[/code] [br]
## When a button is created, [code]callback[/code] is called with [code]is_selected[/code] set as [code]false[/code].
@export var callback: Callable = Callable()


## Allows creation of `ButtonsSelectItem` in a single line:
## [codeblock]
## var item: ButtonsSelectItem = ButtonsSelectItem.new().with_data("OPTION_1", "Option 1")
## [/codeblock]
func with_data(
	_id: String, _text: String, _disabled: bool = false, _callback: Callable = Callable()
) -> ButtonsSelectItem:
	id = _id
	text = _text
	disabled = _disabled
	callback = _callback
	return self
