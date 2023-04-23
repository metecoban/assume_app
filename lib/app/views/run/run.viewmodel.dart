import 'package:assume/app/views/plan/plan.viewmodel.dart';
import 'package:assume/core/base/view_model/base_view_model.dart';
import 'package:assume/core/model/mission/request/mission_request.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RunViewModel extends BaseViewModel {
  int? limit;
  int get getLimit => limit ?? 0;
  void setLimit(int? limit) {
    this.limit = limit;
  }

  int _counter = 0;
  int get counter => _counter;
  void changeCounterValue(bool isIncrement) {
    isIncrement
        ? getLimit - 1 > _counter
            ? _counter++
            : null
        : _counter > 0
            ? _counter--
            : null;
    notifyListeners();
  }

  fetchMissions(BuildContext context) {
    var result = Provider.of<PlanViewModel>(context, listen: true)
        .getMissions(MissionStatus.runs);
    if (result!.keys.toList().length <= _counter) {
      _counter = 0;
    }

    setLimit(result.keys.toList().length);

    return result;
  }

  stopMission(MissionRequest mission) async {
    await MissionService.instance.stopMission(mission);
    notifyListeners();
  }

  reRunMission(BuildContext context, MissionRequest mission) async {
    await MissionService.instance.reRunMission(mission);
    notifyListeners();
  }

  finishMission(BuildContext context, String id) async {
    changeIsLoading(context);
    await MissionService.instance.doneMission(id).then((value) {
      changeIsLoading(context);
    });
    notifyListeners();
  }
}
