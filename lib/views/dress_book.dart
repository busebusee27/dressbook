import 'package:dressbook/constants.dart';
import 'package:dressbook/models/dress_card.dart';
import 'package:dressbook/services/database_service.dart';
import 'package:flutter/material.dart';

class DressBookScreen extends StatelessWidget {
  final DatabaseService _databaseService = DatabaseService();

  DressBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DressBook'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
        child: Column(
      children: [_messageListView()],
    ));
  }

  Widget _messageListView() {
    return SizedBox(
      height: SCREEN_HEIGHT * 0.8,
      width: SCREEN_WIDTH,
      child: StreamBuilder(
          stream: _databaseService.getDressBook(),
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
                  return ListTile(
                    title: Text(dressCard.name),
                    subtitle: Text('Updated: ${DateFormat('dd-MM-YYYY h:mm a')
                        .format(dressCard.dateModified.toDate())}'),
                    trailing: const Icon(Icons.more_vert_outlined),
                  );
                });
          }),
    );
  }
}
