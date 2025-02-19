import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../services/navigation_service.dart';
import 'AddEditForm.dart';
import 'userdata.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:collection/collection.dart';

class DashboardCharts extends StatefulWidget {
  const DashboardCharts({super.key});

  @override
  State<DashboardCharts> createState() => _DashboardChartsState();
}

class _DashboardChartsState extends State<DashboardCharts> {
  final User _userService = User.instance;
  List<Map<String, dynamic>> _userData = [];
  final PageController _pageController = PageController();
  int _currentChart = 0;
  bool _isLoading = true;
  String _error = '';
  Timer? _autoRotateTimer;
  late final Map<String, int> _sortedAgeGroups;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    // Start auto-rotation
    _autoRotateTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted && _userData.isNotEmpty) {
        final nextPage = (_currentChart + 1) % 6;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoRotateTimer?.cancel();
    // Clear data when disposing
    _userData.clear();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    if (!mounted) return;

    try {
      setState(() {
        _isLoading = true;
        _error = ''; // Clear previous errors
      });

      final users = await _userService.getUserList();

      if (!mounted) return;

      setState(() {
        _userData = users;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = 'Error loading data: $e';
        _isLoading = false;
      });
    }
  }

  void _initializeData() {
    if (_userData.isEmpty) return;

    final ages = _userData.map((u) => u['age'] as int).toList();
    final ageGroups = <String, int>{};

    for (final age in ages) {
      final decade = (age ~/ 10) * 10;
      final group = '$decade-${decade + 9}';
      ageGroups[group] = (ageGroups[group] ?? 0) + 1;
    }

    _sortedAgeGroups = Map.fromEntries(ageGroups.entries.toList()
      ..sort((a, b) => int.parse(a.key.split('-')[0])
          .compareTo(int.parse(b.key.split('-')[0]))));
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        height: 220,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_error.isNotEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _loadUserData,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_userData.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber_rounded,
                  size: 48, color: Colors.orange),
              const SizedBox(height: 16),
              const Text(
                'No user data available',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () async {
                  try {
                    await NavigationService.navigateWithFade(
                        const AddEditForm());
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Navigation error occurred'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.person_add),
                label: const Text('Add User'),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        Container(
          height: 220,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: PageView.builder(
            controller: _pageController,
            itemCount: 6,
            onPageChanged: (index) {
              setState(() => _currentChart = index);
            },
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                  }
                  return Transform.scale(
                    scale: Curves.easeInOut.transform(value),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 350),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            child: _buildChart(index),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_left, size: 20),
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
            Text(
              _getChartTitle(),
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, false, 10),
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_right, size: 20),
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChart(int index) {
    final charts = [
      _buildGenderPieChart(),
      _buildAgeBarChart(),
      _buildReligionDonutChart(),
      _buildCityDistributionChart(),
      _buildEducationChart(),
      _buildOccupationChart(),
    ];

    return Hero(
      tag: 'chart_$index',
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () => _onChartTap(index),
          borderRadius: BorderRadius.circular(12),
          child: charts[index],
        ),
      ),
    );
  }

  void _onChartTap(int index) {
    if (!mounted) return;

    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final padding = _getResponsivePadding(context, isTablet);

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) => LayoutBuilder(
        builder: (context, constraints) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(
              horizontal: padding,
              vertical: size.height * 0.03,
            ),
            child: WillPopScope(
              onWillPop: () async {
                if (!mounted) return true;
                return true;
              },
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: size.width * (isTablet ? 0.8 : 0.95),
                  maxHeight: size.height * 0.85,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(dialogContext).cardColor,
                  borderRadius: BorderRadius.circular(size.width * 0.04),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: size.width * 0.02,
                      offset: Offset(0, size.width * 0.01),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.all(padding),
                      decoration: BoxDecoration(
                        color: Theme.of(dialogContext)
                            .primaryColor
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(size.width * 0.04),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _getChartTitle(),
                              style: TextStyle(
                                fontSize: _getResponsiveFontSize(
                                    context, isTablet, 16),
                                fontWeight: FontWeight.bold,
                                color: Theme.of(dialogContext).primaryColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              size:
                                  _getResponsiveFontSize(context, isTablet, 20),
                            ),
                            onPressed: () {
                              if (mounted) {
                                Navigator.of(dialogContext).pop();
                              }
                            },
                            padding: EdgeInsets.all(padding * 0.5),
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                    // Content
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.all(padding),
                          child: Column(
                            children: [
                              // Chart
                              SizedBox(
                                height: size.height * (isTablet ? 0.4 : 0.3),
                                child:
                                    _buildDetailedChart(index, dialogContext),
                              ),
                              SizedBox(height: padding),
                              // Metrics
                              _buildKeyMetrics(
                                index,
                                isTablet,
                                dialogContext,
                                size,
                                textScaleFactor,
                                padding,
                              ),
                              SizedBox(height: padding),
                              // Analysis
                              _buildAnalysisSection(
                                index,
                                isTablet,
                                dialogContext,
                                size,
                                textScaleFactor,
                                padding,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildKeyMetrics(
    int index,
    bool isTablet,
    BuildContext dialogContext,
    Size size,
    double textScaleFactor,
    double padding,
  ) {
    final borderRadius = size.width * 0.02;
    final spacing = size.width * 0.015;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(dialogContext).cardColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: Theme.of(dialogContext).dividerColor.withOpacity(0.1),
        ),
      ),
      padding: EdgeInsets.all(spacing * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Metrics',
            style: TextStyle(
              fontSize: math.max(size.width * (isTablet ? 0.02 : 0.018), 16.0) *
                  textScaleFactor,
              fontWeight: FontWeight.bold,
              color: Theme.of(dialogContext).primaryColor,
            ),
          ),
          SizedBox(height: spacing),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isTablet ? 3 : 2,
              childAspectRatio: isTablet ? 2.5 : 2.0,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
            ),
            itemCount: _getKeyMetrics(index).length,
            itemBuilder: (context, i) => _buildMetricCard(
              _getKeyMetrics(index)[i],
              isTablet,
              dialogContext,
              size,
              textScaleFactor,
              spacing,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    Map<String, String> metric,
    bool isTablet,
    BuildContext dialogContext,
    Size size,
    double textScaleFactor,
    double spacing,
  ) {
    final trend = double.tryParse(metric['trend'] ?? '0.0') ?? 0.0;
    final borderRadius = size.width * 0.015;

    // Calculate minimum font sizes
    final minLabelSize = 12.0;
    final minValueSize = 14.0;

    // Calculate responsive font sizes with minimum bounds
    final labelSize =
        math.max(size.width * (isTablet ? 0.012 : 0.01), minLabelSize) *
            textScaleFactor;

    final valueSize =
        math.max(size.width * (isTablet ? 0.016 : 0.014), minValueSize) *
            textScaleFactor;

    return Container(
      padding: EdgeInsets.all(spacing),
      decoration: BoxDecoration(
        color: Theme.of(dialogContext).cardColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: Theme.of(dialogContext).dividerColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            metric['label'] ?? '',
            style: TextStyle(
              fontSize: labelSize,
              color: Theme.of(dialogContext).textTheme.bodySmall?.color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spacing * 0.5),
          Row(
            children: [
              Expanded(
                child: Text(
                  metric['value'] ?? '',
                  style: TextStyle(
                    fontSize: valueSize,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (trend != 0)
                Icon(
                  trend > 0 ? Icons.trending_up : Icons.trending_down,
                  size: math.max(size.width * (isTablet ? 0.02 : 0.018), 16.0),
                  color: trend > 0 ? Colors.green : Colors.red,
                ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getKeyMetrics(int index) {
    switch (index) {
      case 0: // Gender
        final maleCount = _userData.where((u) => u['gender'] == 1).length;
        final femaleCount = _userData.where((u) => u['gender'] == 0).length;
        return [
          {
            'label': 'Male Ratio',
            'value':
                '${(maleCount / _userData.length * 100).toStringAsFixed(1)}%',
            'trend': '0.0',
          },
          {
            'label': 'Female Ratio',
            'value':
                '${(femaleCount / _userData.length * 100).toStringAsFixed(1)}%',
            'trend': '0.0',
          },
          {
            'label': 'Gender Gap',
            'value': '${(maleCount - femaleCount).abs()}',
            'trend': '${(maleCount - femaleCount).sign.toDouble()}',
          },
          {
            'label': 'Total Users',
            'value': _userData.length.toString(),
            'trend': '0.0',
          },
        ];

      case 1: // Age
        final ages = _userData.map((u) => u['age'] as int).toList();
        final avgAge = ages.reduce((a, b) => a + b) / ages.length;
        final maxAge = findMax(ages);
        final minAge = findMin(ages);
        return [
          {
            'label': 'Average Age',
            'value': avgAge.toStringAsFixed(1),
            'trend': '0.0',
          },
          {
            'label': 'Age Range',
            'value': '$minAge-$maxAge',
            'trend': '0.0',
          },
          {
            'label': 'Total Users',
            'value': ages.length.toString(),
            'trend': '0.0',
          },
        ];

      case 2: // Religion
        final religionCount = <String, int>{};
        for (var user in _userData) {
          final religion = user['religion'] as String;
          religionCount[religion] = (religionCount[religion] ?? 0) + 1;
        }
        final maxReligion =
            religionCount.entries.reduce((a, b) => a.value > b.value ? a : b);
        return [
          {
            'label': 'Most Common',
            'value': maxReligion.key,
            'trend': '0.0',
          },
          {
            'label': 'Religions',
            'value': religionCount.length.toString(),
            'trend': '0.0',
          },
          {
            'label': 'Total Users',
            'value': _userData.length.toString(),
            'trend': '0.0',
          },
        ];

      case 3: // City
        final cityCount = <String, int>{};
        for (var user in _userData) {
          final city = user['city'] as String;
          cityCount[city] = (cityCount[city] ?? 0) + 1;
        }
        final maxCity =
            cityCount.entries.reduce((a, b) => a.value > b.value ? a : b);
        return [
          {
            'label': 'Top City',
            'value': maxCity.key,
            'trend': '0.0',
          },
          {
            'label': 'Cities',
            'value': cityCount.length.toString(),
            'trend': '0.0',
          },
          {
            'label': 'Total Users',
            'value': _userData.length.toString(),
            'trend': '0.0',
          },
        ];

      case 4: // Education
        final eduCount = <String, int>{};
        for (var user in _userData) {
          final education = user['higherEducation'] as String;
          eduCount[education] = (eduCount[education] ?? 0) + 1;
        }
        final maxEdu =
            eduCount.entries.reduce((a, b) => a.value > b.value ? a : b);
        return [
          {
            'label': 'Most Common',
            'value': maxEdu.key,
            'trend': '0.0',
          },
          {
            'label': 'Levels',
            'value': eduCount.length.toString(),
            'trend': '0.0',
          },
          {
            'label': 'Total Users',
            'value': _userData.length.toString(),
            'trend': '0.0',
          },
        ];

      case 5: // Occupation
        final occCount = <String, int>{};
        for (var user in _userData) {
          final occupation = user['occupation'] as String;
          occCount[occupation] = (occCount[occupation] ?? 0) + 1;
        }
        final maxOcc =
            occCount.entries.reduce((a, b) => a.value > b.value ? a : b);
        return [
          {
            'label': 'Top Occupation',
            'value': maxOcc.key,
            'trend': '0.0',
          },
          {
            'label': 'Occupations',
            'value': occCount.length.toString(),
            'trend': '0.0',
          },
          {
            'label': 'Total Users',
            'value': _userData.length.toString(),
            'trend': '0.0',
          },
        ];

      default:
        return [];
    }
  }

  Widget _buildAnalysisSection(
    int index,
    bool isTablet,
    BuildContext dialogContext,
    Size size,
    double textScaleFactor,
    double padding,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(dialogContext).cardColor,
        borderRadius: BorderRadius.circular(size.width * 0.02),
        border: Border.all(
          color: Theme.of(dialogContext).dividerColor.withOpacity(0.1),
        ),
      ),
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detailed Analysis',
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, isTablet, 18),
              fontWeight: FontWeight.bold,
              color: Theme.of(dialogContext).primaryColor,
            ),
          ),
          SizedBox(height: padding * 0.75),
          _buildAnalysisContent(
            index,
            isTablet,
            dialogContext,
            textScaleFactor,
            padding,
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisContent(
    int index,
    bool isTablet,
    BuildContext context,
    double textScale,
    double padding,
  ) {
    switch (index) {
      case 0: // Gender Analysis
        final total = _userData.length;
        final maleCount = _userData.where((u) => u['gender'] == 1).length;
        final femaleCount = _userData.where((u) => u['gender'] == 0).length;

        // Calculate age-based gender stats
        final maleAges = _userData
            .where((u) => u['gender'] == 1)
            .map((u) => u['age'] as int)
            .toList();
        final femaleAges = _userData
            .where((u) => u['gender'] == 0)
            .map((u) => u['age'] as int)
            .toList();

        return Column(
          children: [
            _buildAnalysisHeader(
                'Population Overview', context, isTablet, textScale),
            _buildAnalysisRow(
              'Total Population',
              '$total users',
              context,
              isTablet,
              textScale,
              isHighlight: true,
            ),
            _buildAnalysisRow(
              'Male Population',
              '$maleCount (${(maleCount / total * 100).toStringAsFixed(1)}%)',
              context,
              isTablet,
              textScale,
            ),
            _buildAnalysisRow(
              'Female Population',
              '$femaleCount (${(femaleCount / total * 100).toStringAsFixed(1)}%)',
              context,
              isTablet,
              textScale,
            ),
            SizedBox(height: padding),
            _buildAnalysisHeader(
                'Age Distribution by Gender', context, isTablet, textScale),
            _buildAnalysisRow(
              'Average Male Age',
              '${(maleAges.reduce((a, b) => a + b) / maleAges.length).toStringAsFixed(1)} years',
              context,
              isTablet,
              textScale,
            ),
            _buildAnalysisRow(
              'Average Female Age',
              '${(femaleAges.reduce((a, b) => a + b) / femaleAges.length).toStringAsFixed(1)} years',
              context,
              isTablet,
              textScale,
            ),
            _buildAnalysisRow(
              'Male Age Range',
              '${findMin(maleAges)} - ${findMax(maleAges)} years',
              context,
              isTablet,
              textScale,
            ),
            _buildAnalysisRow(
              'Female Age Range',
              '${findMin(femaleAges)} - ${findMax(femaleAges)} years',
              context,
              isTablet,
              textScale,
            ),
            SizedBox(height: padding),
            _buildAnalysisHeader(
                'Additional Insights', context, isTablet, textScale),
            _buildAnalysisRow(
              'Gender Ratio (M:F)',
              '${(maleCount / femaleCount).toStringAsFixed(2)}:1',
              context,
              isTablet,
              textScale,
              isHighlight: true,
            ),
            _buildAnalysisRow(
              'Dominant Gender',
              maleCount > femaleCount ? 'Male' : 'Female',
              context,
              isTablet,
              textScale,
            ),
            _buildAnalysisRow(
              'Gender Gap',
              '${(maleCount - femaleCount).abs()} users',
              context,
              isTablet,
              textScale,
            ),
          ],
        );

      case 1: // Age Analysis
        final ages = _userData.map((u) => u['age'] as int).toList();
        final avgAge = ages.reduce((a, b) => a + b) / ages.length;

        // Calculate age groups with more detail
        final ageGroups = <String, int>{};
        int under18 = 0, over65 = 0;
        for (final age in ages) {
          if (age < 18) under18++;
          if (age > 65) over65++;

          // Make age groups more readable
          final decade = (age ~/ 10) * 10;
          final group = '$decade-${decade + 9}';
          ageGroups[group] = (ageGroups[group] ?? 0) + 1;
        }

        // For age groups sorting
        final sortedGroups = ageGroups.entries.toList()
          ..sort((a, b) {
            final aAge = int.parse(a.key.split('-')[0]);
            final bAge = int.parse(b.key.split('-')[0]);
            return aAge.compareTo(bAge);
          });

        return Column(
          children: [
            _buildAnalysisHeader(
                'Age Statistics', context, isTablet, textScale),
            _buildAnalysisRow(
              'Average Age',
              '${avgAge.toStringAsFixed(1)} years',
              context,
              isTablet,
              textScale,
              isHighlight: true,
            ),
            _buildAnalysisRow(
              'Age Range',
              '${findMin(ages)} - ${findMax(ages)} years',
              context,
              isTablet,
              textScale,
            ),
            _buildAnalysisRow(
              'Median Age',
              '${_calculateMedian(ages)} years',
              context,
              isTablet,
              textScale,
            ),
            SizedBox(height: padding),
            _buildAnalysisHeader(
                'Age Distribution', context, isTablet, textScale),
            ...sortedGroups
                .where((e) => e.value > 0)
                .map((group) => _buildAnalysisRow(
                      '${group.key} years',
                      '${group.value} (${(group.value / ages.length * 100).toStringAsFixed(1)}%)',
                      context,
                      isTablet,
                      textScale,
                    )),
            SizedBox(height: padding),
            _buildAnalysisHeader(
                'Population Segments', context, isTablet, textScale),
            _buildAnalysisRow(
              'Working Age (18-65)',
              '${ages.where((age) => age >= 18 && age <= 65).length} (${(ages.where((age) => age >= 18 && age <= 65).length / ages.length * 100).toStringAsFixed(1)}%)',
              context,
              isTablet,
              textScale,
              isHighlight: true,
            ),
            _buildAnalysisRow(
              'Under 18',
              '$under18 (${(under18 / ages.length * 100).toStringAsFixed(1)}%)',
              context,
              isTablet,
              textScale,
            ),
            _buildAnalysisRow(
              'Over 65',
              '$over65 (${(over65 / ages.length * 100).toStringAsFixed(1)}%)',
              context,
              isTablet,
              textScale,
            ),
          ],
        );

      case 2: // Religion
        final religionCount = <String, int>{};
        for (var user in _userData) {
          final religion = user['religion'] as String;
          religionCount[religion] = (religionCount[religion] ?? 0) + 1;
        }
        final maxReligion =
            religionCount.entries.reduce((a, b) => a.value > b.value ? a : b);
        return Column(
          children: [
            _buildAnalysisHeader(
                'Religion Distribution', context, isTablet, textScale),
            ...religionCount.entries.map((e) => _buildAnalysisRow(
                  e.key,
                  '${e.value} (${(e.value / _userData.length * 100).toStringAsFixed(1)}%)',
                  context,
                  isTablet,
                  textScale,
                )),
          ],
        );

      case 3: // City
        final cityCount = <String, int>{};
        for (var user in _userData) {
          final city = user['city'] as String;
          cityCount[city] = (cityCount[city] ?? 0) + 1;
        }
        final maxCity =
            cityCount.entries.reduce((a, b) => a.value > b.value ? a : b);
        return Column(
          children: [
            _buildAnalysisHeader(
                'City Distribution', context, isTablet, textScale),
            ...cityCount.entries.map((e) => _buildAnalysisRow(
                  e.key,
                  '${e.value} (${(e.value / _userData.length * 100).toStringAsFixed(1)}%)',
                  context,
                  isTablet,
                  textScale,
                )),
          ],
        );

      case 4: // Education
        final eduCount = <String, int>{};
        for (var user in _userData) {
          final education = user['higherEducation'] as String;
          eduCount[education] = (eduCount[education] ?? 0) + 1;
        }
        final maxEdu =
            eduCount.entries.reduce((a, b) => a.value > b.value ? a : b);
        return Column(
          children: [
            _buildAnalysisHeader(
                'Education Distribution', context, isTablet, textScale),
            ...eduCount.entries.map((e) => _buildAnalysisRow(
                  e.key,
                  '${e.value} (${(e.value / _userData.length * 100).toStringAsFixed(1)}%)',
                  context,
                  isTablet,
                  textScale,
                )),
          ],
        );

      case 5: // Occupation
        final occCount = <String, int>{};
        for (var user in _userData) {
          final occupation = user['occupation'] as String;
          occCount[occupation] = (occCount[occupation] ?? 0) + 1;
        }
        final maxOcc =
            occCount.entries.reduce((a, b) => a.value > b.value ? a : b);
        return Column(
          children: [
            _buildAnalysisHeader(
                'Occupation Distribution', context, isTablet, textScale),
            ...occCount.entries.map((e) => _buildAnalysisRow(
                  e.key,
                  '${e.value} (${(e.value / _userData.length * 100).toStringAsFixed(1)}%)',
                  context,
                  isTablet,
                  textScale,
                )),
          ],
        );

      default:
        return const SizedBox();
    }
  }

  Widget _buildAnalysisHeader(
    String title,
    BuildContext context,
    bool isTablet,
    double textScale,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8 * textScale),
      child: Text(
        title,
        style: TextStyle(
          fontSize: _getResponsiveFontSize(context, isTablet, 16),
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildAnalysisRow(
    String label,
    String value,
    BuildContext context,
    bool isTablet,
    double textScale, {
    bool isHighlight = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 6 * textScale,
        horizontal: 8 * textScale,
      ),
      decoration: isHighlight
          ? BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4 * textScale),
            )
          : null,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, isTablet, 14),
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: isHighlight ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, isTablet, 14),
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.w500,
                color: isHighlight
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.bodyMedium?.color,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  double _calculateMedian(List<int> numbers) {
    final sorted = List<int>.from(numbers)..sort();
    final middle = sorted.length ~/ 2;
    if (sorted.length.isOdd) {
      return sorted[middle].toDouble();
    }
    return (sorted[middle - 1] + sorted[middle]) / 2;
  }

  Widget _buildDetailedChart(int index, BuildContext dialogContext) {
    if (_userData.isEmpty) {
      return Center(
        child: Text(
          'No data available',
          style: TextStyle(
            color: Theme.of(dialogContext).textTheme.bodyMedium?.color,
          ),
        ),
      );
    }

    switch (index) {
      case 0: // Gender
        return _buildGenderPieChart();
      case 1: // Age
        return _buildAgeBarChart();
      case 2: // Religion
        return _buildReligionDonutChart();
      case 3: // City
        return _buildCityDistributionChart();
      case 4: // Education
        return _buildEducationChart();
      case 5: // Occupation
        return _buildOccupationChart();
      default:
        return const SizedBox();
    }
  }

  String _getChartTitle() {
    switch (_currentChart) {
      case 0:
        return 'Gender Distribution';
      case 1:
        return 'Age Distribution';
      case 2:
        return 'Religion Distribution';
      case 3:
        return 'City Distribution';
      case 4:
        return 'Education Distribution';
      case 5:
        return 'Occupation Distribution';
      default:
        return 'Distribution';
    }
  }

  Widget _buildGenderPieChart() {
    Map<String, int> genderCount = {
      'Male': 0,
      'Female': 0,
      'Other': 0,
    };

    for (var user in _userData) {
      String gender = user['gender'] == 0
          ? 'Female'
          : (user['gender'] == 1 ? 'Male' : 'Other');
      genderCount[gender] = (genderCount[gender] ?? 0) + 1;
    }

    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              'Gender Distribution',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
            ),
            Expanded(
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 8,
                  sections: genderCount.entries.map((e) {
                    return PieChartSectionData(
                      value: e.value.toDouble(),
                      title:
                          '${(e.value / _userData.length * 100).toStringAsFixed(1)}%',
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      color: e.key == 'Male'
                          ? Colors.blue
                          : (e.key == 'Female' ? Colors.pink : Colors.purple),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 2,
              runSpacing: 2,
              children: genderCount.entries.map((e) {
                return Container(
                  margin: const EdgeInsets.only(right: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: (e.key == 'Male'
                            ? Colors.blue
                            : (e.key == 'Female' ? Colors.pink : Colors.purple))
                        .withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: (e.key == 'Male'
                              ? Colors.blue
                              : (e.key == 'Female'
                                  ? Colors.pink
                                  : Colors.purple))
                          .withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '${e.key}: ${e.value}',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeBarChart() {
    Map<String, int> ageGroups = {};
    for (var user in _userData) {
      int age = user['age'] as int;
      // Create 5-year age groups instead of 10
      String group = '${(age ~/ 5) * 5}-${(age ~/ 5) * 5 + 4}';
      ageGroups[group] = (ageGroups[group] ?? 0) + 1;
    }

    // Sort age groups
    var sortedAgeGroups = Map.fromEntries(ageGroups.entries.toList()
      ..sort((a, b) => int.parse(a.key.split('-')[0])
          .compareTo(int.parse(b.key.split('-')[0]))));

    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              'Age Distribution',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 20.0, 16.0, 12.0),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 1,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color:
                              Theme.of(context).dividerColor.withOpacity(0.2),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                value.toInt().toString(),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index >= 0 && index < sortedAgeGroups.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  sortedAgeGroups.keys.elementAt(index),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.color,
                                  ),
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).dividerColor,
                          width: 1,
                        ),
                        left: BorderSide(
                          color: Theme.of(context).dividerColor,
                          width: 1,
                        ),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: List.generate(sortedAgeGroups.length, (index) {
                          return FlSpot(
                            index.toDouble(),
                            sortedAgeGroups.values.elementAt(index).toDouble(),
                          );
                        }),
                        isCurved: true,
                        color: Theme.of(context).primaryColor,
                        barWidth: 2,
                        isStrokeCapRound: true,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(
                          show: true,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                        ),
                      ),
                    ],
                    minX: 0,
                    maxX: (sortedAgeGroups.length - 1).toDouble(),
                    minY: 0,
                    maxY: sortedAgeGroups.values
                            .fold(0, (p, c) => math.max(p, c))
                            .toDouble() *
                        1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReligionDonutChart() {
    Map<String, int> religionCount = {};
    for (var user in _userData) {
      String religion = user['religion'] as String;
      religionCount[religion] = (religionCount[religion] ?? 0) + 1;
    }

    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              'Religion Distribution',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
            ),
            Expanded(
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 8,
                  sections: religionCount.entries.map((e) {
                    return PieChartSectionData(
                      value: e.value.toDouble(),
                      title:
                          '${(e.value / _userData.length * 100).toStringAsFixed(1)}%',
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      color: Colors.primaries[
                          religionCount.keys.toList().indexOf(e.key) %
                              Colors.primaries.length],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 2,
              runSpacing: 2,
              children: religionCount.entries.map((e) {
                return Container(
                  margin: const EdgeInsets.only(right: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.primaries[
                            religionCount.keys.toList().indexOf(e.key) %
                                Colors.primaries.length]
                        .withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.primaries[
                              religionCount.keys.toList().indexOf(e.key) %
                                  Colors.primaries.length]
                          .withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '${e.key}: ${e.value}',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCityDistributionChart() {
    Map<String, int> cityCount = {};
    for (var user in _userData) {
      String city = user['city'] as String;
      cityCount[city] = (cityCount[city] ?? 0) + 1;
    }

    // Sort cities by count in descending order
    var sortedCityCount = Map.fromEntries(
        cityCount.entries.toList()..sort((a, b) => b.value.compareTo(a.value)));

    // Calculate max value for color intensity
    final maxValue = sortedCityCount.values.first.toDouble();

    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              'City Distribution',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate optimal tile size based on available width
                  final double availableWidth = constraints.maxWidth;
                  final int columnsCount = availableWidth > 600 ? 6 : 3;
                  final double tileWidth =
                      (availableWidth - (16 + (columnsCount - 1) * 4)) /
                          columnsCount;
                  final double tileHeight = tileWidth * 0.75;

                  return Column(
                    children: [
                      Expanded(
                        child: ShaderMask(
                          shaderCallback: (Rect rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.purple,
                                Colors.transparent,
                                Colors.transparent,
                                Colors.purple
                              ],
                              stops: const [0.0, 0.05, 0.95, 1.0],
                            ).createShader(rect);
                          },
                          blendMode: BlendMode.dstOut,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                alignment: WrapAlignment.center,
                                children: sortedCityCount.entries.map((e) {
                                  final percentage =
                                      (e.value / _userData.length * 100)
                                          .toStringAsFixed(1);
                                  final intensity =
                                      (e.value / maxValue * 0.85) + 0.15;

                                  return SizedBox(
                                    width: tileWidth,
                                    height: tileHeight,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(8),
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text(e.key),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'Total Users: ${e.value}'),
                                                  Text(
                                                      'Percentage: $percentage%'),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('Close'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Colors.blue
                                                    .withOpacity(intensity),
                                                Colors.blue.withOpacity(
                                                    intensity * 0.8),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  e.key,
                                                  style: TextStyle(
                                                    fontSize: tileWidth * 0.14,
                                                    fontWeight: FontWeight.bold,
                                                    color: intensity > 0.5
                                                        ? Colors.white
                                                        : Colors.black87,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                    height: tileWidth * 0.04),
                                                FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    '${e.value}',
                                                    style: TextStyle(
                                                      fontSize:
                                                          tileWidth * 0.13,
                                                      color: intensity > 0.5
                                                          ? Colors.white70
                                                          : Colors.black54,
                                                    ),
                                                  ),
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    '$percentage%',
                                                    style: TextStyle(
                                                      fontSize:
                                                          tileWidth * 0.13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: intensity > 0.5
                                                          ? Colors.white
                                                          : Colors.black87,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationChart() {
    Map<String, int> educationCount = {};
    for (var user in _userData) {
      String education = user['higherEducation'] as String;
      educationCount[education] = (educationCount[education] ?? 0) + 1;
    }

    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              'Education Distribution',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  // Pie Chart
                  Expanded(
                    flex: 2,
                    child: PieChart(
                      PieChartData(
                        centerSpaceRadius: 18,
                        sectionsSpace: 1,
                        sections: educationCount.entries.map((e) {
                          final color = Colors.primaries[
                              educationCount.keys.toList().indexOf(e.key) %
                                  Colors.primaries.length];
                          return PieChartSectionData(
                            value: e.value.toDouble(),
                            title: '',
                            color: color,
                            radius: 50,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  // Legend
                  Expanded(
                    flex: 3,
                    child: ShaderMask(
                      shaderCallback: (Rect rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.purple,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.purple
                          ],
                          stops: const [0.0, 0.05, 0.95, 1.0],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstOut,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            children: educationCount.entries.map((e) {
                              final color = Colors.primaries[
                                  educationCount.keys.toList().indexOf(e.key) %
                                      Colors.primaries.length];
                              final percentage =
                                  (e.value / _userData.length * 100)
                                      .toStringAsFixed(1);
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0.25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 6,
                                            height: 6,
                                            decoration: BoxDecoration(
                                              color: color,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              e.key,
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.color
                                                    ?.withOpacity(0.9),
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      '$percentage%',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOccupationChart() {
    Map<String, int> occupationCount = {};
    for (var user in _userData) {
      String occupation = user['occupation'] as String;
      occupationCount[occupation] = (occupationCount[occupation] ?? 0) + 1;
    }

    var sortedOccupationCount = Map.fromEntries(occupationCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value)));

    return Card(
      elevation: 4,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              'Occupation Distribution',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: sortedOccupationCount.length,
                itemBuilder: (context, index) {
                  final entry = sortedOccupationCount.entries.elementAt(index);
                  final percentage =
                      (entry.value / _userData.length * 100).toStringAsFixed(1);

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                entry.key,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${entry.value} ($percentage%)',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: LinearProgressIndicator(
                            value: entry.value /
                                sortedOccupationCount.values.first,
                            minHeight: 8,
                            backgroundColor:
                                Theme.of(context).dividerColor.withOpacity(0.1),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int findMax(List<int> numbers) {
    return numbers.reduce((curr, next) => curr > next ? curr : next);
  }

  int findMin(List<int> numbers) {
    return numbers.reduce((curr, next) => curr < next ? curr : next);
  }

  double _getResponsiveFontSize(
      BuildContext context, bool isTablet, double baseSize) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return (isTablet ? baseSize * 1.2 : baseSize) * textScaleFactor;
  }

  double _getResponsivePadding(BuildContext context, bool isTablet) {
    final width = MediaQuery.of(context).size.width;
    return width * (isTablet ? 0.03 : 0.04);
  }

  Color _getChartColor(int index, BuildContext context) {
    final colors = [
      Theme.of(context).primaryColor,
      Theme.of(context).colorScheme.secondary,
      Theme.of(context).colorScheme.tertiary,
    ];
    return colors[index % colors.length];
  }
}
