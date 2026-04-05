import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/calorie_calculator.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.historyAndProgress),
        leading: BackButton(
          onPressed: () {
            if (context.mounted) {
              context.go('/');
            }
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Weekly'),
            Tab(text: 'Monthly'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPeriodView('week', l10n),
          _buildPeriodView('month', l10n),
        ],
      ),
    );
  }

  Widget _buildPeriodView(String period, AppLocalizations l10n) {
    final now = DateTime.now();
    final startDate = period == 'week'
        ? now.subtract(const Duration(days: 7))
        : now.subtract(const Duration(days: 30));

    final settingsBox = Hive.box('settings');
    final currentId =
        settingsBox.get('current_profile_id', defaultValue: 'main');
    final surveyBox = Hive.box('survey_$currentId');
    final foodLogsBox = Hive.box('foodLogs_$currentId');

    // Redirect if no survey data for this profile
    final bool completed = surveyBox.get('completed', defaultValue: false);
    if (!completed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.takeSurveyDesc)),
          );
          context.go('/survey');
        }
      });

      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(l10n.takeSurveyDesc,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      );
    }

    double target = 2000.0;
    if (completed) {
      target = calculateDailyTarget(
        age: surveyBox.get('age', defaultValue: 30),
        gender: surveyBox.get('gender', defaultValue: 'Other'),
        heightCm: surveyBox.get('heightCm', defaultValue: 170.0),
        weightKg: surveyBox.get('weightKg', defaultValue: 70.0),
        activityLevel:
            surveyBox.get('activityLevel', defaultValue: 'Sedentary'),
        goal: surveyBox.get('goal', defaultValue: 'Maintain weight'),
      );
    }

    final Map<String, double> dailyCalories = {};

    for (var entry in foodLogsBox.values) {
      if (entry is Map &&
          entry.containsKey('date') &&
          entry.containsKey('calories')) {
        final String dateStr = entry['date'] as String;
        final DateTime logDate = DateFormat('yyyy-MM-dd').parse(dateStr);
        if (!logDate.isBefore(startDate)) {
          final double cal = ((entry['calories'] as num?)?.toDouble() ?? 0.0) *
              ((entry['quantity'] as num?)?.toDouble() ?? 1.0);
          dailyCalories.update(
            dateStr,
            (value) => value + cal,
            ifAbsent: () => cal,
          );
        }
      }
    }

    final List<String> dates = [];
    final List<double> calories = [];
    final List<Color> pointColors = [];

    DateTime current = startDate;
    while (!current.isAfter(now)) {
      final String dateKey = DateFormat('yyyy-MM-dd').format(current);
      final double cal = dailyCalories[dateKey] ?? 0.0;
      dates.add(DateFormat('MMM d').format(current));
      calories.add(cal);

      if (cal > target * 1.1) {
        pointColors.add(Colors.red);
      } else if (cal < target * 0.9) {
        pointColors.add(Colors.green);
      } else {
        pointColors.add(Colors.orange);
      }

      current = current.add(const Duration(days: 1));
    }

    if (calories.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.no_food, size: 80, color: Colors.grey[400]),
              const SizedBox(height: 24),
              Text(
                'No data for this period yet',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Log some meals to see your progress!',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final double avgDaily = calories.reduce((a, b) => a + b) / calories.length;
    final double totalActual = calories.reduce((a, b) => a + b);
    final double totalTarget = target * dates.length;

    final String summaryTitle =
        period == 'week' ? 'Weekly Average' : 'Monthly Average';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _SummaryCard(
                title: summaryTitle,
                value: '${avgDaily.toStringAsFixed(0)} kcal',
                icon: Icons.trending_up,
                color: avgDaily > target
                    ? Colors.red
                    : (avgDaily < target ? Colors.green : Colors.orange),
              ),
              _SummaryCard(
                title: 'Target / Day',
                value: '${target.toStringAsFixed(0)} kcal',
                icon: Icons.track_changes,
                color: Colors.blue,
              ),
            ],
          ),

          const SizedBox(height: 24),

          Text(
            period == 'week' ? 'Last 7 Days' : 'Last 30 Days',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Target: ${target.toStringAsFixed(0)} kcal/day',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),

          // Line Chart with horizontal target line
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: true),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < dates.length) {
                          return Text(dates[index],
                              style: const TextStyle(fontSize: 10));
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) =>
                          Text('${value.toInt()} kcal'),
                    ),
                  ),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: calories
                        .asMap()
                        .entries
                        .map((e) => FlSpot(e.key.toDouble(), e.value))
                        .toList(),
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 5,
                          color: pointColors[index],
                          strokeColor: Colors.white,
                          strokeWidth: 2,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.blue.withAlpha(51),
                    ),
                  ),
                ],
                minY: 0,
                maxY: calories.isEmpty
                    ? 3000
                    : (calories.reduce((a, b) => a > b ? a : b) * 1.2),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (LineBarSpot touchedSpot) =>
                        Colors.blueGrey,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        final date = dates[spot.x.toInt()];
                        final cal = spot.y;
                        final diff = cal - target;
                        final diffText = diff > 0
                            ? '+${diff.toStringAsFixed(0)}'
                            : diff.toStringAsFixed(0);
                        return LineTooltipItem(
                          '$date\n$cal kcal ($diffText kcal)',
                          const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                ),
                extraLinesData: ExtraLinesData(
                  horizontalLines: [
                    HorizontalLine(
                      y: target,
                      color: Colors.green.withAlpha(180),
                      strokeWidth: 2,
                      dashArray: [5, 5],
                      label: HorizontalLineLabel(
                        show: true,
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.only(right: 8, top: -10),
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        labelResolver: (line) =>
                            'Target ${target.toStringAsFixed(0)} kcal',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Improved Bar Chart - Total Calories
          Text(
            'Total Calories - $period',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) => Text(
                        value.toInt() == 0 ? 'Actual' : 'Target',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) => Text(
                        '${value.toInt()} kcal',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: totalActual,
                        color: avgDaily > target
                            ? Colors.orangeAccent
                            : Colors.blue,
                        width: 40,
                        borderRadius: BorderRadius.circular(6),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: totalTarget,
                          color: Colors.grey.withAlpha(38),
                        ),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: totalTarget,
                        color: Colors.green,
                        width: 40,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  ),
                ],
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => Colors.blueGrey,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final total = rod.toY;
                      final label = groupIndex == 0 ? 'Actual' : 'Target';
                      final days = dates.length;
                      return BarTooltipItem(
                        '$label\n${total.toStringAsFixed(0)} kcal\n($days days)',
                        const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Quick Stats
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Quick Stats',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _StatItem(
                          title: 'Days Logged', value: dates.length.toString()),
                      _StatItem(
                        title: 'Highest Day',
                        value: calories.isEmpty
                            ? '-'
                            : calories
                                .reduce((a, b) => a > b ? a : b)
                                .toStringAsFixed(0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            Text(value,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final String value;

  const _StatItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.headlineSmall),
        Text(title, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
