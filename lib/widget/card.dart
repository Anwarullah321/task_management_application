import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigateToEdit;
  final Function(String) deleteById;
  const TodoCard({
    super.key,
    required this.index,
    required this.item, required this.navigateToEdit, required this.deleteById,
  });

  @override
  Widget build(BuildContext context) {
    final id = item['_id'] as String;
    return Card(
      elevation: 5, // Add shadow
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Round corners
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue, // Change color
          child: Text('${index + 1}', style: TextStyle(color: Colors.white)), // Change text color
        ),
        title: Text(item['title'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), // Change text style
        subtitle: Text(item['description'], style: TextStyle(fontSize: 16)), // Change text style
        trailing: PopupMenuButton(
          icon: Icon(Icons.more_vert, color: Colors.grey[700]), // Change icon color
          onSelected: (value){
            if (value == 'edit') {
              navigateToEdit(item);
            } else if (value == 'Delete'){
              deleteById(id);
            }
          },
          itemBuilder: (context){
            return [
              PopupMenuItem(
                child: Text('Edit'),
                value: 'edit',
              ),
              PopupMenuItem(
                child: Text('Delete'),
                value: 'Delete',
              )
            ];
          },
        ),
      ),
    );
  }
}
