import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'logic/crud.dart'; // Import CRUD class

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController hobiController = TextEditingController();
  String uid = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Form Input
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: namaController,
                    decoration: const InputDecoration(
                      labelText: "Nama",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: hobiController,
                    decoration: const InputDecoration(
                      labelText: "Hobi",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (uid.isEmpty) {
                        // Tambah Data
                        CRUD.addAssisten(
                          nama: namaController.text,
                          email: emailController.text,
                          hobi: hobiController.text,
                        );
                      } else {
                        // Update Data
                        CRUD.updateAssisten(
                          uid: uid,
                          nama: namaController.text,
                          email: emailController.text,
                          hobi: hobiController.text,
                        );
                      }

                      // Reset form setelah tambah/update
                      setState(() {
                        uid = '';
                        namaController.clear();
                        emailController.clear();
                        hobiController.clear();
                      });
                    },
                    child: Text(uid.isEmpty ? "Tambah" : "Update"),
                  ),
                ],
              ),
            ),

            const Divider(),

            // Menampilkan Data dari Firestore
            StreamBuilder<QuerySnapshot>(
              stream: CRUD.readItems(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  final data = snapshot.requireData;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      var item = data.docs[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: ListTile(
                          title: Text(item['nama']),
                          subtitle: Text('${item['email']} | ${item['hobi']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onPressed: () {
                                  setState(() {
                                    uid = item.id;
                                    namaController.text = item['nama'];
                                    emailController.text = item['email'];
                                    hobiController.text = item['hobi'];
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  CRUD.deleteAssisten(uid: item.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
