import 'package:admin/constants_and_variables.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/error_404/error_404_screen.dart';
import 'package:admin/screens/items/items_manager_screen.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/settings/settings_screen.dart';
import 'package:admin/screens/transactions/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '../.env');

  runApp(BlocProvider(
    create: (context) => MenuAppBloc(),
    child: MyApp(),
  ));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  if (settings.name == Routes.dashboard.name || settings.name == '/') {
    return MaterialPageRoute(builder: (_) => DashboardScreen());
  } else if (settings.name == Routes.transactions.name) {
    return MaterialPageRoute(builder: (_) => TransactionsScreen());
  } else if (settings.name == Routes.itemsManager.name) {
    return MaterialPageRoute(builder: (_) => ItemsManagerScreen());
  } else if (settings.name == Routes.settings.name) {
    return MaterialPageRoute(builder: (_) => SettingsScreen());
  } else {
    return MaterialPageRoute(builder: (_) => Error404Screen());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Admin Panel',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        builder: (context, child) {
          BlocProvider.of<MenuAppBloc>(context)
              .add(SetCurrentScreenEvent(Routes.dashboard));
          return BlocBuilder<MenuAppBloc, MenuAppState>(
            builder: (context, state) {
              return Scaffold(
                key: BlocProvider.of<MenuAppBloc>(context).scaffoldKey,
                drawer: Builder(builder: (context) => SideMenu()),
                body: SafeArea(
                    child: Navigator(
                  key: navigatorKey,
                  onGenerateRoute: onGenerateRoute,
                )),
              );
            },
          );
        });
  }
}
