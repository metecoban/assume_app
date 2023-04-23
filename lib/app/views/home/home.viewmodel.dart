import 'package:assume/app/views/done/done.view.dart';
import 'package:assume/app/views/plan/plan.view.dart';
import 'package:assume/app/views/profile/profile.view.dart';
import 'package:assume/app/views/run/run.view.dart';
import 'package:assume/core/base/view_model/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeViewModel extends BaseViewModel {
  List<Widget> pageOptions = <Widget>[
    ShowCaseWidget(
      builder: Builder(builder: (context) => PlanView()),
    ),
    const RunView(),
    const DoneView(),
    const ProfileView(),
  ];

  PageController pageController = PageController(initialPage: 0);
  int? _currentPage = 0;
  int get currentPage => _currentPage ?? 0;

  changePage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  nextPage(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 750), curve: Curves.easeInOut);
    changePage(index);
  }

  @override
  void clear() {
    _currentPage = null;
  }
}
