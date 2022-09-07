import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schetify/widget/page/init/init_page.dart';
import 'package:schetify/widget/page/init/login_page.dart';
import 'package:schetify/widget/page/init/user_registration_page.dart';
import 'package:schetify/widget/page/main_page.dart';
import 'package:schetify/widget/page/schedule/common/attendance_check_page.dart';
import 'package:schetify/widget/page/schedule/common/cost/splitting_the_cost.dart';
import 'package:schetify/widget/page/schedule/common/question/question.dart';
import 'package:schetify/widget/page/schedule/common/schedule_update_destination_page.dart';
import 'package:schetify/widget/page/schedule/common/label/settings_label.dart';
import 'package:schetify/widget/page/schedule/common/schedule_update_page.dart';
import 'package:schetify/widget/page/schedule/common/schedule_day_update_page.dart';
import 'package:schetify/widget/page/seat_distribution.dart';
import 'package:schetify/widget/page/setting/account/change_password/change_password.dart';
import 'package:schetify/widget/page/setting/account/change_password/enter_password.dart';
import 'package:schetify/widget/page/setting/account/settings_account.dart';

import '../provider/firebase_auth_provider.dart';

class AppRouter extends ConsumerWidget {
  const AppRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.read(firebaseAuthProvider);
    return MaterialApp(
      title: 'Hooks Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: (FirebaseAuth.instance.currentUser != null) ? '/main' : '/init',
      routes: <String, WidgetBuilder> {
        '/main': (BuildContext context) => MainPage(),
        '/settings/account': (BuildContext context) => const SettingsAccount(),
        '/settings/account/enterPassword': (BuildContext context) => const EnterPassword(),
        '/settings/account/changePassword': (BuildContext context) => const ChangePassword(),
        '/schedule/new': (BuildContext context) => ScheduleUpdatePage(),
        '/schedule/new/questionnaire': (BuildContext context) => Questionnaire(),
        '/schedule/new/day': (BuildContext context) => const ScheduleDayUpdatePage(),
        '/schedule/new/destination': (BuildContext context) => const ScheduleUpdateDestinationPage(),
        '/init': (BuildContext context) => const InitPage(),
        '/init/register': (BuildContext context) => const UserRegistrationPage(),
        '/init/login': (BuildContext context) => const LoginPage(),
        '/schedule/new/label': (BuildContext context) => const SettingsLabel(),
        '/schedule/new/cost': (BuildContext context) => const SplittingTheCost(),
        '/schedule/new/seat': (BuildContext context) => SeatDistribution(),
        '/schedule/attendance': (BuildContext context) => const AttendanceCheckPage(),
      },
    );
  }
}


