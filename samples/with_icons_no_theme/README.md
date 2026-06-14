## With Icons No Theme

- While you can set icons more conveniently with themes, it's also possible to avoid them.
- Icons are borrowed from `with_themes` sample. They do not look very fitting, but get the point across.
- Layout is same as `script_setup`, except `Dropdowns` `VBoxContainer` changed to `HBoxContainer`
- Explicit icons are preloaded and set in script using a dedicated `callback: Callable`
- Text alignment for both `ButtonsSelect` and item buttons is set to left.
- Icon alignment for `ButtonsSelect` is set to right to imitate `OptionButton`
- `callback` is set to update the icon of the dropdown to either selected or unselected based on what `ButtonsSelect` will pass to the callback.
- **Minor Caveat**: it is preferable to set `ButtonsSelect` icon before the `add_button` is called to make sure the sizing of `ButtonsSelect` and `buttons` container to stay aligned