class Todo {
  final int id;
  final String text;
  bool isComplete;

  Todo({required this.id, required this.text, this.isComplete = false});

  Todo toggleCompletion() {
    return Todo(id: id, text: text, isComplete: !isComplete);
  }
}
