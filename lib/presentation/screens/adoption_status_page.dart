import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pet_pal/application/adoption_applications/adoption_applications_notifier.dart';
import 'package:flutter_pet_pal/domain/adoption_applications/adoption_applications.dart';

class ApplicationStatusScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationsState = ref.watch(adoptionNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        elevation: 0,
        title: Text(
          'Application Status',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: applicationsState.when(
        data: (applications) {
          if (applications.isEmpty) {
            return Center(child: Text('No applications found.'));
          }
          return ListView.builder(
            itemCount: applications.length,
            itemBuilder: (context, index) {
              final application = applications[index];
              return ApplicationStatusCard(
                application: application,
                onEdit: () {
                  // Handle edit logic here
                },
                onDelete: () {
                  ref.read(adoptionNotifierProvider.notifier).deleteApplication(application.id);
                },
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Failed to load applications: $error')),
      ),
    );
  }
}

class ApplicationStatusCard extends StatelessWidget {
  final AdoptionApplication application;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ApplicationStatusCard({
    Key? key,
    required this.application,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('lib/images/dog1.jpeg'), // Replace with appropriate image
          backgroundColor: Colors.transparent,
        ),
        title: Text(
          application.fullName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.hourglass_top, color: Colors.orange, size: 20.0), // Replace with dynamic icon
            SizedBox(width: 4.0),
            Text(application.status),
          ],
        ),
        trailing: Wrap(
          spacing: 12,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit, color: Colors.orange),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.brown),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
