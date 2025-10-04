import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      home: const TodoListPage(),
    );
  }
}

class TodoItem {
  TodoItem({required this.title, this.isDone = false});

  final String title;
  bool isDone;

  Map<String, dynamic> toJson() => {'title': title, 'isDone': isDone};
  static TodoItem fromJson(Map<String, dynamic> json) => TodoItem(
    title: json['title'] as String,
    isDone: json['isDone'] as bool? ?? false,
  );
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _textController = TextEditingController();
  final List<TodoItem> _todos = <TodoItem>[];
  static const String _prefsKey = 'todos_v1';

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _loadTodos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? raw = prefs.getStringList(_prefsKey);
    if (raw == null) return;
    final List<TodoItem> loaded = <TodoItem>[];
    for (final String item in raw) {
      try {
        final Map<String, dynamic> map =
            jsonDecode(item) as Map<String, dynamic>;
        loaded.add(TodoItem.fromJson(map));
      } catch (_) {
        // Fallback: treat as plain title string
        if (item.trim().isNotEmpty) {
          loaded.add(TodoItem(title: item.trim()));
        }
      }
    }
    setState(() {
      _todos
        ..clear()
        ..addAll(loaded);
    });
  }

  Future<void> _persistTodos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Store as a list of JSON strings for simplicity and order preservation
    final List<String> data =
        _todos.map((TodoItem t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList(_prefsKey, data);
  }

  void _addTodo() {
    final String text = _textController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _todos.add(TodoItem(title: text));
      _textController.clear();
    });
    _persistTodos();
  }

  void _toggleDone(int index, bool? value) {
    setState(() {
      _todos[index].isDone = value ?? false;
    });
    _persistTodos();
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
    _persistTodos();
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = _todos.where((todo) => todo.isDone).length;
    final totalCount = _todos.length;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Todos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (totalCount > 0)
              Text(
                '$completedCount of $totalCount completed',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
            ),
          ),
        ),
        toolbarHeight: 100,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2E7D32), Color(0xFF4CAF50), Color(0xFF66BB6A)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: TextField(
                              controller: _textController,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                hintText: 'What needs to be done?',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.transparent,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                              ),
                              onSubmitted: (_) => _addTodo(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF2E7D32).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: _addTodo,
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child:
                      _todos.isEmpty
                          ? Center(
                            child: TweenAnimationBuilder<double>(
                              duration: const Duration(milliseconds: 800),
                              tween: Tween(begin: 0.0, end: 1.0),
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: 0.8 + (0.2 * value),
                                  child: Opacity(opacity: value, child: child),
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.task_alt_outlined,
                                      size: 56,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'All caught up!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    'No tasks yet. Tap the add button\nabove to get started!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          : ListView.separated(
                            itemCount: _todos.length,
                            separatorBuilder:
                                (_, __) => const SizedBox(height: 12),
                            itemBuilder: (BuildContext context, int index) {
                              final TodoItem todo = _todos[index];
                              return TweenAnimationBuilder<double>(
                                duration: Duration(
                                  milliseconds: 300 + (index * 50),
                                ),
                                tween: Tween(begin: 0.0, end: 1.0),
                                builder: (context, value, child) {
                                  return Transform.translate(
                                    offset: Offset(0, 20 * (1 - value)),
                                    child: Opacity(
                                      opacity: value,
                                      child: child,
                                    ),
                                  );
                                },
                                child: Dismissible(
                                  key: ValueKey<String>(
                                    'todo_${todo.title}_$index',
                                  ),
                                  background: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Colors.redAccent, Colors.red],
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (_) => _deleteTodo(index),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.95),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),
                                          blurRadius: 15,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(16),
                                        onTap:
                                            () => _toggleDone(
                                              index,
                                              !todo.isDone,
                                            ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            children: [
                                              AnimatedContainer(
                                                duration: const Duration(
                                                  milliseconds: 300,
                                                ),
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  color:
                                                      todo.isDone
                                                          ? const Color(
                                                            0xFF4CAF50,
                                                          )
                                                          : Colors.transparent,
                                                  border: Border.all(
                                                    color:
                                                        todo.isDone
                                                            ? const Color(
                                                              0xFF4CAF50,
                                                            )
                                                            : Colors
                                                                .grey
                                                                .shade400,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child:
                                                    todo.isDone
                                                        ? const Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                          size: 16,
                                                        )
                                                        : null,
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: AnimatedDefaultTextStyle(
                                                  duration: const Duration(
                                                    milliseconds: 300,
                                                  ),
                                                  style: TextStyle(
                                                    decoration:
                                                        todo.isDone
                                                            ? TextDecoration
                                                                .lineThrough
                                                            : null,
                                                    color:
                                                        todo.isDone
                                                            ? Colors
                                                                .grey
                                                                .shade600
                                                            : Colors.black87,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                  ),
                                                  child: Text(todo.title),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.red.shade50,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                    onTap:
                                                        () =>
                                                            _deleteTodo(index),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            8.0,
                                                          ),
                                                      child: Icon(
                                                        Icons.delete_outline,
                                                        color:
                                                            Colors.red.shade400,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
