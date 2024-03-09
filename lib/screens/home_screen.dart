import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:weather_test/screens/controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.city});

  final String city;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(city: city),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFF14143A),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                child: Column(
                  children: [
                    _getSearchBox(controller),
                    _getStatusBox(controller),
                    _getListBox(),
                    _getWeeklyBox(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getBackgroundContainer(
      {required Widget child, BorderRadius radius = BorderRadius.zero}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF000038),
        borderRadius: radius,
        boxShadow: const [
          BoxShadow(
            offset: Offset(2, 3),
            blurRadius: 5,
            color: Color(0xFF000038),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _getGradientContainer(
      {required Widget child, BorderRadius radius = BorderRadius.zero}) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: radius,
            child: Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF1C1C44),
                      Color(0xFF222248),
                      Color(0xFF27274E),
                      Color(0xFF2B2B50),
                      Color(0xFF2E2E55),
                      Color(0xFF323259),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        child
      ],
    );
  }

  Widget _getSearchBox(HomeController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 22),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 60,
              child: _getBackgroundContainer(
                radius: BorderRadius.circular(50),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: _getGradientContainer(
                    child: TextField(
                      controller: controller.txtSearch,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Search Heare!',
                        hintStyle: TextStyle(
                          color: Color(0xFF60607C),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    radius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              controller.getData(controller.txtSearch.text);
            },
            child: SizedBox(
              height: 60,
              width: 60,
              child: _getBackgroundContainer(
                radius: BorderRadius.circular(50),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: _getGradientContainer(
                    child: Center(
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: SvgPicture.asset('assets/images/search.svg'),
                      ),
                    ),
                    radius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getStatusBox(HomeController controller) {
    return SizedBox(
      child: _getBackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: _getGradientContainer(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(30, 20, 50, 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DateFormat('EEE,d MMMM').format(DateTime.now())),
                        Text(controller.data == null
                            ? 'Loading ... - Loading ...'
                            : "${controller.data!.location.country!} - ${controller.data!.location.name!}"),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              controller.data == null
                                  ? '0'
                                  : controller.data!.current.tempC!
                                      .toInt()
                                      .toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 15),
                            const Text(
                              '\u2103',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(
                              CupertinoIcons.chevron_down,
                              size: 14,
                              color: Color(0xFF7B7B91),
                            ),
                            SizedBox(width: 2),
                            Text(
                              '0',
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 1),
                            Text(
                              '\u2103',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.orange,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              CupertinoIcons.chevron_up,
                              size: 14,
                              color: Color(0xFF7B7B91),
                            ),
                            SizedBox(width: 2),
                            Text(
                              '0',
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 1),
                            Text(
                              '\u2103',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Text(
                          controller.data == null
                              ? 'Loading ...'
                              : controller.data!.location.name!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              'Feelings like ${controller.data == null ? 0 : controller.data!.current.feelslikeC}',
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(width: 3),
                            const Text(
                              '\u2103',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Image.asset('assets/images/day/113.png'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getListBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, right: 22, left: 22),
      child: SizedBox(
        width: double.infinity,
        height: 170,
        child: ListView.builder(
          itemCount: 7,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('00:00 PM'),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 50,
                        child: Image.asset('assets/images/day/113.png'),
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 1),
                          Text(
                            '\u2103',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                            height: 15,
                            child: SvgPicture.asset(
                              'assets/images/rain-drop.svg',
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text('0 %'),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _getWeeklyBox() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        child: _getBackgroundContainer(
          radius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: _getGradientContainer(
              radius: BorderRadius.circular(11),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    _getWeeklyItem('Wednesday'),
                    const SizedBox(height: 5),
                    _getWeeklyItem('Thursday'),
                    const SizedBox(height: 5),
                    _getWeeklyItem('Friday'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getWeeklyItem(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset('assets/images/rain-drop.svg'),
                ),
                const Spacer(),
                const Text('0 %'),
                const Spacer(),
                SizedBox(
                  width: 25,
                  height: 25,
                  child: Image.asset('assets/images/day/113.png'),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '0',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 1),
                Text(
                  '\u2103',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
