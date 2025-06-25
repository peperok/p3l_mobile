import 'package:flutter/material.dart';
import 'package:p3lcoba/controllers/user_session.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavbar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  void _navigateToProfile(BuildContext context) {
    if (UserSession.userType == 'pembeli') {
      Navigator.pushNamed(context, '/profile');
    } else if (UserSession.userType == 'penitip') {
      Navigator.pushNamed(context, '/profilePenitip');
    } else if (UserSession.userType == 'pegawai') {
      Navigator.pushNamed(context, '/profilePegawai');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 2) {
          _navigateToProfile(context);
        } else {
          onTap(index);
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '',
        ),
      ],
      backgroundColor: Color(0xFF6B2C15), // coklat tua
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
    );
  }
}
