import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stroll/src/constants/assets.dart';
import 'package:stroll/src/view/screens/chat_screen.dart';
import 'package:stroll/src/view/screens/flame_screen.dart';

class HomeWidget extends StatefulWidget {
  final int? index;

  const HomeWidget({super.key, this.index});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<Widget> screens = const [
    SizedBox(),
    FlameScreen(),
    ChatScreen(),
    SizedBox(),
  ];
  int? selectedIndex;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        selectedIndex = widget.index;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex ?? 0],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex ?? 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              selectedIndex == 0 ? iconCard : iconCard,
              height: 30,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              selectedIndex == 1 ? iconFireActive : iconFire,
              height: 30,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              selectedIndex == 2 ? iconChatActive : iconChat,
              height: 30,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              selectedIndex == 3 ? iconPerson : iconPerson,
              height: 30,
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
