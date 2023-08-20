import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task/network/repository/hive_repository.dart';
import 'package:test_task/screens/profile/profile_main_page.dart';
import 'package:test_task/styles/color_palette.dart';

import 'cubit/bottom_nav_bar_cubit.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key, required this.hive}) : super(key: key);
  HiveRepository hive;
  // static bool refreshMainPage = false;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBarCubit(),
      child: BlocConsumer<BottomNavBarCubit, BottomNavBarState>(
        listener: ((context, state) {}),
        builder: (context, state) {
          if (state is BottomNavBarInitial) {
            return WillPopScope(
              onWillPop: () async {
                bool isPop = true;
                isPop = await navigatorKeys[state.currentPageIndex]
                        .currentState
                        ?.maybePop() ??
                    false;
                return !isPop;
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Stack(
                  children: [
                    IndexedStack(
                      index: state.currentPageIndex,
                      children: [
                        Navigator(
                          key: navigatorKeys[0],
                          onGenerateRoute: (route) => CupertinoPageRoute(
                              settings: route,
                              builder: (context) => Container(
                                    color: ColorPalette.main,
                                  )),
                        ),
                        Navigator(
                          key: navigatorKeys[1],
                          onGenerateRoute: (route) => CupertinoPageRoute(
                              settings: route,
                              builder: (context) => Container(
                                    color: ColorPalette.red,
                                  )),
                        ),
                        Navigator(
                          key: navigatorKeys[2],
                          onGenerateRoute: (route) => CupertinoPageRoute(
                              settings: route,
                              builder: (context) => Container(
                                    color: ColorPalette.gray,
                                  )),
                        ),
                        Navigator(
                          key: navigatorKeys[3],
                          onGenerateRoute: (route) => CupertinoPageRoute(
                            settings: route,
                            builder: (context) => ProfileMain(
                              hiveRepository: widget.hive,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        child: _NavigationBar(
                          activePageIndex: state.currentPageIndex,
                          onTap: (pageIndex) async {
                            context
                                .read<BottomNavBarCubit>()
                                .changeCurrentPage(pageIndex);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _NavigationBar extends StatelessWidget {
  final int activePageIndex;
  final Function(int) onTap;

  const _NavigationBar({
    Key? key,
    required this.activePageIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CustomBottomNavBar(
      items: [
        _CustomBottomNavBarItem(
          label: "Лента",
          icon: 'assets/icons/1st_page.svg',
          activeIndex: activePageIndex,
          onTap: onTap,
          index: 0,
        ),
        _CustomBottomNavBarItem(
          label: "Карта",
          icon: 'assets/icons/2nd_page.svg',
          activeIndex: activePageIndex,
          onTap: onTap,
          index: 1,
        ),
        _CustomBottomNavBarItem(
          label: "Избранные",
          icon: 'assets/icons/3rd_page.svg',
          activeIndex: activePageIndex,
          onTap: onTap,
          index: 2,
        ),
        _CustomBottomNavBarItem(
          label: "Профиль",
          icon: 'assets/icons/profile_page_icon.svg',
          activeIndex: activePageIndex,
          onTap: onTap,
          index: 3,
        ),
      ],
    );
  }
}

class _CustomBottomNavBarItem extends StatefulWidget {
  final String label;
  final String icon;
  final int activeIndex;
  final int index;
  final Function(int index) onTap;

  const _CustomBottomNavBarItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.activeIndex,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  @override
  State<_CustomBottomNavBarItem> createState() =>
      _CustomBottomNavBarItemState();
}

class _CustomBottomNavBarItemState extends State<_CustomBottomNavBarItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap.call(widget.index),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          SizedBox(
            width: 32.w,
            height: 32.h,
            child: Center(
              child: SvgPicture.asset(
                widget.icon,
                color: widget.activeIndex == widget.index
                    ? ColorPalette.main
                    : ColorPalette.black,
                fit: BoxFit.contain,
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 12,
              color: widget.activeIndex == widget.index
                  ? ColorPalette.main
                  : ColorPalette.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  final List<Widget> items;

  const _CustomBottomNavBar({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: ColorPalette.white, width: 2),
                  ),
                  color: Colors.white,
                ),
                height: 76,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...items,
                  ],
                ),
              ),
              Container(
                height: 10,
                color: ColorPalette.white,
              )
            ],
          ),
        ],
      ),
    );
  }
}
