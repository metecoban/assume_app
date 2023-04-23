import 'package:assume/app/views/plan/plan.viewmodel.dart';
import 'package:assume/app/views/plan/plan.widgets.dart';
import 'package:assume/app/widgets/card/card.widget.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/model/mission/request/mission_request.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MissionBottomSheet extends StatelessWidget {
  const MissionBottomSheet({
    super.key,
    required this.mission,
    required this.missionStatus,
    this.negativeIcon = Icons.delete,
    required this.negativeOnPressed,
    required this.positiveOnPressed,
    this.editOnPressed,
    this.editableText,
    this.positiveIcon,
    this.positiveText,
    this.negativeText,
    this.isStop = false,
    this.negativeIconColor,
  });
  final MissionRequest mission;
  final MissionStatus missionStatus;
  final IconData? negativeIcon;
  final IconData? positiveIcon;
  final VoidCallback negativeOnPressed;
  final VoidCallback positiveOnPressed;
  final VoidCallback? editOnPressed;
  final String? editableText;
  final String? positiveText;
  final String? negativeText;
  final bool isStop;
  final Color? negativeIconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.5),
      width: double.infinity,
      child: Stack(children: [
        CardWidget(
            positiveText: positiveText,
            negativeText: negativeText,
            isStop: isStop,
            negativeIconColor: negativeIconColor,
            hasBorder: false,
            mission: mission,
            cardType: CardType.large,
            positiveIcon: positiveIcon,
            negativeIcon: negativeIcon,
            negativeOnPressed: negativeOnPressed,
            editableText: editableText,
            editDescriptionOnPressed: () {
              context.read<PlanViewModel>().prepareEditMission(mission);
              createBottomSheet(context,
                  isEdit: true, isEditDescription: true, status: missionStatus);
            },
            editOnPressed: editOnPressed,
            positiveOnPressed: positiveOnPressed,
            missionStatus: missionStatus),
        Padding(
          padding: context.paddingLow,
          child: Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              backgroundColor: context.color.mainColor,
              child: IconButton(
                icon: Icon(Icons.close,
                    color: Theme.of(context).brightness == Brightness.light
                        ? context.color.light
                        : context.color.dark),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
