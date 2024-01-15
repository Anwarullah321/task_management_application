import 'package:flutter/material.dart';
import 'package:task_management_application/Screens/add_page.dart';
import 'package:task_management_application/services/service.dart';
import 'package:task_management_application/utils/snackbar.dart';
import 'package:task_management_application/widget/card.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = true;
List items = [];
  void initState(){
    super.initState();
    fetchTodo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMA'),
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),

        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(child: Text('No Tosk Item',
            style: Theme.of(context).textTheme.headlineLarge,
            )),

            child: ListView.builder(
                itemCount: items.length,
                padding: EdgeInsets.all(5),
                itemBuilder: (context, index){
             final item = items[index] as Map;
             final id = item['_id'] as String;
             return TodoCard(
               index: index,
               deleteById: deleteById,
               item: item,
               navigateToEdit: navigateToEditPage,
             );
            }),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(

          onPressed: navigateToAddPage,
        label: Text('Add'),
      ),
    );
  }
  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
        builder: (context) => AddToPage(todo: item)
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }
  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddToPage()
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    final isSuccess = await TodoService.deleteById(id);
    if(isSuccess){
      print("inside function");
     final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    }
    else{
      showErrorMessage(context, message: 'Deletion Failed');
    }
  }
  Future<void> fetchTodo() async{
   final response = await TodoService.fetchTodos();
   if (response != null){
    setState(() {
      items = response;
    });
  }else{
     showErrorMessage(context, message: 'Something went wrong');
   }
   setState(() {
     isLoading = false;
   });
  }
  void showSuccesssMessage(String message){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
