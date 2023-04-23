import 'package:assume/app/views/home/home.viewmodel.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeWidget {
  Widget bottomNavBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: context.color.mainColor, width: 0.5))),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: const Icon(Icons.add_circle_outline),
              label: context.l10n.plan),
          BottomNavigationBarItem(
              icon: const Icon(Icons.run_circle_outlined),
              label: context.l10n.run),
          BottomNavigationBarItem(
              icon: const Icon(Icons.check_circle_outline),
              label: context.l10n.done),
          BottomNavigationBarItem(
              icon: const Icon(Icons.account_circle_outlined),
              label: context.l10n.profile),
        ],
        currentIndex: context.watch<HomeViewModel>().currentPage,
        onTap: (index) {
          context.read<HomeViewModel>().changePage(index);
          context.read<HomeViewModel>().pageController.animateToPage(index,
              duration: const Duration(milliseconds: 750),
              curve: Curves.easeInOut);
        },
      ),
    );
  }
}
