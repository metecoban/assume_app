import 'package:assume/app/widgets/card/card.widget.dart';
import 'package:assume/app/widgets/output/priority.widget.dart';
import 'package:assume/app/widgets/output/title_and_value.widget.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/model/mission/request/mission_request.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MediumCardWidget extends StatelessWidget {
  const MediumCardWidget(
      {required this.mission, this.editDescriptionOnPressed, super.key});
  final MissionRequest mission;
  final VoidCallback? editDescriptionOnPressed;
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
          child: cardContent(
              context, mission, CardType.medium, editDescriptionOnPressed),
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

Column cardContent(BuildContext context, MissionRequest mission,
    CardType cardType, VoidCallback? editDescriptionOnPressed) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      TitleAndValueWidget(
          title: context.l10n.title,
          value: Text(
            mission.title,
            style: context.textTheme.headlineLarge,
          )),
      SizedBox(
        child: Row(
          children: [
            TitleAndValueWidget(
                title: context.l10n.description,
                value: cardType == CardType.medium
                    ? Container(
                        constraints: BoxConstraints(
                            maxWidth: context.dynamicWidth(0.35)),
                        child: Text(
                          mission.description,
                          overflow: TextOverflow.ellipsis,
                        ))
                    : Container(
                        constraints: BoxConstraints(
                            maxWidth: context.dynamicWidth(0.45)),
                        child: Text(
                          mission.description,
                        ),
                      )),
            IconButton(
              onPressed: editDescriptionOnPressed,
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
      TitleAndValueWidget(
          title: context.l10n.categories,
          value: SizedBox(
            width: context.dynamicWidth(0.45),
            child: SingleChildScrollView(
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                children: [
                  for (var i = 0; i < mission.category.length; i += 1)
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        color: context.color.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: context.horizontalPaddingLow,
                          child: Text(
                            mission.category[i],
                            style: context.textTheme.headlineSmall,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )),
    ],
  );
}
