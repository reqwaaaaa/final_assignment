import 'package:dod1/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../state/auth_state.dart';
import 'random_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<String> _imageList = [
    'images/example1.jpg',
    'images/example2.jpg',
    'images/example3.jpg',
    // Add more image URLs as needed
  ];

  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<AuthState>(context);

    List<Widget> _pages = [
      Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
                Container(
                  padding: EdgeInsets.zero,
                  height: MediaQuery.of(context).size.height * 0.4, // 设置一个固定的高度
                child: Swiper(
                  itemCount: _imageList.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      _imageList[index],
                      fit: BoxFit.cover,
                    );
                  },
                  autoplay: true,
                  onIndexChanged: (index) {},
                  onTap: (index) {},
                  duration: 1000,
                  autoplayDelay: 2000,
                  autoplayDisableOnInteraction: false,
                  loop: true,
                  scrollDirection: Axis.horizontal,
                  index: 0,
                  scale: 0.6,
                  viewportFraction: 0.8,
                  indicatorLayout: PageIndicatorLayout.COLOR,
                  pagination: new SwiperPagination(),
                  control: new SwiperControl(),
                ),
                ),
              SizedBox(height: 50), 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // 第一个按钮
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RandomChoiceScreen()),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.healing,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '治好你的选择困难症',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 25, 125, 255),
                        backgroundColor: Color.fromARGB(255, 183, 220, 255),
                        minimumSize: Size(double.infinity, 60), // 设置按钮的最小尺寸
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // 第二个按钮
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/truth_or_dare');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.gamepad,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '真心话大冒险',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 25, 125, 255),
                        backgroundColor: Color.fromARGB(255, 183, 220, 255),
                        minimumSize: Size(double.infinity, 60), // 设置按钮的最小尺寸
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    if (authState.isAdmin) ...[
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/admin');
                        },
                        child: Text('管理员面板'),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 183, 220, 255),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Text(
          "FortuneFling",
          style: TextStyle(
            fontFamily: "Font4",
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 226, 240, 254),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: GNav(
          rippleColor: Color.fromARGB(255, 176, 207, 255),
          hoverColor: Color.fromARGB(255, 255, 255, 255),
          haptic: true,
          tabBorderRadius: 15,
          tabActiveBorder: Border.all(
              color: const Color.fromARGB(255, 255, 255, 255), width: 1),
          tabBorder: Border.all(
              color: const Color.fromARGB(0, 255, 255, 255), width: 0),
          tabShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 183, 221, 255).withOpacity(0.5),
                blurRadius: 8)
          ],
          curve: Curves.easeOutExpo,
          duration: Duration(milliseconds: 200),
          gap: 8,
          color: Color.fromARGB(255, 63, 114, 208),
          activeColor: Colors.white,
          iconSize: 24,
          tabBackgroundGradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 150, 200, 255),
              Color.fromARGB(255, 206, 229, 255)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
              backgroundGradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 150, 200, 255),
                  Color.fromARGB(255, 206, 229, 255)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Profile',
              backgroundGradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 150, 200, 255),
                  Color.fromARGB(255, 206, 229, 255)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
