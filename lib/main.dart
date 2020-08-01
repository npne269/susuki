import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SUSUKI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Colors.red,
          accentColor: Colors.redAccent),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> myIcons = [
    {
      'label': 'Notices',
      'icon': Icons.notifications,
    },
    {
      'label': 'visa',
      'icon': FontAwesomeIcons.ccVisa,
    },
    {
      'label': 'Classes',
      'icon': FontAwesomeIcons.graduationCap,
    },
    {'label': 'Appointment', 'icon': FontAwesomeIcons.calendar},
    {
      'label': 'Messages',
      'icon': FontAwesomeIcons.solidComment,
    },
    {
      'label': 'Gallery',
      'icon': Icons.photo_library,
    },
    {
      'label': 'Upload File',
      'icon': Icons.file_upload,
    },
    {
      'label': 'Courses',
      'icon': FontAwesomeIcons.book,
    },
  ];
  List<Widget> getIconList(context) => List.generate(
        myIcons.length,
        (i) => Column(
          children: <Widget>[
            RawMaterialButton(
              elevation: 8,
              fillColor: Theme.of(context).primaryColor,
              constraints: BoxConstraints(
                minHeight: 56.0,
                minWidth: 56.0,
              ),
              shape: CircleBorder(),
              onPressed: () {
                print('nothing');
              },
              child: Icon(
                myIcons[i]['icon'],
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              myIcons[i]['label'],
              style: TextStyle(color: Colors.black45),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.call),
              onPressed: () {
                print('The Number you are dialing is busy.');
              }),
          IconButton(
              icon: Icon(
                FontAwesomeIcons.solidComment,
              ),
              onPressed: () {
                print('We cant talk any more. Sorry');
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          //image courosel
          Expanded(child: ImageCorousel()),

          //listtile
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ListTile(
              leading: CircleAvatar(
                radius: 45,
                backgroundColor: Theme.of(context).primaryColor,
              ),
              title: Text(
                'Susuki Consultancy',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.mapMarkedAlt,
                      color: Colors.yellow.shade800,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('1234,Highway xeu, Chitwan, Nepal 1234,Highway xeu, Chitwan, Nepal'),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'See on Maps',
                                  style: TextStyle(color: Colors.pink.shade600),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(FontAwesomeIcons.arrowRight,
                                size: 15,
                                    color: Colors.pink.shade600),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          //last row
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            child: Wrap(
                spacing: 20, runSpacing: 20, children: getIconList(context)),
          )),
        ],
      ),
    );
  }
}

class ImageCorousel extends StatefulWidget {
  @override
  _ImageCorouselState createState() => _ImageCorouselState();
}

class _ImageCorouselState extends State<ImageCorousel> {
  final _controller = PageController();
  int currentIndex = 0;

  List myImage = [
    0xff0000ff,
    0xff00ff00,
    0xffff0000,
    0xff00ffff,
    0xffff00ff,
    0xffffff00,
  ];

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 3), (t) {
      (currentIndex >= myImage.length) ? currentIndex = 0 : currentIndex++;
      _controller.animateToPage(currentIndex,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onChanged(i) {
    setState(() {
      currentIndex = i;
    });
  }

  int getColor(i) => myImage[i];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.builder(
          controller: _controller,
          onPageChanged: onChanged,
          itemCount: myImage.length,
          itemBuilder: (_, i) => Container(
            color: Color(getColor(i)),
            child: Center(
              child: Text('Page: ${i + 1}'),
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  myImage.length,
                  (i) => Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        width: (i == currentIndex) ? 10 : 8,
                        height: (i == currentIndex) ? 10 : 8,
                        decoration: BoxDecoration(
                          color: (i == currentIndex)
                              ? Colors.white
                              : Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                      )),
            )),
      ],
    );
  }
}
