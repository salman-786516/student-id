import 'package:flutter/material.dart';

void main() => runApp(const SalmanApp());

class SalmanApp extends StatelessWidget {
  const SalmanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _noteController = TextEditingController();
  String? _lastNote;

  final _courses = const [
    ['Mobile Application Development', 'CSC303', 'Sir Usman'],
    ['Artificial Intelligence', 'CSC401', 'Ma\'am Sana'],
    ['Web Engineering', 'CSC320', 'Sir Bilal'],
    ['Information Security', 'CSC415', 'Sir Kamran'],
    ['Professional Practices', 'HUM310', 'Ma\'am Hira'],
  ];

  final _colors = const [
    Colors.deepOrange, Colors.indigo, Colors.green, Colors.pink, Colors.brown,
  ];

  void _submitNote() {
    final text = _noteController.text.trim();
    if (text.isEmpty) return;
    setState(() => _lastNote = text);
    _noteController.clear();
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Note saved successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Portal'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      drawer: const Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.deepOrange),
              accountName: Text('Salman'),
              accountEmail: Text('salman@university.edu.pk'),
              currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
            ),
            ListTile(leading: Icon(Icons.account_circle), title: Text('My Profile')),
            ListTile(leading: Icon(Icons.badge), title: Text('Digital ID Card')),
            ListTile(leading: Icon(Icons.grade), title: Text('My Results')),
            ListTile(leading: Icon(Icons.logout), title: Text('Logout')),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildIdCard(),
          const SizedBox(height: 20),
          const Text('Current Semester Courses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _courses.length,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _colors[i],
                    child: Text('${i + 1}', style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text(_courses[i][0]),
                  subtitle: Text(_courses[i][2]),
                  trailing: Text(_courses[i][1], style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              );
            },
          ),
          if (_lastNote != null)
            Card(
              color: Colors.orange.shade50,
              child: ListTile(
                leading: const Icon(Icons.sticky_note_2, color: Colors.deepOrange),
                title: const Text('Your Note'),
                subtitle: Text(_lastNote!),
              ),
            ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _noteController,
                  onSubmitted: (_) => _submitNote(),
                  decoration: InputDecoration(
                    hintText: 'Write a quick note...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _submitNote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIdCard() {
    const white = TextStyle(color: Colors.white, fontSize: 14);
    return Card(
      elevation: 6,
      margin: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF6F00), Color(0xFFD84315)],
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(radius: 40, backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 44, color: Colors.deepOrange)),
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Salman', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Roll No: 22-CS-118', style: white),
                  Text('Department: Computer Science', style: white),
                  Text('Semester: 7th', style: white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}