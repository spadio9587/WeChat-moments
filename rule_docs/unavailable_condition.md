# Unavailable Condition

Use #unavailable instead of #available with an empty body.

* **Identifier:** unavailable_condition
* **Enabled by default:** Yes
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 5.6.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
if #unavailable(iOS 13) {
  loadMainWindow()
}
```

```swift
if #available(iOS 9.0, *) {
  doSomething()
} else {
  legacyDoSomething()
}
```

## Triggering Examples

```swift
if ↓#available(iOS 14.0) {

} else {
  oldIos13TrackingLogic(isEnabled: ASIdentifierManager.shared().isAdvertisingTrackingEnabled)
}
```

```swift
if ↓#available(iOS 14.0) {
  // we don't need to do anything here
} else {
  oldIos13TrackingLogic(isEnabled: ASIdentifierManager.shared().isAdvertisingTrackingEnabled)
}
```

```swift
if ↓#available(iOS 13, *) {} else {
  loadMainWindow()
}
```