import 'package:assume/app/views/home/home.viewmodel.dart';
import 'package:assume/app/views/home/home.widget.dart';
import 'package:assume/core/base/base_view/base_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends BaseView with HomeWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeViewModel>(context);

    return dynamicBuild(
      context,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: bottomNavBar(context),
      ),
      body: Center(
        child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: provider.pageController,
            itemCount: provider.pageOptions.length,
            itemBuilder: (context, index) {
              return provider.pageOptions.elementAt(index);
            }),
      ),
    );
  }
}
