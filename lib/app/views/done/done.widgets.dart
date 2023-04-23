import 'package:assume/app/views/done/done.viewmodel.dart';
import 'package:assume/app/views/plan/plan.viewmodel.dart';
import 'package:assume/app/views/plan/plan.widgets.dart';
import 'package:assume/app/views/plan/widgets/filter.widget.dart';
import 'package:assume/app/views/plan/widgets/table_calendar.widget.dart';
import 'package:assume/app/views/run/widgets/mission_bottom.widget.dart';
import 'package:assume/app/widgets/card/card.widget.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DoneWidgets {
  Widget body(BuildContext context) {
    final provider = Provider.of<DoneViewModel>(context);
    DateTime today = provider.today;
    var missionList = provider.getMissions(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterWidget(
              choosedItem: provider.dropdownValue,
              onChanged: (String? newValue) {
                provider.dropdownValue = newValue!;
              }),
          Padding(
            padding: context.onlyLeftPaddingLow,
            child: menuLabel(context, context.l10n.plans),
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
                    height: 475,
                    child: (missionList[today] != null)
                        ? ListView.builder(
                            itemCount: (missionList[today] ?? []).length,
                            itemBuilder: (BuildContext context, int index) {
                              var items = missionList[today];
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20)),
                                      ),
                                      builder: (context) => SizedBox(
                                            height: context.dynamicHeight(0.6),
                                            child: MissionBottomSheet(
                                              positiveText:
                                                  context.l10n.archive,
                                              mission: items[index],
                                              positiveIcon: Icons.archive,
                                              missionStatus:
                                                  MissionStatus.dones,
                                              positiveOnPressed: () {
                                                context
                                                    .read<DoneViewModel>()
                                                    .archiveMissions(context,
                                                        items[index].id!)
                                                    .then((val) {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              negativeOnPressed: () => context
                                                  .read<DoneViewModel>()
                                                  .deleteMissions(context,
                                                      items![index].id!),
                                            ),
                                          ));
                                },
                                child: CardWidget(
                                    mission: items[index],
                                    missionStatus: MissionStatus.dones,
                                    positiveIcon: Icons.archive,
                                    positiveOnPressed: () => context
                                        .read<DoneViewModel>()
                                        .archiveMissions(
                                            context, items![index].id!),
                                    negativeOnPressed: () => context
                                        .read<DoneViewModel>()
                                        .deleteMissions(
                                            context, items![index].id!),
                                    editDescriptionOnPressed: () {
                                      context
                                          .read<PlanViewModel>()
                                          .prepareEditMission(items![index]);
                                      createBottomSheet(context,
                                          isEdit: true,
                                          isEditDescription: true,
                                          status: MissionStatus.dones);
                                    },
                                    positiveText: context.l10n.archive,
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
          )
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text(
        context.l10n.done,
        style: context.textTheme.displayMedium,
      ),
    );
  }
}
