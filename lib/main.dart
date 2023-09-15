import 'package:flutter/material.dart';
import 'package:todo_flutter/components/task_dialog.dart';
import 'package:todo_flutter/data/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My To do List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> tasks = [
    Task(title: 'Buy groceries'),
    Task(title: 'Finish homework'),
    Task(title: 'Call mom', isCompleted: false),
    Task(title: 'Go for a run', isCompleted: false),
  ];

  void editTask(int index, String newTitle) {
    setState(() {
      tasks[index].title = newTitle;
    });
  }

  void _showAddTaskDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return TaskDialog(
          title: 'Edit Task',
          hintText: 'Enter task title',
          onSave: (title) {
            setState(() {
              tasks.add(Task(title: title));
            });
          },
        );
      },
    );
  }

  void _showEditTaskDialog(context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return TaskDialog(
          title: 'Edit Task',
          hintText: 'Enter new task title',
          onSave: (newTitle) {
            setState(() {
              tasks[index].title = newTitle;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My To-do list'),
      ),
      body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(tasks[index].title),
              leading: Checkbox(
                value: tasks[index].isCompleted,
                onChanged: (newValue) {
                  setState(() {
                    tasks[index].isCompleted = newValue!;
                  });
                },
              ),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(
                    onPressed: () {
                      _showEditTaskDialog(context, index);
                    },
                    icon: Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        tasks.removeAt(index);
                      });
                    },
                    icon: Icon(Icons.delete)),
              ]),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        tooltip: 'add task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
