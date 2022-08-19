Provides `BottomAlignedButton` and `DistancedWidgets` widget that helps to place button (or any widget) at the bottom of the screen.

![Example](https://user-images.githubusercontent.com/53380038/185696152-7ad4332c-b31a-40f2-b015-11c164210190.gif)

## Usage

### BottomAlignedButton

Places `child` on top of itself and `button` on bottom. If `child` takes more height than `BottomAlignedButton` itself then `bottom` is moved to end of created list and becomes scrollable with child.

**example:**
```dart
BottomAlignedButton(
  button: ElevatedButton(
    onPressed: () {},
    child: const Text('Sign In'),
  ),
  child: Column(
    children: [
      // some widgets, for example textfield of login form
    ],
  ),
)
```

### DistancedWidgets

Places `top` on top and `bottom` on bottom.
If `top` takes more than `DistancedWidgets` itself then `bottom` is hide.

`onBottomHide` is called after each `RenderObject.performLayout` when `bottom` is not rendering. `onBottomShow` is called after each `RenderObject.performLayout` when `bottom` is rendering

**example:**
```dart
DistancedWidgets(
  top: Column(
    children: [
      // some widgets
    ]
  ),
  bottom: ElevatedButton(
    onPressed: () {},
    child: const Text('Sign In'),
  ),
  onBottomHide: () {},
  onBottomShow: () {},
)
```
