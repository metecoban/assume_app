import 'package:assume/app/views/plan/plan.viewmodel.dart';
import 'package:assume/app/views/plan/widgets/category.widget.dart';
import 'package:assume/app/widgets/button/textButton.widget.dart';
import 'package:assume/app/widgets/output/priority.widget.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget(
      {super.key,
      this.isViewInvisible,
      required this.choosedItem,
      required this.onChanged});
  final bool? isViewInvisible;
  final Function(String?)? onChanged;

  final String choosedItem;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlanViewModel>(context);
    final items = [
      context.l10n.weekly,
      context.l10n.monthly,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        menuLabel(
          context,
          context.l10n.filter,
        ),
        const CategoryWidget(),
        Padding(
          padding: context.horizontalPaddingNormal,
          child: SizedBox(
            height: context.dynamicHeight(0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                provider.isClickedImportance
                    ? Expanded(child: _importanceCategoryWidget(context))
                    : TextButtonWidget(
                        text: context.l10n.priority,
                        onPressed: () {
                          provider.changeImportanceStuation();
                        },
                        textStyle: context.textTheme.labelLarge,
                        icon: Icons.circle,
                        isIconLeft: true,
                        iconColor: context.color.mainColor,
                      ),
                isViewInvisible ?? false
                    ? const SizedBox()
                    : DropdownButton(
                        value: choosedItem,
                        underline: const SizedBox(),
                        icon: Icon(
                          Icons.arrow_drop_down_outlined,
                          color: context.color.mainColor,
                        ),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: context.textTheme.labelLarge,
                            ),
                          );
                        }).toList(),
                        onChanged: onChanged,
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Padding menuLabel(BuildContext context, String name) {
    return Padding(
      padding: context.onlyLeftPaddingLow,
      child: Text(name, style: context.textTheme.bodyLarge),
    );
  }

  Widget _importanceCategoryWidget(BuildContext context) {
    final provider = Provider.of<PlanViewModel>(context);
    return SizedBox(
      height: context.dynamicHeight(0.05),
      width: context.dynamicWidth(0.7),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return IconButton(
              onPressed: () {
                provider.changeImportanceValue(index + 1);
              },
              icon: PriorityWidget(
                importance: index + 1,
                isChoosed: provider.importanceValue == index + 1,
              ),
            );
          }),
    );
  }
}
