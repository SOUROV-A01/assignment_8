import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ToDo> todos = [];
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _daysController = TextEditingController();

  GlobalKey<FormState> taskForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.amber,
          title: const Text(
            'Task Management',
            style: TextStyle(fontSize: 24),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Add Task'),
                    content: SingleChildScrollView(
                      child: SizedBox(
                        height: 350,
                        child: Form(
                            key: taskForm,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _titleController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Title',
                                  ),
                                  validator: (String? value) {
                                    if (value?.trim().isEmpty ?? true) {
                                      return 'Please Enter Your Tilte';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _descriptionController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 10)),
                                    hintText: 'Description',
                                  ),
                                  maxLines: 4,
                                  validator: (String? value) {
                                    if (value?.trim().isEmpty ?? true) {
                                      return 'Please Enter Description';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _daysController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter Days Required',
                                  ),
                                  validator: (String? value) {
                                    if (value?.trim().isEmpty ?? true) {
                                      return 'Please Enter Your Day';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )),
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            if (taskForm.currentState!.validate()) {
                              todos.add(ToDo(
                                  _titleController.text.trim(),
                                  _descriptionController.text.trim(),
                                  _daysController.text.trim()));
                              if (mounted) {
                                setState(() {});
                              }
                              Navigator.pop(context);
                            }
                            _titleController.clear();
                            _descriptionController.clear();
                            _daysController.clear();
                          },
                          child: const Text('Save'))
                    ],
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text("${todos[index].title}"),
                      subtitle: Text(
                          "${todos[index].description} \nday required- ${todos[index].daysrequired}"),
                      onLongPress: () {
                        show(index);
                      },
                    ),
                  );
                }),
          ),
        ));
  }

  void show(indexId) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 230,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Task Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Title: " + todos[indexId].title,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Description: " + todos[indexId].description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Date Required: " + todos[indexId].daysrequired,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        todos.removeAt(indexId);
                        if (mounted) {
                          setState(() {});
                        }
                        Navigator.pop(context);
                      },
                      child: const Text('Delete'))
                ],
              ),
            ),
          );
        });
  }
}

class ToDo {
  String title, description, daysrequired;

  ToDo(this.title, this.description, this.daysrequired);
}
