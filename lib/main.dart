import 'package:flutter/material.dart';
import 'task_list.dart';
import 'package:provider/provider.dart';
import 'task_view_model.dart';
import 'task_database.dart';
import 'package:go_router/go_router.dart';
import 'task.dart';

GoRouter router = GoRouter(
  initialLocation: '/home',
  // define your routes
  routes: [
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => TaskListScreen(),
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the database
  final database = await $FloorTaskDatabase.databaseBuilder('task_database2.db').build();

  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final TaskDatabase database;

  const MyApp({required this.database});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskViewModel>(
      create: (context) => TaskViewModel(database),
      child: MaterialApp.router(
        title: 'Task Planner ',
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),

      ),

    );

  }
}

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: TaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<TaskViewModel>().addSampleTasks();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

/*
class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: TaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            context.read<TaskViewModel>().addSampleTasks();
          });
        },
        child: Icon(Icons.add),
      ),
      persistentFooterButtons: [
        TextButton(
          onPressed: () {
            setState(() {
              context.read<TaskListState>().showAllTasks = !context.read<TaskListState>().showAllTasks;
            });
          },
          child: Text(
            context.watch<TaskListState>().showAllTasks ? "Show Today's Tasks" : 'Show All Tasks',
          ),
        ),
      ],
    );
  }
}

 */