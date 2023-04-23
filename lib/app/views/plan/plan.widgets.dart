import 'package:assume/app/views/home/home.viewmodel.dart';
import 'package:assume/app/views/plan/plan.viewmodel.dart';
import 'package:assume/app/views/plan/subview/create.view.dart';
import 'package:assume/app/views/plan/widgets/filter.widget.dart';
import 'package:assume/app/views/plan/widgets/star.widget.dart';
import 'package:assume/app/views/plan/widgets/table_calendar.widget.dart';
import 'package:assume/app/views/run/widgets/mission_bottom.widget.dart';
import 'package:assume/app/widgets/card/card.widget.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:table_calendar/table_calendar.dart';

class PlanWidgets {
  Widget body(BuildContext context) {
    final provider = Provider.of<PlanViewModel>(context);
    DateTime today = provider.today;
    provider.getPlanCategories();
    var missionList = provider.getMissions(MissionStatus.plans);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Showcase(
            key: context.read<PlanViewModel>().twoShowCase,
            title: context.l10n.filter,
            description: context.l10n.showFilterPart,
            child: FilterWidget(
                choosedItem: provider.dropdownValue,
                onChanged: (String? newValue) {
                  provider.dropdownValue = newValue!;
                }),
          ),
          Showcase(
              key: context.read<PlanViewModel>().threeShowCase,
              title: context.l10n.plans,
              description: context.l10n.showPlansPart,
              child: _planBody(context, provider, today, missionList)),
        ],
      ),
    );
  }

  Column _planBody(BuildContext context, PlanViewModel provider, DateTime today,
      missionList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: context.onlyLeftPaddingLow,
          child: menuLabel(
            context,
            context.l10n.plans,
          ),
        ),
        Column(
          children: [
            TableCalendarWidget(
                calendarFormat: provider.calendarFormat,
                focusedDay: today,
                eventLoader: (day) =>
                    missionList != null ? missionList[day] ?? [] : [],
                onDaySelected: (selectedDay, focusedDay) {
                  provider.onDaySelected(selectedDay, focusedDay);

                  if (missionList != null &&
                      (missionList[selectedDay] ?? []).isNotEmpty) {
                    provider.dropdownValue = context.l10n.weekly;
                  }
                },
                today: today),
            if (provider.calendarFormat != CalendarFormat.month &&
                missionList != null)
              Padding(
                padding: context.horizontalPaddingNormal,
                child: SizedBox(
                  height: context.dynamicHeight(0.517),
                  child: (missionList[today] != null)
                      ? ListView.builder(
                          itemCount: (missionList[today] ?? []).length,
                          padding: context.onlyBottomPaddingLow,
                          itemBuilder: (BuildContext context, int index) {
                            var items = missionList[today];
                            items[index].startedAt = items[index].date;
                            return InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    builder: (context) => MissionBottomSheet(
                                        positiveIcon: Icons.play_arrow,
                                        mission: items[index],
                                        missionStatus: MissionStatus.plans,
                                        negativeOnPressed: () =>
                                            provider.deleteMission(
                                                context, items[index].id!),
                                        positiveOnPressed: () async {
                                          await context
                                              .read<PlanViewModel>()
                                              .runMission(
                                                  context, items[index].id!)
                                              .then((val) {
                                            Navigator.pop(context);
                                            context
                                                .read<HomeViewModel>()
                                                .nextPage(1);
                                          });
                                        },
                                        editOnPressed: () {
                                          context
                                              .read<PlanViewModel>()
                                              .prepareEditMission(items[index]);
                                          createBottomSheet(context,
                                              isEdit: true);
                                        }));
                              },
                              child: CardWidget(
                                  mission: items[index],
                                  editDescriptionOnPressed: () {
                                    provider.prepareEditMission(items![index]);
                                    createBottomSheet(context,
                                        isEdit: true, isEditDescription: true);
                                  },
                                  editOnPressed: () {
                                    provider.prepareEditMission(items![index]);
                                    createBottomSheet(context, isEdit: true);
                                  },
                                  missionStatus: MissionStatus.plans,
                                  negativeOnPressed: () => provider
                                      .deleteMission(context, items![index].id),
                                  positiveOnPressed: () async {
                                    await context
                                        .read<PlanViewModel>()
                                        .runMission(context, items[index].id!)
                                        .then((val) {
                                      context.read<HomeViewModel>().nextPage(1);
                                    });
                                  },
                                  cardType: (items.length >= 3)
                                      ? CardType.small
                                      : (items.length == 2)
                                          ? CardType.medium
                                          : CardType.large),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                          context.l10n.noMission,
                        )),
                ),
              ),
          ],
        ),
      ],
    );
  }

  FloatingActionButton floatingActionButton(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          createBottomSheet(context);
        },
        child: Showcase(
          key: context.read<PlanViewModel>().oneShowCase,
          title: context.l10n.create,
          description: context.l10n.showCreatePart,
          child: const PlusWidget(),
        ));
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text(
        context.l10n.plan,
        style: context.textTheme.displayMedium,
      ),
    );
  }
}

createBottomSheet(BuildContext context,
    {isEdit = false,
    isEditDescription = false,
    MissionStatus status = MissionStatus.plans}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SizedBox(
                height: context.dynamicHeight(0.75),
                child: CreateView(
                  isEdit: isEdit,
                  isEditDescription: isEditDescription,
                  status: status,
                )),
          )).then((value) => Provider.of<PlanViewModel>(context, listen: false)
      .clearCreatePageValues());
}

Widget menuLabel(BuildContext context, String name) {
  return Text(name, style: context.textTheme.bodyLarge);
}
