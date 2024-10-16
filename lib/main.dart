import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todolist/config/mange_theme.dart';
import 'package:todolist/config/theme.dart';
import 'package:todolist/data/repo/repository.dart';
import 'package:todolist/data/source/hive_task_source.dart';
import 'package:todolist/home/home.dart';
import 'package:todolist/task.dart';

const boxName = 'tasks'; 


void main() async {
  
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<Task>(boxName);

  runApp(
    ChangeNotifierProvider(
    create: (_) => ThemeProvider(),
    child: ChangeNotifierProvider<Repository<Task>>(
      create: (context)=>Repository<Task>(HiveTaskSource(Hive.box(boxName))),
      child: const MyApp()),
    )
    );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      home:   HomeScreen()
    );
  }
}



