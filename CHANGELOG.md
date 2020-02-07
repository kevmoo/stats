## 1.0.0

- Added `LightStats` class and corresponding extension.
  - Unlike `Stats`, creating `LightStats` does not create and sort a `List` with
    the entire source contents. It is "cheaper" to use, especially with large
    inputs.
  - `Stats` implements `LightStats`.
- Added `Stats.fromSortedList` factory.
- `Stats.standardError` is now an on-demand calculated property instead of a
  field.
- Renamed `mean` to `average` on `Stats` class.
- Added `stats` extension property to `Iterable<num>`.
- Require Dart SDK `>=2.7.0 <3.0.0`.

## 0.2.0+3

- Support latest `package:json_annotation`.

## 0.2.0+2

- Support latest `package:json_annotation`.

## 0.2.0+1

- Fix readme.

## 0.2.0

- Initial release.
