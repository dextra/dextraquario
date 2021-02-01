import 'package:dextraquario/providers/app.dart';
import 'package:dextraquario/providers/auth.dart';
import 'package:dextraquario/screens/authentication.dart';
import 'package:dextraquario/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helper/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization;
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: AuthProvider.init()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dextraquario',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AppScreensController(),
      )));
}

class AppScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    switch (authProvider.status) {
      case Status.Uninitialized:
        print('uninitialized');
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        print('authenticating');
        return AuthenticationScreen();
      case Status.Authenticated:
        print('O usuario conseguiu entrar na plataforma');
        return Container();
      default:
        print('default');
        return AuthenticationScreen();
    }
  }
}
