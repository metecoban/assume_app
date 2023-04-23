import 'package:assume/app/views/auth/sign_in/sign_in.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInWidgets {
  Widget body(BuildContext context) {
    final provider = Provider.of<SignInViewModel>(context);

    return Center(
        child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: provider.pageController,
            itemCount: provider.pageOptions.length,
            itemBuilder: (context, index) {
              return provider.pageOptions.elementAt(index);
            }));
  }
}
