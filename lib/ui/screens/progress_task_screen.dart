import 'package:flutter/material.dart';
import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../../style/style.dart';
import '../widgets/task_list_card.dart';
import '../widgets/top_profile_summary_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool getTaskListInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getTaskList() async {
    getTaskListInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
    await NetworkCaller.getRequest(Urls.getProgressTaskList);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getTaskListInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopProfileSummeryCard(),
            Expanded(
              child: Visibility(
                visible: getTaskListInProgress == false,
                replacement: Center(
                  child: CircularProgressIndicator(color: PrimaryColor.color),
                ),
                child: RefreshIndicator(
                  color: PrimaryColor.color,
                  onRefresh: getTaskList,
                  child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskListCard(
                        statusColor: Colors.purple,
                        // task: ,
                        task: taskListModel.taskList![index],
                        onStatusChangeRefresh: () {
                          getTaskList();
                        },
                        taskUpdateStatusInProgress: (inProgress) {
                          getTaskListInProgress = inProgress;
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}