import 'package:flutter/material.dart';
import '../../data/models/task.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utility/urls.dart';
import '../../style/style.dart';


enum  TaskStatus {
  // ignore: constant_identifier_names
  New,
  // ignore: constant_identifier_names
  Progress,
  // ignore: constant_identifier_names
  Completed,
  // ignore: constant_identifier_names
  Cancelled,
}

class TaskListCard extends StatefulWidget {
  final Task task;
  final VoidCallback onStatusChangeRefresh;
  final Function(bool) taskUpdateStatusInProgress;
  final Color statusColor;

  const TaskListCard({
    super.key,
    required this.task,
    required this.onStatusChangeRefresh,
    required this.taskUpdateStatusInProgress,
    this.statusColor = Colors.pinkAccent,
  });

  @override
  State<TaskListCard> createState() => _TaskListCardState();
}

class _TaskListCardState extends State<TaskListCard> {
  Future<void> getTaskUpdateStatus(String status) async {
    widget.taskUpdateStatusInProgress(true);

    final response = await NetworkCaller.getRequest(
        Urls.updateTaskStatus(status, widget.task.sId ?? ''));
    if (response.isSuccess) {
      widget.onStatusChangeRefresh();
    }

    widget.taskUpdateStatusInProgress(false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          title: Text(
            widget.task.title ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.description ?? '',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                'Date: ${widget.task.createdDate}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(
                      widget.task.status ?? 'New',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    backgroundColor: widget.statusColor,
                    labelPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 8,
                    ),
                  ),
                  Wrap(
                    children: [
                      IconButton(
                        onPressed: () {
                          showUpdateDialog();
                        },
                        icon: Icon(Icons.edit_note, color: PrimaryColor.color),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Warning',
                                    style: TextStyle(color: Colors.cyan),
                                  ),
                                  content: const Text(
                                    "Are you sure that you want to delete it permanently?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: deleteTask,
                                      child: const Text(
                                        'Delete Task',
                                        style:
                                        TextStyle(color: Colors.deepOrange),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: const Icon(Icons.delete, color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showUpdateDialog() {
    List<ListTile> items = TaskStatus.values
        .map((e) => ListTile(
      title: Text(e.name),
      onTap: () {
        getTaskUpdateStatus(e.name);
        Navigator.pop(context);
      },
    ))
        .toList();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Update Status",
              style: TextStyle(color: Colors.yellow),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),
            ],
          );
        });
  }

  Future<void> deleteTask() async {
    if (mounted) {
      Navigator.pop(context);
    }
    widget.taskUpdateStatusInProgress(true);

    final response = await NetworkCaller.getRequest(
      Urls.deleteTask(widget.task.sId.toString()),
    );
    widget.taskUpdateStatusInProgress(true);
    if (response.isSuccess) {
      widget.onStatusChangeRefresh();
    }
  }
}
