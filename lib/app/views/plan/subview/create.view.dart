import 'package:assume/app/views/plan/plan.viewmodel.dart';
import 'package:assume/app/views/plan/widgets/category_wrap.widget.dart';
import 'package:assume/app/views/plan/widgets/error_text.widget.dart';
import 'package:assume/app/widgets/button/elevatedButton.widget.dart';
import 'package:assume/app/widgets/input/textFormField.widget.dart';
import 'package:assume/app/widgets/output/enabled.widget.dart';
import 'package:assume/app/widgets/output/priority.widget.dart';
import 'package:assume/core/constants/color_constants.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:assume/core/utils/validator/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class CreateView extends StatelessWidget {
  const CreateView({
    super.key,
    this.isEdit = false,
    this.isEditDescription = false,
    this.status = MissionStatus.plans,
  });
  final bool isEdit;
  final bool isEditDescription;
  final MissionStatus status;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlanViewModel>(context);
    provider.getCreateCategories();
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).scaffoldBackgroundColor),
      margin: context.paddingLow,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstant.instance.transparent,
        appBar: AppBar(
          leading: const SizedBox(),
          backgroundColor: ColorConstant.instance.transparent,
          title: Text(
            isEdit ? context.l10n.edit : context.l10n.create,
            style: context.textTheme.displayMedium,
          ),
          actions: [
            CircleAvatar(
              backgroundColor: context.color.mainColor,
              child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close,
                      color: Theme.of(context).brightness == Brightness.light
                          ? context.color.light
                          : context.color.dark)),
            )
          ],
        ),
        body: Padding(
          padding: context.paddingNormal,
          child: SingleChildScrollView(
            child: Form(
              key: provider.createFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: context.onlyTopPaddingLow,
                        child: TextFormFieldWidget(
                          enabled: !isEditDescription,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          label: context.l10n.title,
                          controller: provider.titleText,
                          validator: (value) {
                            return FormValidator.defaultValidator(
                              value!,
                              message: context.l10n.title,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: context.verticalPaddingNormal,
                        child: TextFormFieldWidget(
                            autofocus: isEditDescription,
                            textInputAction: TextInputAction.done,
                            minLines: 1,
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            label: context.l10n.description,
                            validator: (value) {
                              return FormValidator.defaultValidator(value!,
                                  message: context.l10n.description,
                                  maxLength: 100);
                            },
                            controller: provider.descriptionText),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ErrorTextWidget(
                              errorText: context.l10n.dateCantEmpty,
                              hasError: provider.hasDateError,
                              child: EnabledWidget(
                                enabled: !isEditDescription,
                                child: ElevatedButtonWidget(
                                    text: context.l10n.date,
                                    onPressed: () async {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime.now(),
                                          onConfirm: (date) {
                                        provider.date = date;
                                        provider.changeHasTimeError(false);
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.en);
                                    }),
                              ),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Expanded(
                            flex: 2,
                            child: ErrorTextWidget(
                              errorText: context.l10n.timeCantEmpty,
                              hasError: provider.hasTimeError,
                              child: EnabledWidget(
                                enabled: !isEditDescription,
                                child: ElevatedButtonWidget(
                                    text: context.l10n.time,
                                    onPressed: () async {
                                      DatePicker.showTimePicker(context,
                                          showSecondsColumn: false,
                                          showTitleActions: true,
                                          onConfirm: (time) {
                                        provider.time = time;
                                        provider.changeHasTimeError(false);
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.en);
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: context.verticalPaddingLow,
                        child: Text(context.l10n.priority,
                            style: context.textTheme.bodyLarge),
                      ),
                      ErrorTextWidget(
                        errorText: context.l10n.priorityCantEmpty,
                        hasError: provider.hasImportanceError,
                        child: EnabledWidget(
                          enabled: !isEditDescription,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: context.color.grey,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 300,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return IconButton(
                                          onPressed: () {
                                            provider
                                                .changeImportanceCreateValue(
                                                    index + 1);
                                          },
                                          icon: PriorityWidget(
                                            importance: index + 1,
                                            isChoosed: provider
                                                    .importanceCreateValue ==
                                                index + 1,
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: context.verticalPaddingLow,
                        child: Text(context.l10n.categories,
                            style: context.textTheme.bodyLarge),
                      ),
                      ErrorTextWidget(
                        errorText: context.l10n.categoryCantEmpty,
                        hasError: provider.hasCategoryError,
                        child: EnabledWidget(
                          enabled: !isEditDescription,
                          child: SizedBox(
                            height: 130,
                            width: double.infinity,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: context.color.grey,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: context.paddingLow,
                                  child: const CategoryWrapWidget(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: context.verticalPaddingNormal,
                    child: ElevatedButtonWidget(
                        text: isEdit ? context.l10n.edit : context.l10n.add,
                        onPressed: isEdit
                            ? () async {
                                provider.editMission(context, status).then(
                                    (value) => Navigator.of(context).pop());
                              }
                            : () async {
                                await provider
                                    .createMission(context)
                                    .then((value) {
                                  if (value) {
                                    Navigator.of(context).pop();
                                  }
                                });
                              }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
