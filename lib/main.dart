import 'package:course_app/providers/auth_provider.dart';
import 'package:course_app/providers/course_provider.dart';
import 'package:course_app/providers/student_provider.dart';
import 'package:course_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:course_app/app.dart';
import 'package:course_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:course_app/providers/classroom_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authProvider = AuthProvider();
  await authProvider.tryAutoLogin();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()..getUserInfo()),
        ChangeNotifierProvider(create: (_) => CourseProvider()),
        ChangeNotifierProvider(create: (_) => ClassroomProvider()),
        ChangeNotifierProvider(create: (_) => StudentProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tin Học LP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          surfaceTintColor: AppColors.primary,
          iconTheme: IconThemeData(color: Colors.white),
        )
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      home: const SplashScreen(),
    );
  }
}
