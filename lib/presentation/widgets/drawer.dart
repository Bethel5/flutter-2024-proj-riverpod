import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.orange[100],
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(),
            accountName:
                const Text('Name', style: TextStyle(color: Colors.black)),
            accountEmail: const Text('user@example.com',
                style: TextStyle(color: Colors.black)),
            currentAccountPicture:
                const CircleAvatar(child: Icon(Icons.person)),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/user_page');
            },
            leading: const Icon(Icons.home),
            title: const Text('HOME'),
          ),
          
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/fav_page');
            },
            leading: const Icon(Icons.favorite),
            title: const Text('FAVORITES'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/adoption_form');
            },
            leading: const Icon(Icons.book_online),
            title: const Text('FORM'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/status');
            },
            leading: const Icon(Icons.label),
            title: const Text('APPLICATION STATUS'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/appointment');
            },
            leading: const Icon(Icons.event),
            title: const Text('VISIT APPOINTMENT'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/appoint_status');
            },
            leading: const Icon(Icons.calendar_month),
            title: const Text('MY APPOINTMENTS'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/login_page');
            },
            leading: const Icon(Icons.logout),
            title: const Text('LOGOUT'),
          ),
        ],
      ),
    );
  }
}
