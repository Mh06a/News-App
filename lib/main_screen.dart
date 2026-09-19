import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //step1 -->>  Class variables :
  int _currentIndex = 0;
  final List<Widget> _screens = [
  ];

  //step2 -->> call a build function :
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _screens[_currentIndex]),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (int? index) {
          setState(() {
            _currentIndex = index ?? 0;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/icons/home_icon.svg", 0),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/icons/search_icon.svg", 1),
            label: "Search",
          ),

          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/icons/bookmark_icon.svg", 2),
            label: "Bookmark",
          ),

          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/icons/profile_icon.svg", 3),
            label: "Profile",
          ),
        ],
      ), // BottomNavigationBar
    ); // ChangeNotifierProvider
  }

  // here I will Create function to SVG Picture :
  SvgPicture _buildSvgPicture(String path, int currentIndex) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        _currentIndex == currentIndex
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        BlendMode.srcIn,
      ),
    );
  }
}
