
import 'package:flutter/material.dart';
import 'student.dart';

void main() {
  runApp(const StateApp());
}

class StateApp extends StatelessWidget {
  const StateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'State Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const StudentPage(),
    );
  }
}

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  List<Student> students = [];

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController courseController =
      TextEditingController(text: 'CSE');

  final Student student = Student(
    id: 1,
    name: 'Raj',
    course: 'CSE',
  );

  @override
  void initState() {
    super.initState();

    Map<String, dynamic> data = student.toJson();
    print(data);

    Student newStudent = Student.fromJson(data);
    print(newStudent.name);
  }

  void addStudent() {
    String name = nameController.text.trim();
    String course = courseController.text.trim();

    if (name.isEmpty || course.isEmpty) {
      return;
    }

    setState(() {
      students.add(
        Student(
          id: students.length + 1,
          name: name,
          course: course,
        ),
      );
    });

    nameController.clear();
    courseController.text = 'CSE';
  }

  @override
  void dispose() {
    nameController.dispose();
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EFF8),

      appBar: AppBar(
        title: const Text(
          'Student State Management',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // JSON Serialization Section
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '1. JSON Serialization',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(8),
                          ),

                          child: Text(
                            student.toJson().toString(),
                            style: const TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 13,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          'fromJson() Output: Reconstructed student: ${student.name} (${student.course})',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // State Management Section
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '2. State Management',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter Student Name',
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            SizedBox(
                              width: 85,
                              child: TextField(
                                controller: courseController,
                                decoration: const InputDecoration(
                                  hintText: 'Course',
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            ElevatedButton(
                              onPressed: addStudent,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Add'),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        ListView.builder(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(),
                          itemCount: students.length,
                          itemBuilder: (context, index) {
                            final item = students[index];

                            return Card(
                              color: const Color(0xFFEDE7F6),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      Colors.deepPurple,
                                  child: Text(
                                    '${item.id}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'Course: ${item.course}',
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
