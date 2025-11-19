import 'package:flutter/material.dart';
import 'package:find_job/core/di/app_module.dart';
import 'package:find_job/core/nav/app_routes.dart';
import 'package:find_job/main/navigation/store/navigation_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final navStore = sl<NavigationStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Scaffold(
          body: widget.child,
          bottomNavigationBar: navStore.showBottomNav
              ? BottomNavigationBar(
                  currentIndex: navStore.selectedIndex,
                  backgroundColor: Colors.grey[100],
                  selectedItemColor: Colors.indigo.shade600,
                  unselectedItemColor: Colors.grey.shade600,
                  selectedLabelStyle: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  onTap: (index) {
                    navStore.setIndex(index);
                    switch (index) {
                      case 0:
                        context.go(AppRoutes.main.home);
                        break;
                      case 1:
                        context.go(AppRoutes.main.myJobs);
                        break;
                      case 2:
                        context.go(AppRoutes.main.profile);
                        break;
                    }
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.work),
                      label: 'My Jobs',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                )
              : null,
        );
      },
    );
  }
}
