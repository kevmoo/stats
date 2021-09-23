## 2.0.1-dev

## 2.0.0

- Require at least Dart 2.12
- Null safety

## 1.0.1

- Allow `package:json_annotation` `v4.x`.

## 1.0.0

- Added `LightStats` class and corresponding extension.
  - Unlike `Stats`, creating `LightStats` does not create and sort a `List` with
    the entire source contents. It is "cheaper" to use, especially with large
    inputs.
- `Stats`
  - Now has a type argument `<T extends num>`.
  - implements `LightStats`.
  - Added `fromSortedList` factory.
  - `standardError` is now an on-demand calculated property instead of a
    field.
  - Renamed `mean` to `average`.
- Added `Iterable<num>` extensions: `lightStats`, `stats`, `min`, `max`, `sum`
  and `average`.
- Require Dart SDK `>=2.7.0 <3.0.0`.

## 0.2.0+3

- Support latest `package:json_annotation`.

## 0.2.0+2

- Support latest `package:json_annotation`.

## 0.2.0+1

- Fix readme.

## 0.2.0

- Initial release.
