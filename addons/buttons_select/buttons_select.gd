## A simplified replacement for [code]OptionButton[/code], where every item is a separate [code]Button[/code]. [br]
## All item buttons are located in a separate accessible [code]CanvasLayer[/code]. [br]
## Nodes structure: [kbd]Node: Type[/kbd]
## [codeblock]
## - root: Window
##    - ** # Any depth in the nodes tree
##       - ButtonsSelect: Button
##    - Layer: CanvasLayer
##        - Buttons: VBoxContainer
##           - Button1: Button
##           - Button2: Button
##           - Button3: Button
## [/codeblock]
class_name ButtonsSelect
extends Button

## Emitted when an item is selected.
signal item_selected(item_id: String)

## ID of the selected item can be retrieved by calling [code]get_meta[/code] on the [code]ButtonsSelect[/code].
## Use this value as the [code]name[/code] parameter.
## [codeblock]
## var id: String = buttons_select.get_meta(buttons_select.SELECTED_ID)
## [/codeblock]
const SELECTED_ID = "SELECTED_ID"

## Metadata that is used to create item buttons. [br]
## Buttons are created in [code]_enter_tree[/code].
@export var items: Array[ButtonsSelectItem]

## [code]layer[/code] of a separate [code]CanvasLayer[/code] where buttons are created. [br]
## If not set - set to 1 layer higher compared to the layer where [code]ButtonsSelect[/code] is located.
@export var items_layer: int

## Separation in pixels between item buttons.
@export var items_separation: int = 0

## Separation in pixels between [code]ButtonsSelect[/code] and first item button.
@export var parent_separation: int = 0

## Theme Type Variation that will be used by selected item [code]Button[/code] node. [br]
## Must be created in the theme and [code]Button[/code] set as a [code]Base Type[/code].
@export var selected_item_theme_variation: String

## Theme Type Variation that will be used by unselected item [code]Button[/code] nodes. [br]
## Must be created in the theme and [code]Button[/code] set as a [code]Base Type[/code].
@export var unselected_item_theme_variation: String

## If true, each item [code]Button[/code] will receive a duplicate
## of each child node of the [code]ButtonsSelect[/code]. [br]
## Useful when base button logic or behavior is modified by standalone components which are added as child nodes.
@export var inherit_children: bool = false

## If true, pressing on the [code]ButtonsSelect[/code] will not only show the items,
## but will also grab the focus of the first item in the list. [br]
## While the list is open - the built-in focus switch will only work between item buttons. [br]
## When an item is selected - [code]ButtonsSelect[/code] focus will be grabbed.
@export var handle_focus: bool = false

## Because Godot Editor/GDScript currently lacks support for nullable values,
## [code]items_layer[/code] value will default to 0 and will be overwritten by parent layer+1 value. [br]
## Check this if you want the buttons [code]CanvasLayer[/code] to be on [code]layer[/code] 0.
@export var use_layer_0: bool = false

## A separate [code]CanvasLayer[/code] is added for each rendered [code]ButtonsSelect[/code]
## and holds all the item [code]Button[/code] nodes. [br]
## This is done to ensure proper positioning of the buttons so they would not interfere with other nodes.
var layer: CanvasLayer

## The [code]VBoxContainer[/code] within the [code]CanvasLayer[/code] that holds all the item [code]Button[/code] nodes.
var buttons: VBoxContainer


# Creates item buttons, parent layer, and container.
# Each Button uses the same theme and material as the `ButtonsSelect`.
# Using `_enter_tree` instead of `_ready` because need to handle `_exit_tree`,
# since there is a chance `ButtonsSelect` might re-enter the tree again.
func _enter_tree() -> void:
	initialize_items_layer()

	for item in items:
		add_item(item)

	self.icon_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	self.get_tree().root.add_child.call_deferred(layer)
	self.pressed.connect(on_buttons_select_pressed)


## Shows or hides the buttons [code]CanvasLayer[/code]. [br]
## If focus should be handled - grabs either the [code]ButtonsSelect[/code] focus,
## or the focus of the first item [code]Button[/code].
func on_buttons_select_pressed() -> void:
	if handle_focus:
		(self if layer.visible else buttons.get_child(0)).grab_focus()
	layer.visible = !layer.visible


## Initializes the [code]CanvasLayer[/code] and [code]VBoxContainer[/code] for the item [code]Button[/code] nodes.
func initialize_items_layer() -> void:
	layer = CanvasLayer.new()
	layer.name = self.name + "Layer"
	var parent_layer := self.get_canvas_layer_node()
	layer.layer = (
		0 if use_layer_0 else (items_layer if items_layer else (parent_layer.layer + 1 if parent_layer else 1))
	)
	layer.visible = false

	buttons = VBoxContainer.new()
	buttons.name = "Buttons"
	buttons.add_theme_constant_override("separation", items_separation)
	layer.add_child(buttons)
	buttons.tree_entered.connect(align_position)


## When buttons [code]VBoxContainer[/code] enters the tree,
## it waits for 1 frame for both it and [code]ButtonsSelect[/code] to be rendered. [br]
## Then adjusts its global position to be under the [code]ButtonsSelect[/code]. [br]
## Also makes sure that [code]ButtonsSelect[/code] has the same width as the buttons [code]VBoxContainer[/code]
## to account for different width of based on buttons texts.
func align_position() -> void:
	await get_tree().process_frame  # Wait 1 frame for the control to render and have its global_position set.
	buttons.global_position = self.global_position + Vector2(0, self.size.y + parent_separation)
	self.custom_minimum_size.x = buttons.size.x


## Adds an item [code]Button[/code] to the buttons container.[br]
## Item is also added to the [code]items[/code] array if it has no item with the same ID.
func add_item(item: ButtonsSelectItem) -> Button:
	var btn := Button.new()
	btn.name = item.id
	btn.text = item.text
	btn.disabled = item.disabled
	btn.theme = self.theme
	btn.material = self.material
	btn.alignment = self.alignment
	btn.pressed.connect(select.bind(item.id, false))
	btn.theme_type_variation = unselected_item_theme_variation
	buttons.add_child(btn)
	if inherit_children:
		for child in self.get_children():
			btn.add_child.call_deferred(child.duplicate())
	if not items.any(func(m) -> bool: return m.id == item.id):
		items.append(item)
	return btn


## Selects an item by its ID. [br]
## Updates the text on the [code]ButtonsSelect[/code],
## sets the selected ID as the [code]ButtonsSelect[/code] metadata,
## emits the [code]item_selected[/code] signal with the selected item ID,
## and hides the buttons layer. [br]
## [code]send_signal[/code] is [code]false[/code] by default,
## since you if this is called explicitly - selected ID should already be known.
func select(id: String, send_signal: bool = false) -> void:
	var selected := items.filter(func(m) -> bool: return m.id == id)

	if selected.is_empty():
		push_error("Item with ID '%s' not found for ButtonsSelect '%s'" % [id, self.name])
		return

	if selected.size() > 1:
		push_error("More than 1 item with ID '%s' found for ButtonsSelect '%s'" % [id, self.name])
		return

	self.text = selected[0].text
	self.set_meta(SELECTED_ID, selected[0].id)
	layer.visible = false

	if handle_focus:
		self.grab_focus()

	if send_signal:
		item_selected.emit(id)

	for item in buttons.get_children():
		item.theme_type_variation = (
			selected_item_theme_variation if item.name == id else unselected_item_theme_variation
		)


## Removes an item from the buttons container and items array by its ID.
func remove_item(id: String) -> void:
	var found = items.filter(func(m) -> bool: return m.id == id)
	for item in found:
		items.erase(item)

	for item in buttons.get_children():
		if item.name == id:
			buttons.remove_child(item)
			item.free()


## Removes and frees all item buttons and clears the items array. [br]
## No changes are made to [code]ButtonsSelect[/code].
func remove_all_items() -> void:
	items.clear()

	for button in buttons.get_children():
		buttons.remove_child(button)
		button.free()


# Frees the buttons `CanvasLayer` when parent button exits a scene tree.
func _exit_tree() -> void:
	layer.queue_free()


# Detect presses outside of the buttons to hide the buttons layer.
# This prevents multiple dropdowns from being open at the same time.
func _input(event: InputEvent) -> void:
	if (
		layer.visible
		and event is InputEventMouseButton
		and event.button_index == MOUSE_BUTTON_LEFT
		and event.pressed
		and event.position
		and not buttons.get_global_rect().has_point(event.position)
	):
		layer.visible = false
