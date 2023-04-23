import 'package:assume/app/widgets/card/widgets/large_card.widget.dart';
import 'package:assume/app/widgets/card/widgets/medium_card.widget.dart';
import 'package:assume/app/widgets/card/widgets/small_card.widget.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/model/mission/request/mission_request.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {required this.cardType,
      required this.mission,
      required this.positiveOnPressed,
      this.positiveIcon = Icons.play_arrow,
      this.negativeIcon = Icons.delete,
      this.editIcon,
      required this.negativeOnPressed,
      this.editOnPressed,
      this.editDescriptionOnPressed,
      required this.missionStatus,
      this.hasBorder,
      this.editableText,
      this.positiveText,
      this.negativeText,
      this.isStop = false,
      this.negativeIconColor,
      this.cardColor,
      super.key});

  final CardType cardType;
  final MissionRequest mission;
  final VoidCallback positiveOnPressed;
  final IconData? positiveIcon;
  final IconData? negativeIcon;
  final IconData? editIcon;
  final VoidCallback negativeOnPressed;
  final VoidCallback? editOnPressed;
  final VoidCallback? editDescriptionOnPressed;
  final MissionStatus missionStatus;
  final bool? hasBorder;
  final String? editableText;
  final String? positiveText;
  final String? negativeText;
  final bool isStop;
  final Color? negativeIconColor;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    Widget content = _selectCardWidget();
    return SizedBox(
      height: cardType == CardType.small
          ? context.dynamicHeight(0.135)
          : cardType == CardType.medium
              ? context.dynamicHeight(0.246)
              : context.dynamicHeight(0.49),
      child: Card(
          color: cardColor ??
              (Theme.of(context).brightness == Brightness.dark
                  ? context.color.dark
                  : context.color.light),
          shape: hasBorder ?? true
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: context.color.mainColor),
                )
              : const CardTheme().shape,
          elevation: hasBorder ?? false ? 1 : 0,
          child: content),
    );
  }

  Widget _selectCardWidget() {
    switch (cardType) {
      case CardType.small:
        return SmallCardWidget(mission: mission, missionStatus: missionStatus);
      case CardType.medium:
        return MediumCardWidget(
            mission: mission,
            editDescriptionOnPressed: editDescriptionOnPressed);
      case CardType.large:
        return LargeCardWidget(
          mission: mission,
          missionStatus: missionStatus,
          editDescriptionOnPressed: editDescriptionOnPressed,
          isStop: isStop,
          negativeOnPressed: negativeOnPressed,
          negativeIcon: negativeIcon,
          negativeText: negativeText,
          negativeIconColor: negativeIconColor,
          positiveOnPressed: positiveOnPressed,
          positiveIcon: positiveIcon,
          positiveText: positiveText,
          editOnPressed: editOnPressed,
          editIcon: editIcon,
          editableText: editableText,
        );
      default:
        return SmallCardWidget(mission: mission, missionStatus: missionStatus);
    }
  }
}

enum CardType { small, medium, large }
