import 'package:assume/app/widgets/card/card.widget.dart';
import 'package:assume/app/widgets/card/widgets/medium_card.widget.dart';
import 'package:assume/app/widgets/output/priority.widget.dart';
import 'package:assume/app/widgets/output/time.widget.dart';
import 'package:assume/app/widgets/output/title_and_value.widget.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/model/mission/request/mission_request.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LargeCardWidget extends StatefulWidget {
  const LargeCardWidget(
      {super.key,
      required this.mission,
      required this.missionStatus,
      required this.editDescriptionOnPressed,
      required this.isStop,
      required this.positiveOnPressed,
      this.positiveIcon,
      this.negativeIcon,
      this.editIcon,
      required this.negativeOnPressed,
      this.editOnPressed,
      this.editableText,
      this.positiveText,
      this.negativeText,
      this.negativeIconColor});
  final MissionRequest mission;
  final MissionStatus missionStatus;
  final VoidCallback? editDescriptionOnPressed;
  final bool isStop;
  final VoidCallback positiveOnPressed;
  final IconData? positiveIcon;
  final IconData? negativeIcon;
  final IconData? editIcon;
  final VoidCallback negativeOnPressed;
  final VoidCallback? editOnPressed;
  final String? editableText;
  final String? positiveText;
  final String? negativeText;
  final Color? negativeIconColor;

  @override
  State<LargeCardWidget> createState() => _LargeCardWidgetState();
}

class _LargeCardWidgetState extends State<LargeCardWidget>
    with SingleTickerProviderStateMixin {
  DateTime now = DateTime.now();

  late final CustomTimerController _controller;

  @override
  void initState() {
    if (widget.missionStatus == MissionStatus.runs) {
      _controller = CustomTimerController(
          vsync: this,
          begin: (widget.mission.finishedAt == null)
              ? now.difference(widget.mission.startedAt!)
              : widget.mission.finishedAt!
                  .difference(widget.mission.startedAt!),
          end: const Duration(days: 99),
          initialState: CustomTimerState.reset,
          interval: CustomTimerInterval.milliseconds);

      _controller.start();
    }

    super.initState();
  }

  @override
  void dispose() {
    if (widget.missionStatus == MissionStatus.runs) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.missionStatus == MissionStatus.runs) {
      _controller.begin = (widget.mission.finishedAt == null)
          ? now.difference(widget.mission.startedAt!)
          : widget.mission.finishedAt!.difference(widget.mission.startedAt!);
      _controller.reset();
      _controller.end = const Duration(days: 99);
      if (widget.isStop) {
        _controller.pause();
      } else {
        _controller.start();
      }
    }
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Expanded(
                  child: PriorityWidget(
                importance: widget.mission.importance,
                isChoosed: false,
              )),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    cardContent(context, widget.mission, CardType.large,
                        widget.editDescriptionOnPressed),
                    widget.missionStatus == MissionStatus.runs
                        ? _dynamicTimer(context)
                        : _missionTimeInfo(context),
                  ],
                ),
              ),
            ],
          ),
        ),
        _actions(context)
      ],
    );
  }

  Expanded _actions(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: context.onlyBottomPaddingLow,
        child: SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: 20,
            children: [
              if (widget.editOnPressed != null)
                InkWell(
                  onTap: widget.editOnPressed,
                  child: Padding(
                    padding: context.paddingLow,
                    child: Column(
                      children: [
                        CircleAvatar(
                            backgroundColor: context.color.orange,
                            child: Icon(
                              widget.editIcon ?? Icons.edit_note,
                              color: context.color.light,
                            )),
                        Text(
                          widget.editableText ?? context.l10n.edit,
                          style: context.textTheme.titleMedium!.copyWith(
                              color: widget.negativeIconColor ??
                                  context.color.orange),
                        )
                      ],
                    ),
                  ),
                ),
              InkWell(
                onTap: widget.negativeOnPressed,
                child: Padding(
                  padding: context.paddingLow,
                  child: Column(
                    children: [
                      CircleAvatar(
                          backgroundColor:
                              widget.negativeIconColor ?? context.color.red,
                          child: Icon(
                            widget.negativeIcon,
                            color: context.color.light,
                          )),
                      Text(widget.negativeText ?? context.l10n.delete,
                          style: context.textTheme.titleMedium!.copyWith(
                              color: widget.negativeIconColor ??
                                  context.color.red))
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: widget.positiveOnPressed,
                child: Padding(
                  padding: context.paddingLow,
                  child: Column(
                    children: [
                      CircleAvatar(
                          backgroundColor: context.color.green,
                          child: Icon(
                            widget.positiveIcon,
                            color: context.color.light,
                          )),
                      Text(
                        widget.positiveText ?? context.l10n.run,
                        style: context.textTheme.titleMedium!.copyWith(
                            color: widget.negativeIconColor ??
                                context.color.green),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _missionTimeInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TitleAndValueWidget(
              title: context.l10n.startTime,
              value: Text(DateFormat.Hm().format(widget.mission.startedAt!),
                  style: context.textTheme.headlineMedium),
            ),
            if (widget.missionStatus == MissionStatus.dones ||
                widget.missionStatus == MissionStatus.archives)
              Padding(
                padding: context.onlyLeftPaddingMedium,
                child: TitleAndValueWidget(
                  title: context.l10n.endTime,
                  value: Text(
                      DateFormat.Hm().format(widget.mission.finishedAt!),
                      style: context.textTheme.headlineMedium),
                ),
              ),
          ],
        ),
        if (widget.missionStatus == MissionStatus.dones ||
            widget.missionStatus == MissionStatus.archives)
          Padding(
            padding: context.onlyTopPaddingLow,
            child: TitleAndValueWidget(
              title: context.l10n.timeSpent,
              value: widget.mission.finishedAt != null
                  ? Padding(
                      padding: context.onlyTopPaddingLow,
                      child: Wrap(
                        spacing: 5,
                        children: [
                          TimeWidget(
                            text: context.l10n.dayUpper,
                            time: widget.mission.finishedAt!
                                .difference(widget.mission.startedAt!)
                                .inDays
                                .toString(),
                          ),
                          TimeWidget(
                            text: context.l10n.hour,
                            time: (widget.mission.finishedAt!
                                        .difference(widget.mission.startedAt!)
                                        .inHours %
                                    60)
                                .toString(),
                          ),
                          TimeWidget(
                            text: context.l10n.min,
                            time: (widget.mission.finishedAt!
                                        .difference(widget.mission.startedAt!)
                                        .inMinutes %
                                    60)
                                .toString(),
                          ),
                          TimeWidget(
                            text: context.l10n.sec,
                            time: (widget.mission.finishedAt!
                                        .difference(widget.mission.startedAt!)
                                        .inSeconds %
                                    60)
                                .toString(),
                          )
                        ],
                      ),
                    )
                  : Text(context.l10n.notUpdated,
                      style: context.textTheme.headlineMedium),
            ),
          ),
      ],
    );
  }

  Column _dynamicTimer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleAndValueWidget(
          title: context.l10n.timeSpent,
          value: Padding(
            padding: context.verticalPaddingLow,
            child: CustomTimer(
                controller: _controller,
                builder: (state, time) {
                  return Wrap(
                    spacing: 5,
                    children: [
                      TimeWidget(time: time.days, text: context.l10n.dayUpper),
                      TimeWidget(
                          time: time.hoursWithoutFill, text: context.l10n.hour),
                      TimeWidget(
                          time: time.minutesWithoutFill,
                          text: context.l10n.min),
                      TimeWidget(
                          time: time.secondsWithoutFill,
                          text: context.l10n.sec),
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }
}
