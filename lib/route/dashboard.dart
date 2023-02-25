import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../model/color_picker.dart';
import '../model/db_helper.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final departmentIndices = <String, int>{};
  Map<int, String> departmentIndexMap = {};
  @override
  Widget build(BuildContext context) {
    final data = _getChartData();
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 3,
              color: ColorPicker.primary,
              child: Container(
                height: 400,
                child: _buildChart(),
              ),
            ),
          ),
        )
        /*Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: ColorPicker.primary,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                      child: BarChart(

                      BarChartData(
                        alignment: BarChartAlignment.center,
                        groupsSpace: 20,
                        minY: 0,
                        maxY: 30,
                        barGroups: DBHelper.tasks.map((task) {
                          return BarChartGroupData(
                            x: 1,
                            barRods: [
                              BarChartRodData(
                                toY: task.endDate.difference(task.startDate).inDays.toDouble(),
                                width: 20,
                                color: ColorPicker.accent,

                              ),
                            ],
                            showingTooltipIndicators: [0],
                          );
                        }).toList(),
                      )
                  )),
                ),*/
        ,
        const SizedBox(height: 10),
      ]),
    ));
  }

  // Helper method to get the chart data
  List<BarChartGroupData> _getChartData() {
    // Map to store the number of tasks and late tasks per department
    final taskCounts = <String, List<int>>{};
    for (final task in DBHelper.tasks) {
      if (!taskCounts.containsKey(task.dep)) {
        taskCounts[task.dep] = [0, 0];
      }
      taskCounts[task.dep]![0]++;
      if (task.endDate.isBefore(DateTime.now()) && task.status == 'Late') {
        taskCounts[task.dep]![1]++;
      }
    }

    // Create the chart data from the taskCounts map
    final data = <BarChartGroupData>[];

    var index = 0;
    taskCounts.forEach((department, counts) {
      departmentIndices[department] = index;
      data.add(BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: counts[0].toDouble(),
            color: ColorPicker.dark,
            width: 20,
          ),
          BarChartRodData(
            toY: counts[1].toDouble(),
            color: ColorPicker.accent,
            width: 20,
          ),
        ],
        showingTooltipIndicators: [1, 1],
      ));
      index++;
    });
    departmentIndices.forEach((department, index) {
      departmentIndexMap[index] = department;
    });
    return data;
  }

// Helper method to build the chart
  Widget _buildChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.center,
        groupsSpace: 50,
        maxY: 10,
        barGroups: _getChartData(),
        borderData: FlBorderData(
            border: const Border(bottom: BorderSide(), left: BorderSide())),
        gridData: FlGridData(
            show: true,
            checkToShowHorizontalLine: (value) => value % 1 == 0,
            getDrawingHorizontalLine: (value) => FlLine(
                  color: ColorPicker.fontLight.withOpacity(0.2),
                  strokeWidth: 1,
                )),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, meta) {
              final departmentIndex = value.toInt();
              return Text(departmentIndexMap[departmentIndex]!);
            },
          )),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
      ),
    );
  }
}
