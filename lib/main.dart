import 'package:flutter/material.dart';

void main() => runApp(Todo());

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItems(_todoItems[index], index);
        }
      },
    );
  }

  Widget _buildTodoItems(String todoText, int index) {
    return ListTile(
      title: Text(todoText),
      onTap: () => _promptRemoveTodoItem(index),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: new AppBar(title: Text('Add a new task')),
        body: TextField(
          autofocus: true,
          onSubmitted: (val) {
            _addTodoItem(val);
            Navigator.pop(context);
          },
          decoration: InputDecoration(
              hintText: 'Enter something to do...',
              contentPadding: EdgeInsets.all(16)),
        ),
      );
    }));
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Mark "${_todoItems[index]}" as done?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: new Text('CANCEL'),
              ),
              new FlatButton(
                  onPressed: () {
                    _removeTodoItem(index);
                    Navigator.of(context).pop();
                  },
                  child: Text('MARK AS DONE'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }
}
