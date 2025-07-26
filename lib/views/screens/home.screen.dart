import 'package:app/views/screens/bookmark.screen.dart';
import 'package:app/views/widgets/homeContent.widget.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/radix_icons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('Index 0: 카테고리')),
    HomeContentWidget(),
    BookmarkScreen(bookmarks: []), // Placeholder for bookmarks
    Center(child: Text('Index 2: Profile')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.125,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "yozm",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image(
                  image: AssetImage('assets/images/y_character.png'),
                  width: size.width * 0.08,
                ),
                Image(
                  image: AssetImage('assets/images/z_character.png'),
                  width: size.width * 0.07,
                ),
              ],
            ),
            Iconify(Ph.bell_simple_bold, size: size.width * 0.07), // widget
          ],
        ),
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Iconify(
              _selectedIndex == 0
                  ? RadixIcons.hamburger_menu
                  : RadixIcons.hamburger_menu,
              color: _selectedIndex == 0
                  ? Color.fromRGBO(86, 167, 244, 1)
                  : Color.fromRGBO(117, 117, 117, 1),
              size: 28,
            ), // Placeholder for filled icon
            label: '카테고리',
          ),
          BottomNavigationBarItem(
            icon: Iconify(
              _selectedIndex == 1
                  ? MaterialSymbols.home_rounded
                  : MaterialSymbols.home_outline_rounded,
              color: _selectedIndex == 1
                  ? Color.fromRGBO(86, 167, 244, 1)
                  : Color.fromRGBO(117, 117, 117, 1),
              size: 28,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Iconify(
              _selectedIndex == 2 ? Mdi.cards_heart : Mdi.cards_heart_outline,
              color: _selectedIndex == 2
                  ? Color.fromRGBO(86, 167, 244, 1)
                  : Color.fromRGBO(117, 117, 117, 1),
              size: 28,
            ),
            label: '찜',
          ),
          BottomNavigationBarItem(
            icon: Iconify(
              _selectedIndex == 3 ? Ic.round_person_2 : Ic.outline_person_2,
              color: _selectedIndex == 3
                  ? Color.fromRGBO(86, 167, 244, 1)
                  : Color.fromRGBO(117, 117, 117, 1),
              size: 28,
            ),
            label: '마이페이지',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(86, 167, 244, 1),
        selectedIconTheme: IconThemeData(
          color: Color.fromRGBO(86, 167, 244, 1),
        ),
        onTap: _onItemTapped,
        unselectedItemColor: Color.fromRGBO(117, 117, 117, 1),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedLabelStyle: TextStyle(
          color: Color.fromRGBO(117, 117, 117, 1),
        ),
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
    );
  }
}
