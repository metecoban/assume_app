import 'package:assume/app/views/home/home.viewmodel.dart';
import 'package:assume/app/views/plan/plan.viewmodel.dart';
import 'package:assume/app/views/plan/plan.widgets.dart';
import 'package:assume/app/views/plan/widgets/filter.widget.dart';
import 'package:assume/app/views/run/run.viewmodel.dart';
import 'package:assume/app/views/run/widgets/chevron_date.widget.dart';
import 'package:assume/app/views/run/widgets/mission_bottom.widget.dart';
import 'package:assume/app/widgets/card/card.widget.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RunWidgets {
  Widget body(BuildContext context) {
    final provider = Provider.of<RunViewModel>(context);
    var missionMap = provider.fetchMissions(context);

    List missionList = missionMap.keys.toList();
    missionList.sort();
    var date =
        missionList.isNotEmpty ? missionList[provider.counter] : DateTime.now();
    var runMissions = missionMap[date] ?? [];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterWidget(
              isViewInvisible: true,
              choosedItem: '',
              onChanged: (String? newValue) {}),
          Padding(
            padding: context.onlyLeftPaddingLow,
            child: menuLabel(context, context.l10n.plans),
          ),
          Column(
            children: [
              ChevronDateWidget(
                date: date,
                onPressedLeftChevron: () => provider.changeCounterValue(false),
                onPressedRightChevron: () => provider.changeCounterValue(true),
              ),
              Padding(
                padding: context.horizontalPaddingNormal,
                child: SizedBox(
                  height: 560,
                  width: 600,
                  child: ListView.builder(
                      itemCount: runMissions.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                builder: (context) => SizedBox(
                                      height: context.dynamicHeight(0.6),
                                      child: MissionBottomSheet(
                                        positiveText: context.l10n.done,
                                        negativeText:
                                            runMissions[index].finishedAt ==
                                                    null
                                                ? context.l10n.stop
                                                : context.l10n.resume,
                                        negativeIconColor:
                                            runMissions[index].finishedAt ==
                                                    null
                                                ? null
                                                : context.color.orange,
                                        negativeIcon:
                                            runMissions[index].finishedAt ==
                                                    null
                                                ? Icons.stop
                                                : Icons.play_arrow,
                                        positiveIcon: Icons.done,
                                        mission: runMissions[index],
                                        missionStatus: MissionStatus.runs,
                                        negativeOnPressed: () {
                                          runMissions[index].finishedAt == null
                                              ? provider.stopMission(
                                                  runMissions[index])
                                              : provider.reRunMission(
                                                  context, runMissions[index]);

                                          Navigator.pop(context);
                                        },
                                        isStop: runMissions[index].finishedAt !=
                                                null
                                            ? true
                                            : false,
                                        positiveOnPressed: () {
                                          context
                                              .read<RunViewModel>()
                                              .finishMission(context,
                                                  runMissions[index].id!)
                                              .then((val) {
                                            Navigator.pop(context);
                                            context
                                                .read<HomeViewModel>()
                                                .nextPage(2);
                                          });
                                        },
                                      ),
                                    ));
                          },
                          child: CardWidget(
                            mission: runMissions[index],
                            cardColor: runMissions[index].finishedAt != null
                                ? context.color.orange.withOpacity(0.3)
                                : context.color.green.withOpacity(0.3),
                            isStop: runMissions[index].finishedAt != null
                                ? true
                                : false,
                            missionStatus: MissionStatus.runs,
                            negativeText: runMissions[index].finishedAt == null
                                ? context.l10n.stop
                                : context.l10n.resume,
                            negativeIconColor:
                                runMissions[index].finishedAt == null
                                    ? null
                                    : context.color.orange,
                            negativeIcon: runMissions[index].finishedAt == null
                                ? Icons.stop
                                : Icons.play_arrow,
                            positiveText: context.l10n.done,
                            cardType: (runMissions.length >= 3)
                                ? CardType.small
                                : (runMissions.length == 2)
                                    ? CardType.medium
                                    : CardType.large,
                            positiveIcon: Icons.done,
                            negativeOnPressed: () {
                              runMissions[index].finishedAt == null
                                  ? provider.stopMission(runMissions[index])
                                  : provider.reRunMission(
                                      context, runMissions[index]);
                            },
                            positiveOnPressed: () => context
                                .read<RunViewModel>()
                                .finishMission(context, runMissions[index].id!)
                                .then((val) {
                              context.read<HomeViewModel>().nextPage(2);
                            }),
                            editDescriptionOnPressed: () {
                              context
                                  .read<PlanViewModel>()
                                  .prepareEditMission(runMissions![index]);
                              createBottomSheet(context,
                                  isEdit: true,
                                  isEditDescription: true,
                                  status: MissionStatus.runs);
                            },
                          ),
                        );
                      }),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text(
        context.l10n.run,
        style: context.textTheme.displayMedium,
      ),
    );
  }
}
