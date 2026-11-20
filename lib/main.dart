
import 'package:flutter/material.dart';

class Task {
  String title;
  bool isCompleted;

  Task({
    required this.title,
    this.isCompleted = false,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daynote',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F7FC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B75D7),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Daynote'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  List<Task> tasks = [];
  final TextEditingController _taskController = TextEditingController();
  
  int get completedTasks =>
    tasks.where((task) => task.isCompleted).length;

  void _addTask() {
    String title = _taskController.text.trim();

    if (title.isEmpty) {
      return;
    }

    setState(() {
      tasks.add(Task(title: title));
    });

    _taskController.clear();
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header aplikasi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Daynote',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B75D7),
                      ),
                    ),
                    const Icon(
                      Icons.account_circle_outlined,
                      size: 32,
                      color: Color(0xFF8B75D7),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  'Good day!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF292638),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Let's organize your tasks today.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFA5A0B2),
                  ),
                ),
                // Ringkasan progress
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0ECFA),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Progress',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF65539E),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '$completedTasks / ${tasks.length}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF65539E),
                        ),
                      ),
                      const Text(
                        'Tasks completed',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF65539E),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                // Input tugas
                const Text(
                  'Add a new task',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF292638),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _taskController,
                        decoration: InputDecoration(
                          hintText: 'Enter your task...',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B75D7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: _addTask,
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                // Daftar tugas
                const Text(
                  "Today's tasks",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF292638),
                  ),
                ),
                const SizedBox(height: 12),

                Column(
                  children: tasks.map((task) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: task.isCompleted,
                            activeColor: const Color(0xFF8B75D7),
                            onChanged: (value) {
                              setState(() {
                                task.isCompleted = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              task.title,
                              style: TextStyle(
                                fontSize: 14,
                                color: const Color(0xFF292638),
                                decoration: task.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                tasks.remove(task);
                              });
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Color(0xFFA5A0B2),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
