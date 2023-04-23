import 'dart:math';

import 'package:assume/app/views/plan/plan.widgets.dart';
import 'package:assume/app/views/profile/profile.viewmodel.dart';
import 'package:assume/app/views/run/widgets/chevron_date.widget.dart';
import 'package:assume/core/base/base_view/base_view.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticView extends BaseView {
  const StatisticView({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileViewModel provider = context.read<ProfileViewModel>();
    Random random = Random();
    var dayList = provider.getStatisticalData();
    var catMap = provider.getCategoricalData();
    var impMap = provider.getImportanceData();
    var timeCatList = provider.getTimeCatData();
    var timeCatStringList = timeCatList.keys.toList();

    return dynamicBuild(
      context,
      appBar: AppBar(
        title: Text(
          context.l10n.statistics,
          style: context.textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.horizontalPaddingNormal,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: context.verticalPaddingLow,
              child: Card(
                shape: _cardShape(context),
                child: ChevronDateWidget(
                  date: context.watch<ProfileViewModel>().now,
                  onPressedLeftChevron: () {
                    provider.arrangeDate(isNextMonth: false);
                  },
                  onPressedRightChevron: () {
                    provider.arrangeDate(isNextMonth: true);
                  },
                ),
              ),
            ),
            (impMap.keys.length != 0)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: context.verticalPaddingNormal,
                        child: menuLabel(context, context.l10n.priority),
                      ),
                      Card(
                        shape: _cardShape(context),
                        child: Container(
                          height: 250,
                          padding: context.paddingNormal,
                          child: PieChart(PieChartData(sections: [
                            for (var i in impMap.keys)
                              PieChartSectionData(
                                value: impMap[i]!.toDouble(),
                                title: i,
                                radius: 50,
                                color: context.color.mainColor.withOpacity(0.2 *
                                    (int.parse(i) == 0 ? 1 : int.parse(i))),
                              ),
                          ])),
                        ),
                      ),
                      Padding(
                        padding: context.verticalPaddingNormal,
                        child: menuLabel(context, context.l10n.categories),
                      ),
                      Card(
                        shape: _cardShape(context),
                        child: Container(
                          height: 250,
                          padding: context.paddingNormal,
                          child: PieChart(PieChartData(sections: [
                            for (var i in catMap.keys)
                              PieChartSectionData(
                                value: catMap[i]!.toDouble(),
                                title: i,
                                radius: 50,
                                color: Color.fromRGBO(
                                  random.nextInt(256),
                                  random.nextInt(256),
                                  random.nextInt(256),
                                  1,
                                ),
                              ),
                          ])),
                        ),
                      ),
                      Padding(
                        padding: context.verticalPaddingNormal,
                        child: menuLabel(context, context.l10n.worksDays),
                      ),
                      SizedBox(
                        height: 300,
                        width: 500,
                        child: Card(
                          shape: _cardShape(context),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              padding: context.verticalPaddingNormal,
                              height: 300,
                              width: 1000,
                              child: Padding(
                                padding: context.onlyTopPaddingMedium,
                                child: BarChart(BarChartData(
                                    borderData: FlBorderData(
                                        border: const Border(
                                      top: BorderSide.none,
                                      right: BorderSide.none,
                                      left: BorderSide(width: 1),
                                      bottom: BorderSide(width: 1),
                                    )),
                                    groupsSpace: 10,
                                    barGroups: [
                                      for (int i = 0; i < dayList.length; i++)
                                        BarChartGroupData(x: i + 1, barRods: [
                                          BarChartRodData(
                                              toY: dayList[i].toDouble(),
                                              width: 15,
                                              color: context.color.mainColor),
                                        ]),
                                    ])),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: context.verticalPaddingNormal,
                        child: menuLabel(context, context.l10n.timeSpentCat),
                      ),
                      Card(
                        shape: _cardShape(context),
                        child: SizedBox(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              width: timeCatStringList.length > 6 ? 1000 : 500,
                              height: 300,
                              padding: context.paddingNormal,
                              child: BarChart(BarChartData(
                                titlesData: FlTitlesData(
                                    bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, titleMeta) {
                                        return Text(
                                            timeCatStringList[value.toInt()]);
                                      }),
                                )),
                                borderData: FlBorderData(
                                    border: const Border(
                                  top: BorderSide.none,
                                  right: BorderSide.none,
                                  left: BorderSide(width: 1),
                                  bottom: BorderSide(width: 1),
                                )),
                                groupsSpace: 10,
                                barGroups: [
                                  for (int i = 0; i < timeCatList.length; i++)
                                    BarChartGroupData(x: i, barRods: [
                                      BarChartRodData(
                                          toY: timeCatList[timeCatStringList[i]]
                                              .toDouble(),
                                          width: 15,
                                          color: context.color.mainColor),
                                    ]),
                                ],
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: context.dynamicHeight(0.7),
                    child: Center(
                      child: Text(context.l10n.noStatistics),
                    ),
                  ),
          ]),
        ),
      ),
    );
  }

  RoundedRectangleBorder _cardShape(BuildContext context) {
    return RoundedRectangleBorder(
      side: BorderSide(
        color: context.color.grey,
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
