class MathUtils {
  MathUtils._();

  static double clampDouble(double value, double min, double max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  static double lerp(double a, double b, double t) {
    return a + (b - a) * t.clamp(0.0, 1.0);
  }

  static double normalize(double value, double min, double max) {
    if (max == min) return 0;
    return ((value - min) / (max - min)).clamp(0.0, 1.0);
  }

  static double weightedAverage(List<double> values, List<double> weights) {
    if (values.isEmpty || values.length != weights.length) return 0;
    double sum = 0;
    double weightSum = 0;
    for (int i = 0; i < values.length; i++) {
      sum += values[i] * weights[i];
      weightSum += weights[i];
    }
    return weightSum == 0 ? 0 : sum / weightSum;
  }

  static String formatNumber(double value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toStringAsFixed(0);
  }

  static String formatPercent(double value) {
    return '${value.toStringAsFixed(1)}%';
  }

  static String formatCurrency(double value) {
    if (value.abs() >= 1000) {
      return '\$${(value / 1000).toStringAsFixed(1)}B';
    }
    return '\$${value.toStringAsFixed(0)}M';
  }

  static double calculateTrend(List<double> values) {
    if (values.length < 2) return 0;
    return values.last - values[values.length - 2];
  }
}
