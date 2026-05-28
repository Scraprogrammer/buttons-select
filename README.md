# ButtonsSelect

A simplified alternative to Godot's `OptionButton`.

## How to use

Copy the `addons/buttons_select` folder into your project. 
You should now be able to see `ButtonsSelect` as one of the `Button` control variations when adding nodes in the editor.

See provided `samples` and their `README.md` files for more usage examples.

## Rationalization

While `OptionButton` is perfectly usable and handles a lot more use cases compared to this control, it has some issues.
Disregarding the 64 open issues that mention `OptionButton` in the Godot Engine Github at the time of writing this, 
the ones I personally encountered and which `ButtonsSelect` aims to alleviate are:

- Limited access to the `PopupMenu` node that contains selectable items, making it less convenient to customize.
- Item IDs being `int`, making the selection values less readable and less convenient when you want to use `String` key values.
- `PopupMenu` being hard-set to layer `1024`.
	- e.g. if you want to have a customizable cursor, you'd need to put it on layer 1025+ to visualize above the `PopupMenu`.
- Inability to add child nodes to each individual item in the `PopupMenu`.
	- e.g. in case you want to customize each individual item with a custom child component.

## TODOs

- Add more samples to cover more use cases
- Add more tests
- Check what reasonable functionality is missing in `ButtonsSelect` compared to `OptionButton` and consider implementing it.
- Better handling of `OptionButton` horizontal size when it has an icon.
	- Depending on the size of the icon that is used for both dropdown and parent buttons, dropdown and parent button size can become misaligned.
- Better positioning of dropdown under the `OptionButton`
	- Currently, `align_position` can be called explicitly if e.g. `OptionButton` changes position and dropdowns position must be re-aligned.
	- Ideally - this should be detected and handled automatically.

## Credits

- Godot Engine: https://godotengine.org/license/
- Godot Engine 3rd Party Licenses: [GODOT_COPYRIGHT.txt](GODOT_COPYRIGHT.txt)
- gdUnit4: https://github.com/godot-gdunit-labs/gdUnit4/blob/master/LICENSE