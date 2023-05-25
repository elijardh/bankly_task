import 'package:bankly_task/app/presentations/colors.dart';
import 'package:bankly_task/core/transaction/bloc/transaction_bloc.dart';
import 'package:bankly_task/core/transaction/screens/transaction_history.dart';
import 'package:bankly_task/core/transaction/services/transaction_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TransactionServices(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TransactionBloc>(
            create: (context) => TransactionBloc()..add(GetTransaction()),
          )
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp(
            title: 'Bankly Task',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: TextTheme(
                  bodyLarge: TextStyle(
                    fontFamily: "SF UI Display",
                    fontSize: 15,
                    height: 1.0,
                    fontWeight: FontWeight.w400,
                    color: XColors.textColor,
                  ),
                  bodyMedium: TextStyle(
                    fontFamily: "SF UI Display",
                    fontSize: 15,
                    height: 1.0,
                    fontWeight: FontWeight.w400,
                    color: XColors.textColor,
                  ),
                  bodySmall: TextStyle(
                    fontFamily: "SF UI Display",
                    fontSize: 15,
                    height: 1.0,
                    fontWeight: FontWeight.w400,
                    color: XColors.textColor,
                  ),
                )),
            home: const TransactionHistoryScreen(),
          ),
        ),
      ),
    );
  }
}
