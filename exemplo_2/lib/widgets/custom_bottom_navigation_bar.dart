import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star_border),
          label: 'Favoritos',
        ),
      ],
      selectedItemColor: const Color.fromARGB(255, 76, 4, 88),
      unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      backgroundColor: Color.fromARGB(255, 178, 122, 192),
      type: BottomNavigationBarType.fixed,
    );
  }
}
