import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';

import 'category_page.dart';
import 'home_page.dart';
import 'notification_page.dart';
import 'profile_page.dart';

final _currentIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

LinearGradient getGradient(Color color) => LinearGradient(
      colors: [
        color.withOpacity(0.5),
        color.withOpacity(0.1),
      ],
      stops: const [0.0, 0.7],
    );

class NavigationPage extends ConsumerStatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  ConsumerState<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends ConsumerState<NavigationPage> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (ref.read(_currentIndexProvider) == 0) {
      return true;
    } else {
      _onTap(0);
      return false;
    }
  }

  void _onTap(int index) {
    ref.read(_currentIndexProvider.notifier).update((state) => index);
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(_currentIndexProvider);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            const HomePage(),
            CategoryPage(leadingActionButton: () => _onTap(0)),
            NotificationPage(leadingActionButton: () => _onTap(0)),
            ProfilePage(leadingActionButton: () => _onTap(0)),
          ],
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(10.0),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 8.5,
                offset: const Offset(0.0, 1.0),
              ),
            ],
          ),
          child: CubertoBottomBar(
            padding: const EdgeInsets.symmetric(vertical: 8),
            key: const Key("BottomBar"),
            tabColor: Colors.red,
            inactiveIconColor: Colors.blueGrey.shade400,
            tabStyle: CubertoTabStyle.styleFadedBackground,
            selectedTab: currentIndex,
            tabs: <TabData>[
              TabData(
                iconData: Icons.home,
                title: 'Home',
                tabColor: Theme.of(context).primaryColor,
              ),
              TabData(
                iconData: Icons.grid_view_rounded,
                title: 'Categories',
                tabColor: Theme.of(context).primaryColor,
              ),
              TabData(
                iconData: Icons.notifications,
                title: 'Notifications',
                tabColor: Theme.of(context).primaryColor,
              ),
              TabData(
                iconData: Icons.person,
                title: 'Profile',
                tabColor: Theme.of(context).primaryColor,
              ),
            ],
            onTabChangedListener: (int index, _, __) => _onTap(index),
          ),
        ),
      ),
    );
  }
}
