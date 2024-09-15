import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:todolist/config/mange_theme.dart';
import 'package:todolist/home/home.dart';

import '../../main.dart';
import '../../task.dart';

class AddEditScreen extends StatefulWidget {
    final Task task;
   const AddEditScreen({super.key, required this.task});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
late final TextEditingController _controller = TextEditingController(text: widget.task.name);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.surface,
      appBar: AppBar(
      //  leading: Switch(
      //             value: themeProvider.themeMode == ThemeMode.dark,
      //             onChanged: (value) {
      //               themeProvider.toggleThemeMode(value);
      //             },

      //             activeColor: Theme.of(context)
      //                 .colorScheme
      //                 .primary, // Color of the switch in active mode
      //             activeTrackColor: Theme.of(context)
      //                 .colorScheme
      //                 .primary
      //                 .withOpacity(0.5), // Track color in active mode
      //             inactiveThumbColor: Theme.of(context)
      //                 .colorScheme
      //                 .onSurface, // Thumb color in inactive mode
      //             inactiveTrackColor: Theme.of(context)
      //                 .colorScheme
      //                 .onSurface
      //                 .withOpacity(0.3), // Track color in inactive mode
      //             inactiveThumbImage: const AssetImage(
      //                 'assets/images/sun.png'), // Optional: Custom image for active state
      //             activeThumbImage: const AssetImage(
      //                 'assets/images/moon.png'), // Optional: Custom image for inactive state
      //           ),
        title: const Text('Edit Task'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 8.0,
        // backgroundColor: themeData.colorScheme.primary,
        // foregroundColor: themeData.colorScheme.onPrimary,

        onPressed: () {
        
          widget.task.name = _controller.text;
         widget.task.priority = widget.task.priority ?? Priority.low;

          if (widget.task.isInBox) {
            widget.task.save();
          } else {
            final Box<Task> box = Hive.box(boxName);
            box.add(widget.task);
          }
          Navigator.of(context).pop();
        },
        label: const Text('Save Changes'),
        icon: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                    flex: 1,
                    child: PrioritySelection(
                      onTap: () {
                        setState(() {
                          widget.task.priority = Priority.high;
                        });
                      },
                      label: 'Heigh',
                      isSelected: widget.task.priority == Priority.high,
                      color: const Color(0xFFD32F2F),
                      )),
                const SizedBox(
                  width: 8.0,
                ),
                Flexible(
                    flex: 1,
                    child: PrioritySelection(
                        onTap: () {
                          setState(() {
                            widget.task.priority = Priority.medium;
                          });
                        },
                        label: 'Normal',
                        isSelected: widget.task.priority == Priority.medium,
                        color: const Color(0xFFFFC107))),
                const SizedBox(
                  width: 8.0,
                ),
                Flexible(
                    flex: 1,
                    child: PrioritySelection(
                        onTap: () {
                          setState(() {
                            widget.task.priority = Priority.low;
                          });
                        },
                        label: 'low',
                        isSelected: widget.task.priority == Priority.low,
                        color: const Color(0xFF00BCD4))),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              maxLines: 3,
              controller: _controller,
              decoration: InputDecoration(
                
                // filled: true,
                fillColor: themeData.colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                label: Text(
                  'Enter Your task...',
                  style: TextStyle(
                    color: themeData.colorScheme.onSurface
                        .withOpacity(0.6), // Softer label color
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrioritySelection extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final GestureCancelCallback onTap;
  const PrioritySelection(
      {super.key,
      required this.label,
      required this.isSelected,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        height: 40,
        decoration: BoxDecoration(
            //  color: isSelected ? color.withOpacity(0.1):Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: isSelected
                    ? color
                    : themeData.colorScheme.onSurface.withOpacity(0.2),
                width: 2),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 6,
                )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
                child: Text(label,
                    style: themeData.textTheme.labelLarge!.copyWith(
                        color: isSelected
                            ? color
                            : themeData.colorScheme.onSurface.withOpacity(0.6),
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal))),
            const Spacer(),
            Center(
              child: CheckBoxAddEdit(
                value: isSelected,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckBoxAddEdit extends StatelessWidget {
  final bool value;
  final Color color;

  const CheckBoxAddEdit({super.key, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle, // Circular shape for a more modern look
        color: color,
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
              size: 12,
              color: Theme.of(context).colorScheme.onPrimary,
            )
          : null,
    );
  }
}
