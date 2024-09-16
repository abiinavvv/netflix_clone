import 'package:cloned_netflix/constant/colors.dart';
import 'package:cloned_netflix/screens/download/downloads_screen.dart';
import 'package:cloned_netflix/screens/fastlaugh/fast_laugh_screen.dart';
import 'package:cloned_netflix/screens/home/home_screen.dart';
import 'package:cloned_netflix/screens/newnhot/new_&_hot_screen.dart';
import 'package:cloned_netflix/screens/search/search_screen.dart';
import 'package:cloned_netflix/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final pages = [
    const Home(),
    const NewnHot(),
    const FastLaugh(),
    const Search(),
    const Downloads(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bGColor,
      body: ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int index, _) {
          return pages[index];
        },
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
