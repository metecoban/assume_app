import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/model/mission/request/mission_request.dart';
import 'package:assume/core/service/local/hive/system_cache.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarWidget extends StatelessWidget {
  const TableCalendarWidget({
    super.key,
    required this.calendarFormat,
    required this.focusedDay,
    this.eventLoader,
    this.onDaySelected,
    required this.today,
  });
  final CalendarFormat calendarFormat;
  final DateTime focusedDay;
  final List<dynamic> Function(DateTime)? eventLoader;
  final Function(DateTime, DateTime)? onDaySelected;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        calendarBuilders: CalendarBuilders(
          markerBuilder: (BuildContext context, date, events) {
            if (events.isEmpty) return const SizedBox();
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return index > 3
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.all(1),
                          child: Container(
                            width: 7,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.color.mainColor.withOpacity(
                                  (events[index] as MissionRequest)
                                              .importance !=
                                          0
                                      ? 0.2 *
                                          (events[index] as MissionRequest)
                                              .importance
                                      : 0.2 * 1),
                            ),
                          ),
                        );
                });
          },
        ),
        locale:
            SystemCacheService.instance.getLanguage() == 0 ? 'en_US' : 'tr_TR',
        firstDay: DateTime.utc(2010, 10, 15),
        lastDay: DateTime.utc(2030, 3, 15),
        startingDayOfWeek: StartingDayOfWeek.monday,
        headerStyle: HeaderStyle(
            titleTextStyle: context.textTheme.labelLarge!,
            leftChevronIcon:
                Icon(Icons.chevron_left, color: context.color.mainColor),
            rightChevronIcon:
                Icon(Icons.chevron_right, color: context.color.mainColor),
            formatButtonVisible: false,
            titleCentered: true),
        calendarFormat: calendarFormat,
        focusedDay: focusedDay,
        availableGestures: AvailableGestures.all,
        calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
                color: context.color.mainColor.withOpacity(0.5),
                shape: BoxShape.circle),
            selectedDecoration: BoxDecoration(
                color: context.color.mainColor, shape: BoxShape.circle)),
        eventLoader: eventLoader,
        selectedDayPredicate: (day) => isSameDay(day, today),
        onDaySelected: onDaySelected);
  }
}
