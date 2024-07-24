import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dressbook/constants.dart';
import 'package:dressbook/models/dress_card.dart';
import 'package:dressbook/services/app_state.dart';
// import 'package:dressbook/services/cloud_storage.dart';
import 'package:dressbook/services/database_service.dart';
import 'package:dressbook/services/time_difference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DressBookScreen extends StatefulWidget {
  const DressBookScreen({super.key});

  @override
  State<DressBookScreen> createState() => _DressBookScreenState();
}

class _DressBookScreenState extends State<DressBookScreen> {
  final DatabaseService _databaseService = DatabaseService();
  // final CloudStorageService _cloudStorageService = CloudStorageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DressBook'),
        actions: [_optionsButton()],
      ),
      floatingActionButton: _addDressAlert(),
      body: Builder(
        builder: (context) => _buildUI(),
      ),
    );
  }

  Widget _optionsButton() {
    return Consumer<AppState>(
      builder: (context, appState, child) => PopupMenuButton(
        icon: const Icon(Icons.more_vert_outlined),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: const ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log out'),
                enabled: false,
              ),
              onTap: () {
                Get.offAllNamed('/sign-in');
                appState.currentUser = null;
              },
            ),
          ];
        },
      ),
    );
  }

  Widget _buildUI() {
    return SafeArea(
        child: SingleChildScrollView(
          child: Column(
                children: [_messageListView()],
              ),
        ));
  }

  Widget _messageListView() {
    return SizedBox(
      height: SCREEN_HEIGHT * 0.8,
      width: SCREEN_WIDTH,
      child: Consumer<AppState>(
          builder: (context, appState, child) => StreamBuilder(
              stream: _databaseService.getDressBook(appState.currentUser!.uid),
              builder: (context, snapshot) {
                List dressBook = snapshot.data?.docs ?? [];
                if (dressBook.isEmpty) {
                  return const Center(
                    child: Text('Add dress!'),
                  );
                }
                return ListView.builder(
                    itemCount: dressBook.length,
                    itemBuilder: (context, index) {
                      DressCard dressCard = dressBook[index].data();
                      String dressCardID = dressBook[index].id;
                      return Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                color: switch (dressCard.status) {
                                  0 => Colors.green,
                                  1 => Colors.amber,
                                  2 => Colors.red,
                                  int() => throw UnimplementedError(),
                                },
                                child: const ListTile(),
                              )),
                          Expanded(
                            flex: 50,
                            child: ListTile(
                              title: Text(dressCard.name),
                              subtitle: Text(
                                  'Last Updated: ${timeDifference(dressCard.dateModified)}'),
                              trailing: const Image(
                                image: NetworkImage(
                                    'https://preview.redd.it/i-got-bored-so-i-decided-to-draw-a-random-image-on-the-v0-4ig97vv85vjb1.png?width=1280&format=png&auto=webp&s=7177756d1f393b6e093596d06e1ba539f723264b'),
                              ),
                              onTap: () {
                                int newStatus = (dressCard.status + 1) % 3;
                                DressCard newDressCard = dressCard.copyWith(
                                    dressCard.name, newStatus, Timestamp.now());
                                _databaseService.updateDressCard(
                                    appState.currentUser!.uid,
                                    dressCardID,
                                    newDressCard);
                              },
                              onLongPress: () {
                                _databaseService.deleteDressCard(
                                    appState.currentUser!.uid, dressCardID);
                              },
                            ),
                          ),
                        ],
                      );
                    });
              })),
    );
  }

  Widget _addDressAlert() {
    TextEditingController controller = TextEditingController();

    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: const Text('Add Dress'),
                  content: TextField(
                    controller: controller,
                    decoration: const InputDecoration(hintText: 'Add dress'),
                  ),
                  actions: [
                    Consumer<AppState>(
                      builder: (context, appState, child) => ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _databaseService.addDressCard(
                                appState.currentUser!.uid,
                                DressCard(
                                    name: controller.text,
                                    status: 0,
                                    dateCreated: Timestamp.now(),
                                    dateModified: Timestamp.now()));
                            controller.clear();
                          },
                          child: const Text('Add')),
                    ),
                  ],
                );
            });
      },
    );
  }
}
