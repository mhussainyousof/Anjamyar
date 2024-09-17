import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todolist/data/repo/repository.dart';
import 'package:todolist/home/add_edit_screen/add_edit_screen.dart';
import 'package:todolist/home/bloc/task_list_bloc.dart';
import 'package:todolist/main.dart';
import '../config/mange_theme.dart';
import '../task.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<String> searchKeywordNotifier = ValueNotifier('');
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    // final box = Hive.box<Task>(boxName);//! no Accessibility

    return BlocProvider<TaskListBloc>(
      create: (context)=> TaskListBloc(context.read<Repository<Task>>()),

      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('List of tasks'),
                  Switch(
                    value: themeProvider.themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      themeProvider.toggleThemeMode(value);
                    },
      
                    activeColor: Theme.of(context)
                        .colorScheme
                        .primary, // Color of the switch in active mode
                    activeTrackColor: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.5), // Track color in active mode
                    inactiveThumbColor: Theme.of(context)
                        .colorScheme
                        .onSurface, // Thumb color in inactive mode
                    inactiveTrackColor: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.3), // Track color in inactive mode
                    inactiveThumbImage: const AssetImage(
                        'assets/images/sun.png'), // Optional: Custom image for active state
                    activeThumbImage: const AssetImage(
                        'assets/images/moon.png'), // Optional: Custom image for inactive state
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.screen_share_outlined),
                  ),
                ],
              ),
              // const SizedBox(height: 2),
              SizedBox(
                height: 40, // ارتفاع موردنظر
                child: TextField(
                  onChanged: (value) {
                    context.read<TaskListBloc>().add(TaskListSearch(query: value));
                  },
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: 'search here...',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 6), // تنظیم padding آیکون
                      child: Icon(Icons.search, size: 20),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 0.0), // اینجا padding عمودی را صفر می‌گذاریم
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddEditScreen(
                          task: Task(),
                        )));
          },
          label: const Row(
            children: [
              Text('Add Task'),
              SizedBox(width: 8),
              Icon(Icons.add, size: 20),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(child: Consumer<Repository<Task>>(
              builder: (context, model, child){
                context.read<TaskListBloc>().add(TaskListStarted()); 
              return  BlocBuilder<TaskListBloc, TaskListState>(
                  builder: (context, state) {
                    
                if (state is TaskListLoaded) {
                  return TaskListView(items: state.items, themeData: themeData);
                } else if (state is TaskListEmpty) {
                  return EmptyState();
                } else if (state is TaskListLoading ||state is TaskListInitial) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is TaskListError) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                }else{
                  throw Exception('state is not a task list');
                }
              });},
            )),
          ],
        ),
      ),
    );
  }
}

class TaskListView extends StatelessWidget {
  const TaskListView({
    super.key,
    required this.items,
    required this.themeData,
  });

  final List<Task> items;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Today', style: themeData.textTheme.bodyLarge),
                    Container(
                      width: 50,
                      height: 3,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
                MaterialButton(
                  padding: const EdgeInsets.all(7.0),
                  height: 15,
                  elevation: 0,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  onPressed: () {
                  context.read<TaskListBloc>().add(TaskListDeleteAll());
                  },
                  child: Row(
                    children: [
                      Text(
                        'Delete All',
                        style: TextStyle(
                          fontSize: 14,
                          color: themeData.colorScheme.onPrimary
                              .withOpacity(0.6), // Improved text color
                        ),
                      ),
                      const SizedBox(width: 3),
                      Icon(Icons.delete,
                          color:
                              themeData.colorScheme.onPrimary.withOpacity(0.6),
                          size: 17), // Improved icon color
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          final Task task = items[index - 1];
          return TaskItem(task: task);
        }
      },
    );
  }
}

class TaskItem extends StatefulWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    final Color priorityColor;
    switch (widget.task.priority) {
      case Priority.low:
        priorityColor = const Color(0xFF00BCD4);
        break;
      case Priority.medium:
        priorityColor = const Color(0xFFFFC107);
        break;
      case Priority.high:
        priorityColor = const Color(0xFFD32F2F);
        break;
      default:
        priorityColor = Colors.grey;
        break;
    }
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddEditScreen(task: widget.task),
          ),
        );
      },
      onLongPress: () {
        final repository =
            Provider.of<Repository<Task>>(context, listen: false);
        repository.delete(widget.task);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).brightness == Brightness.light
                  ? const Color(0xFFE0F2F1) // Light teal gradient start
                  : const Color(0xFF1E1E1E), // Dark mode gradient start
              Theme.of(context).brightness == Brightness.light
                  ? const Color(0xFFB2DFDB) // Light teal gradient end
                  : const Color(0xFF121212), // Dark mode gradient end
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.withOpacity(0.3) // Light mode shadow
                  : Colors.black.withOpacity(0.7), // Dark mode shadow
              offset: const Offset(0, 4),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              CheckBox(
                  ontap: () {
                    setState(() {
                      widget.task.isCompleted = !widget.task.isCompleted;
                    });
                  },
                  value: widget.task.isCompleted),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    widget.task.name,
                    style: TextStyle(
                        decoration: widget.task.isCompleted
                            ? TextDecoration.lineThrough
                            : null),
                  ),
                ),
              ),
              Container(
                width: 5,
                height: 55,
                decoration: BoxDecoration(
                    color: priorityColor,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CheckBox extends StatelessWidget {
  final bool value;
  final GestureTapCallback ontap;

  const CheckBox({super.key, required this.value, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Circular shape for a more modern look
          border: value
              ? null
              : Border.all(
                  width: 2,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                ),
          color: value
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          boxShadow: [
            if (value) // Only add shadow if checked
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: value
            ? Icon(
                Icons.check,
                size: 16,
                color: Theme.of(context).colorScheme.onPrimary,
              )
            : null,
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 140,
        ),
        Center(
            child: Image.asset(
          'assets/images/empty.png',
          scale: 5,
        )),
        const Text(
          'No tasks found.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
