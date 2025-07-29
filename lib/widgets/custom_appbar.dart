import 'package:flutter/material.dart';
import 'package:multiple_accounts/services/account_services.dart';


class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({super.key}) : preferredSize = Size.fromHeight(kToolbarHeight);

 @override
    final Size preferredSize; // default is 56.0

    @override
    _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
    AccountServices accountServices = AccountServices();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(accountServices.authService.currentUser!.email ?? "bos",),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.dehaze_sharp))],
    );
  }
}
