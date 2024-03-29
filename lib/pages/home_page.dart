import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_checkin_app/pages/student_tab.dart';
import 'package:student_checkin_app/pages/summary_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabCtrl;

  @override
  void initState() {
    super.initState();
    tabCtrl = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student System'),
      ),
      body: TabBarView(
        controller: tabCtrl,
        children: [
          const SummaryTab(),
          StudentTab(),
        ],
      ),
      bottomNavigationBar: TabBar(controller: tabCtrl, tabs: const [
        Tab(child: Text('Summary')),
        Tab(child: Text('Students')),
      ]),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          context.push('/checkin');
        },
        child: const Icon(Icons.check_circle),
      ),
      drawer: const Column(
        children: [
          Text('item 1'),
          Text('item 2'),
        ],
      ),
    );
  }
}
