import 'dart:math';

class RandomUtils {
  static final Random _random = Random();

  RandomUtils._();

  static int nextInt(int max) => _random.nextInt(max);

  static double nextDouble() => _random.nextDouble();

  static bool chance(double probability) => _random.nextDouble() < probability;

  static double range(double min, double max) {
    return min + _random.nextDouble() * (max - min);
  }

  static int rangeInt(int min, int max) {
    if (min >= max) return min;
    return min + _random.nextInt(max - min);
  }

  static T pick<T>(List<T> list) {
    if (list.isEmpty) throw ArgumentError('Cannot pick from empty list');
    return list[_random.nextInt(list.length)];
  }

  static List<T> pickMultiple<T>(List<T> list, int count) {
    if (count >= list.length) return List.from(list);
    final shuffled = List<T>.from(list)..shuffle(_random);
    return shuffled.take(count).toList();
  }

  static T weightedPick<T>(List<T> items, List<double> weights) {
    double total = weights.fold(0.0, (sum, w) => sum + w);
    double roll = _random.nextDouble() * total;
    double cumulative = 0;
    for (int i = 0; i < items.length; i++) {
      cumulative += weights[i];
      if (roll <= cumulative) return items[i];
    }
    return items.last;
  }

  static double gaussianRange(double min, double max) {
    final u1 = _random.nextDouble();
    final u2 = _random.nextDouble();
    final normal = sqrt(-2 * log(u1)) * cos(2 * pi * u2);
    final value = (min + max) / 2 + normal * (max - min) / 6;
    return value.clamp(min, max);
  }
}
