import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock data
  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Complete Math Chapter 5', 'done': false, 'tag': 'Study'},
    {'title': 'Review Physics Notes', 'done': true, 'tag': 'Review'},
    {'title': 'Submit History Assignment', 'done': false, 'tag': 'Deadline'},
  ];

  final List<Map<String, dynamic>> _objectives = [
    {'title': 'Score 90% in Finals', 'progress': 0.7},
    {'title': 'Read 5 Books this month', 'progress': 0.4},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tasks'),
            Tab(text: 'Objectives'),
            Tab(text: 'Reminders'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTasksList(),
              _buildObjectivesList(),
              _buildRemindersList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTasksList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _tasks.length + 1, // +1 for the "Add" button at the end or FAB
      itemBuilder: (context, index) {
        if (index == _tasks.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: FilledButton.icon(
                onPressed: () {
                  // Add task logic would go here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Add Task feature coming soon!')),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Add New Task'),
              ),
            ),
          );
        }
        final task = _tasks[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: CheckboxListTile(
            value: task['done'],
            title: Text(
              task['title'],
              style: TextStyle(
                decoration: task['done'] ? TextDecoration.lineThrough : null,
                color: task['done'] ? Colors.grey : null,
              ),
            ),
            subtitle: Text(task['tag']),
            secondary: const Icon(Icons.task_alt),
            onChanged: (val) {
              setState(() {
                task['done'] = val;
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildObjectivesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _objectives.length,
      itemBuilder: (context, index) {
        final obj = _objectives[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(obj['title'], style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: obj['progress'],
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 8),
                Text('${(obj['progress'] * 100).toInt()}% Completed', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRemindersList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text('No active reminders', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey)),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {},
            child: const Text('Set Reminder'),
          ),
        ],
      ),
    );
  }
}
