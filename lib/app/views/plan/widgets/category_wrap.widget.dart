import 'package:assume/app/views/plan/plan.viewmodel.dart';
import 'package:assume/app/widgets/output/alert_dialog/alert_dialog.widget.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryWrapWidget extends StatelessWidget {
  const CategoryWrapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlanViewModel>(context);
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      spacing: 8.0,
      runSpacing: 4.0,
      children: [
        SizedBox(
          height: 45,
          width: provider.isClickedCategoryAdd == false ? 60 : 210,
          child: InkWell(
            onTap: () => provider.isClickedCategoryAdd == false
                ? provider.changeCategoryAddSituation()
                : null,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                  child: context.watch<PlanViewModel>().isClickedCategoryAdd ==
                          false
                      ? const Text("+")
                      : SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  provider.newCategoryText.text = '';
                                  if (provider.editCategoryText != '') {
                                    provider.newCategoryText.text =
                                        provider.editCategoryText!;
                                    provider.addCategory();
                                  } else {
                                    provider.changeCategoryAddSituation();
                                  }
                                },
                                child: Padding(
                                    padding: context.horizontalPaddingLow,
                                    child: const Icon(Icons.close)),
                              ),
                              Expanded(
                                child: Center(
                                  child: TextField(
                                    controller: provider.newCategoryText,
                                    maxLength: 10,
                                    buildCounter: (BuildContext context,
                                            {int? currentLength,
                                            int? maxLength,
                                            required bool isFocused}) =>
                                        null,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: InputBorder.none,
                                      hintText: context.l10n.categories,
                                    ),
                                    onSubmitted: (value) {
                                      if (value.isNotEmpty) {
                                        provider.addCategory();
                                      }
                                    },
                                  ),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    provider.addCategory();
                                  },
                                  child: Padding(
                                    padding: context.horizontalPaddingLow,
                                    child: const Icon(Icons.check),
                                  )),
                            ],
                          ),
                        )),
            ),
          ),
        ),
        for (var i = 0;
            i < provider.createCategory.keys.toList().length;
            i += 1)
          FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              height: 45,
              child: Card(
                clipBehavior: Clip.hardEdge,
                color: provider.createCategory[
                            provider.createCategory.keys.toList()[i]] ==
                        true
                    ? context.color.mainColor
                    : const CardTheme().color,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: context.color.mainColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Icon(Icons.edit, color: context.color.light)],
                    ),
                  ),
                  secondaryBackground: Container(
                    color: context.color.mainColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.delete, color: context.color.light)
                      ],
                    ),
                  ),
                  confirmDismiss: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialogWidget(
                              title: context.l10n.deleteCategory,
                              approvePressed: () {
                                provider.deleteCategory(
                                    provider.createCategory.keys.toList()[i]);
                                Navigator.of(context).pop(false);
                              },
                              cancelPressed: () =>
                                  Navigator.of(context).pop(false),
                            );
                          });
                    } else {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialogWidget(
                              title: context.l10n.editCategory,
                              approvePressed: () {
                                provider.editCategory(
                                    provider.createCategory.keys.toList()[i]);
                                Navigator.of(context).pop(false);
                              },
                              cancelPressed: () =>
                                  Navigator.of(context).pop(false),
                            );
                          });
                    }
                  },
                  child: InkWell(
                    onTap: () => provider.chooseCreateCategory(i),
                    child: Padding(
                      padding: context.horizontalPaddingMedium,
                      child: Center(
                        child: Text(
                          provider.createCategory.keys.toList()[i],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
