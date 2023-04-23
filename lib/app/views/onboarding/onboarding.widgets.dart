import 'package:assume/app/routes/navigation_service.dart';
import 'package:assume/app/routes/routes.dart';
import 'package:assume/app/views/onboarding/onboarding.viewmodel.dart';
import 'package:assume/app/widgets/button/elevatedButton.widget.dart';
import 'package:assume/app/widgets/button/textButton.widget.dart';
import 'package:assume/app/widgets/output/alert_dialog/alert_dialog.widget.dart';
import 'package:assume/app/widgets/output/alert_dialog/show_alert_dialog.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingWidgets {
  Widget body(BuildContext context) {
    final viewModel = Provider.of<OnboardingViewModel>(context);

    return PageView.builder(
      itemCount: OnboardingViewModel.pageList.length,
      onPageChanged: (value) => viewModel.changePage(value),
      controller: viewModel.curPage,
      itemBuilder: (BuildContext context, int itemIndex) {
        return Center(
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: context.horizontalPaddingMedium,
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Padding(
                                padding: context.verticalPaddingNormal,
                                child: SizedBox(
                                  height: 300,
                                  width: 300,
                                  child: Image.asset(
                                    OnboardingViewModel.pageList.elementAt(
                                      itemIndex,
                                    )["image"]!,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                  OnboardingViewModel.pageList.elementAt(
                                    itemIndex,
                                  )["text"]!,
                                  style: context.textTheme.headlineLarge),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: context.paddingNormal,
                    child: (itemIndex ==
                            OnboardingViewModel.pageList.length - 1)
                        ? Column(
                            children: [
                              ElevatedButtonWidget(
                                onPressed: () {
                                  NavigationService.instance
                                      .navigateToPage(path: Routes.signIn.name);
                                },
                                text: context.l10n.signIn,
                              ),
                              TextButtonWidget(
                                onPressed: () {
                                  showAlertDialog(
                                      context,
                                      AlertDialogWidget(
                                        title:
                                            context.l10n.onboardingAlertTitle,
                                        content:
                                            context.l10n.onboardingAlertContent,
                                        approvePressed: () =>
                                            viewModel.loginWithAnon(context),
                                        cancelPressed: () =>
                                            Navigator.pop(context),
                                      ));
                                },
                                text: context.l10n.continueAnonymous,
                              ),
                            ],
                          )
                        : ElevatedButtonWidget(
                            onPressed: () {
                              viewModel.curPage.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            text: context.l10n.next,
                          ),
                  ),
                  SizedBox(
                    height: context.dynamicHeight(0.05),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar appbar(BuildContext context) {
    final provider = Provider.of<OnboardingViewModel>(context);

    return AppBar(
      actions: [
        if (provider.currentPage != 3)
          TextButtonWidget(
              text: context.l10n.skip,
              onPressed: () {
                context.read<OnboardingViewModel>().changePage(3);
                provider.curPage.jumpToPage(4);
              })
      ],
    );
  }
}
