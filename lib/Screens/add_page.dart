import 'package:flutter/material.dart';
import 'package:task_management_application/notification/notification_service.dart';
import 'package:task_management_application/services/service.dart';
import 'package:task_management_application/utils/snackbar.dart';

class AddToPage extends StatefulWidget {
  final Map? todo;
  const AddToPage({
  super.key,
  this.todo,
  });
  @override
  State<AddToPage> createState() => _AddToPageState();
}

class _AddToPageState extends State<AddToPage> {
  String? _selectedStatus = 'Todo';
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;



  @override
  void initState(){
    super.initState();

    final todo = widget.todo;
    if(widget.todo != null) {
      isEdit = true;
      final title = todo?['title'];
      final description = todo?['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( isEdit ? 'Edit Todo' : 'Add Todo',),

      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          DropdownButton<String>(
            value: _selectedStatus,
            onChanged: (value) => setState(() => _selectedStatus = value),
            items: const [
              DropdownMenuItem(value: 'Todo', child: Text('Todo')),
              DropdownMenuItem(value: 'In Progress', child: Text('In Progress')),
              DropdownMenuItem(value: 'Completed', child: Text('Completed')),
            ],
          ),
          SizedBox(height: 20,),
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Description'),
          keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed:
          isEdit ?
          updateData : submitData,
              child: Text(
            isEdit ?
                  'Update' : 'Submit')),

        ],
      ),
    );
  }
  Future <void> updateData() async {
    final todo = widget.todo;
    if(todo == null){
      return;
    }
    final id = todo['_id'];
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "status": _selectedStatus,
      "is_completed": false,
    };
    final isSuccess = await TodoService.updateTodo(id, body);
    if (isSuccess){
      LocalNotifications.showSimpleNotification(

          title: "Task Updated",
          body: "This is a simple notification",
          payload: "This is simple data"
      );
      showSuccesssMessage(context,message: 'Updation Success');
    } else {
      showErrorMessage(context, message: 'Updation Failed');
    }
  }
  Future <void> submitData() async {
  final title = titleController.text;
  final description = descriptionController.text;
  final body = {
    "title": title,
    "description": description,
    "status": _selectedStatus,
    "is_completed": false,
  };
  final isSuccess = await TodoService.addTodo(body);
  if (isSuccess){

    print('Creation Success');
    showSuccesssMessage(context, message: 'Creation Success');
  } else {
    print('Creation Failed');
    showErrorMessage(context, message: 'Creation Failed');
  }
  }


}


