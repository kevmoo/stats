import 'confidence_level.dart';

const biggestSpecifiedDF = 120;

double calcTScore(int degreesOfFreedom, ConfidenceLevel confidenceLevel) {
  if (degreesOfFreedom < 1) {
    throw ArgumentError.value(
      degreesOfFreedom,
      'degreesOfFreedom',
      'Degrees of freedom must be at least 1.',
    );
  }
  final scores = confidenceLevel.scores;

  // Check for exact match
  if (scores.containsKey(degreesOfFreedom)) {
    return scores[degreesOfFreedom]!;
  }

  if (degreesOfFreedom > biggestSpecifiedDF) {
    return confidenceLevel.infinityValue;
  }

  // Find bracketing degrees of freedom for interpolation
  int? lowerDf;
  int? upperDf;

  for (final dfKey in scores.keys) {
    if (dfKey < degreesOfFreedom) {
      lowerDf = dfKey;
    } else if (dfKey > degreesOfFreedom) {
      upperDf = dfKey;
      break; // Found the upper bracket
    }
    // If dfKey == degreesOfFreedom, it would have been caught by the exact
    // match check earlier
  }

  if (lowerDf != null && upperDf != null) {
    final lowerScore = scores[lowerDf]!;
    final upperScore = scores[upperDf]!;

    // Linear interpolation:
    // score = y1 + (x - x1) * (y2 - y1) / (x2 - x1)
    final tScore =
        lowerScore +
        (degreesOfFreedom - lowerDf) *
            (upperScore - lowerScore) /
            (upperDf - lowerDf);
    return tScore;
  }

  // If no suitable brackets found (e.g., df is larger than any specific df but
  // less than infinity threshold, or some other unexpected state).
  // This part of the logic might need refinement based on table structure.
  // Given the check for `degreesOfFreedom >= largestSpecificDf` earlier, this
  // path should ideally be for cases where df is within the range of sortedDfs
  // but bracketing failed.
  throw ArgumentError.value(
    degreesOfFreedom,
    'degreesOfFreedom',
    'Cannot interpolate t-score for df=$degreesOfFreedom at '
        'CL=${confidenceLevel.name}. '
        'Check table data or consider using a statistical library for more '
        'precision.',
  );
}
