import 'package:assume/app/views/plan/plan.viewmodel.dart';
import 'package:assume/app/views/plan/plan.widgets.dart';
import 'package:assume/app/views/profile/profile.viewmodel.dart';
import 'package:assume/app/views/run/widgets/mission_bottom.widget.dart';
import 'package:assume/app/widgets/card/card.widget.dart';
import 'package:assume/core/base/base_view/base_view.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArchiveView extends BaseView {
  const ArchiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return dynamicBuild(
      context,
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
        title: Text(
          context.l10n.archives,
          style: context.textTheme.displaySmall,
        ),
      );

  Widget _body(BuildContext context) {
    final provider = Provider.of<ProfileViewModel>(context);
    final archives = provider.getArchives();

    return SingleChildScrollView(
      child: Padding(
        padding: context.paddingNormal,
        child: Column(
          children: [
            SizedBox(
              height: context.dynamicHeight(0.8),
              width: context.dynamicWidth(1),
              child: (archives!.length != 0)
                  ? ListView.builder(
                      itemCount: archives!.length,
                      itemBuilder: (context, index) {
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
                                          positiveIcon: Icons.archive,
                                          positiveText: context.l10n.unarchive,
                                          mission: archives[index],
                                          missionStatus: MissionStatus.archives,
                                          negativeOnPressed: () =>
                                              MissionService.instance
                                                  .deleteMission(
                                                      archives[index].id!,
                                                      MissionStatus.archives),
                                          positiveOnPressed: () => {
                                                provider.archiveToDoneMissions(
                                                    archives[index].id),
                                                Navigator.pop(context)
                                              }),
                                    )).then((value) => provider.setState());
                          },
                          child: CardWidget(
                              mission: archives[index],
                              cardType: CardType.small,
                              negativeOnPressed: () => MissionService.instance
                                  .deleteMission(archives[index].id!,
                                      MissionStatus.archives),
                              positiveOnPressed: () => MissionService.instance
                                  .archiveToDoneMission(archives[index].id!),
                              editDescriptionOnPressed: () {
                                context
                                    .read<PlanViewModel>()
                                    .prepareEditMission(archives[index]);
                                createBottomSheet(context,
                                    isEdit: true,
                                    isEditDescription: true,
                                    status: MissionStatus.archives);
                              },
                              missionStatus: MissionStatus.archives),
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(context.l10n.noArchive),
                          Text(context.l10n.archiveMessage)
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
