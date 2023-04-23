import 'package:assume/app/widgets/output/priority.widget.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/model/mission/request/mission_request.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SmallCardWidget extends StatelessWidget {
  const SmallCardWidget(
      {required this.mission, required this.missionStatus, super.key});
  final MissionRequest mission;
  final MissionStatus missionStatus;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: PriorityWidget(
          importance: mission.importance,
          isChoosed: false,
        )),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(mission.title, style: context.textTheme.headlineLarge),
              Text(mission.description,
                  style: context.textTheme.headlineMedium,
                  overflow: TextOverflow.ellipsis)
            ],
          ),
        ),
        Expanded(
          child: Text(
            DateFormat.Hm().format(mission.startedAt!),
            style: context.textTheme.headlineSmall,
          ),
        )
      ],
    );
  }
}
