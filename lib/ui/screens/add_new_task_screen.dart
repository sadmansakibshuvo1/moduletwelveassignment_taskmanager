import 'package:flutter/material.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../../style/style.dart';
import '../controller/input_validations.dart';
import '../widgets/background_image.dart';
import '../widgets/snack_bar.dart';
import '../widgets/top_profile_summary_card.dart';
import 'main_bottom_nav_screen.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectInputTEController =
  TextEditingController();
  final TextEditingController _descriptionInputTEController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool taskInProgress = false;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainBottomNavScreen(),
            ),
                (route) => false);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const TopProfileSummeryCard(),
              Expanded(
                child: WithBackGroundImage(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 40,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add New Task",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _subjectInputTEController,
                              decoration: const InputDecoration(
                                hintText: "Subject",
                              ),
                              validator: FormValidation.inputValidation,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _descriptionInputTEController,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                  hintText: "Description"),
                              validator: FormValidation.inputValidation,
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: Visibility(
                                visible: taskInProgress == false,
                                replacement: Center(
                                  child: CircularProgressIndicator(
                                      color: PrimaryColor.color),
                                ),
                                child: ElevatedButton(
                                  onPressed: _createNewTask,
                                  child: const Icon(
                                      Icons.arrow_circle_right_outlined),
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createNewTask() async {
    if (_formKey.currentState!.validate()) {
      taskInProgress = true;
      if (mounted) {
        setState(() {});
      }

      final NetworkResponse response =
      await NetworkCaller.postRequest(Urls.createNewTask, body: {
        "title": _subjectInputTEController.text.trim(),
        "description": _descriptionInputTEController.text.trim(),
        "status": "New",
      });

      taskInProgress = false;
      if (mounted) {
        setState(() {});
      }

      if (response.isSuccess) {
        _subjectInputTEController.clear();
        _descriptionInputTEController.clear();
        if (mounted) {
          showSnackBar(context, "Congratulations, New Task Added Successfully!");
        }
      } else {
        if (mounted) {
          showSnackBar(context, "Sorry, Failed! Please Try Again.", true);
        }
      }
    }
  }

  @override
  void dispose() {
    _subjectInputTEController.dispose();
    _descriptionInputTEController.dispose();
    super.dispose();
  }
}