import 'package:flutter/material.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int value, _) {
          return BottomNavigationBar(
              currentIndex: value,
              onTap: (index) {
                indexChangeNotifier.value = index;
              },
              backgroundColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              selectedIconTheme: const IconThemeData(color: Colors.white),
              unselectedIconTheme: const IconThemeData(color: Colors.grey),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.photo_library_outlined),
                    label: 'New & Hot'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.emoji_emotions_outlined),
                    label: 'Reel Flix'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.download), label: 'Downloads'),
              ]);
        });
  }
}
