import 'package:assume/app/views/plan/plan.viewmodel.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlanViewModel>(context);

    return SizedBox(
      height: 40,
      width: double.infinity,
      child: provider.planCategory.isNotEmpty
          ? ListView.builder(
              padding: context.onlyLeftPaddingNormal,
              scrollDirection: Axis.horizontal,
              itemCount: provider.planCategory.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: context.onlyRightPaddingLow,
                  child: InkWell(
                    onTap: () => provider.choosePlanCategory(index),
                    child: Chip(
                      side: BorderSide(color: context.color.mainColor),
                      labelPadding: context.horizontalPaddingNormal,
                      backgroundColor: provider.planCategory[
                                  provider.planCategory.keys.toList()[index]] ==
                              true
                          ? context.color.mainColor
                          : const ChipThemeData().backgroundColor,
                      label: Text(
                        provider.planCategory.keys.toList()[index],
                        style: TextStyle(
                          color: provider.planCategory[provider
                                      .planCategory.keys
                                      .toList()[index]] ==
                                  true
                              ? Theme.of(context).brightness == Brightness.light
                                  ? context.color.light
                                  : context.color.dark
                              : const ChipThemeData().backgroundColor,
                        ),
                      ),
                    ),
                  ),
                );
              })
          : Center(
              child: Text(
                context.l10n.planCategories,
                style: context.textTheme.bodyLarge,
              ),
            ),
    );
  }
}
