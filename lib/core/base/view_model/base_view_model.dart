import 'package:assume/app/widgets/output/show_loading.widget.dart';
import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool isLoading = false;
  final bool systemOverLay = false;

  void changeIsLoading(BuildContext context) {
    isLoading = !isLoading;
    isLoading ? showCircularProgress(context) : Navigator.pop(context);
    notifyListeners();
  }

  bool systemOverLayFunc() {
    return systemOverLay != systemOverLay;
  }

  void showSnackBar(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void clear() {}
}
