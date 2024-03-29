import 'package:flutter/material.dart';
import 'package:student_checkin_app/store/app_store.dart';

class StudentTab extends StatefulWidget {
  const StudentTab({super.key});

  @override
  State<StudentTab> createState() => _StudentTabState();
}

class _StudentTabState extends State<StudentTab> {
  var i = 1;
  final iChanged = ChangeNotifier();

  @override
  void initState() {
    super.initState();
    getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListenableBuilder(
          listenable: iChanged,
          builder: (BuildContext context, Widget? child) {
            return Text('Students $i');
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              i++;
              iChanged.notifyListeners();
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ListenableBuilder(
          listenable: studentsChanged,
          builder: (context, child) {
            return ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text('Name ${students[index]['fullname']}'),
                    subtitle: Text('Code ${students[index]['code']}'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.star),
                    ),
                  );
                });
          }),
    );
  }
}
