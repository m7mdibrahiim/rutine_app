import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rutine_app/providers/todo_provider.dart';
import 'package:rutine_app/screens/todo_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TodoProvider(),
        ),
      ],
      child: const ToDo_App(),
    ),
  );
}

class ToDo_App extends StatelessWidget {
  const ToDo_App({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      //designSize:   Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TodoScreen(),
      ),
    );
  }
}
