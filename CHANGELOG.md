## 3.0.0

- Removed all deprecated members:
  - Removed `LightStats`.
  - `average` renamed to `mean`.
  - Removed `median` everywhere.
- `Stats`: Replaced `standardDeviation` with `sumOfSquares`
- `Stats`: removed type parameter. Added more complexity than it was worth.
- `ConfidenceInterval` now builds *from* a `Stats` instance 
  instead of extending it.
- `Stats` can now be calculated from a `Stream<num>`.
- `Stats.transformer` allows calculating updated stats *on the fly*.

## 2.2.0

- Added confidence internal logic:
  - `ConfidenceInterval` class and `ConfidenceLevel` enum.
  - Added `confidenceInterval` extension to `Iterable<num>`. 
- `Stats`: added `besselCorrection` optional parameter to constructors.
- Added `assert` calls to `LightStats` and `Stats` constructors.
- Changed the type of `LightStats.average` and `Stats.standardDeviation` to 
  `double`.
- Deprecations:
  - `LightStats` will be removed.
  - `average` deprecated in favor of `mean`.
  - `median` deprecated everywhere.
- Require at least Dart 3.7

## 2.1.0

- Export `LightStats`.
- Require at least Dart 3.0

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
