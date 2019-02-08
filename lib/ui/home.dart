import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_walkthrough/modal/quake.dart';
import 'package:flutter_walkthrough/modal/hacker_news.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;


// Metadatas about this app:
const APP_VERSION = 'v0.0.1';
const APP_NAME = 'Walkthrough';
const APP_DESCRIPTION = 'A Walkthrough for Building Basic Applications\n\nDeveloped by Ahmed.';
const GITHUB_URL = ''; //TO DO

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final userAccountsDrawerHeader = UserAccountsDrawerHeader(
                                      accountName: Text('Ahmed Iqbal' , style: TextStyle(fontSize: 20)), 
                                      accountEmail: Text('trevor.iqbal@gmail.com'),
                                      currentAccountPicture: CircleAvatar(
                                                      child: Image.asset('assets/images/icon/avatar-icon.png'))                                                    
                                      );
   
    final drawerItems = ListView(children: <Widget>[
      userAccountsDrawerHeader,
      ListTile(
        title: Text(APP_DESCRIPTION),
      ),
      Divider(color: Colors.purple),
      ListTile(
        leading: Icon(Icons.code, color: Colors.purple),
        title: Text('Source code on GitHub'),
        onTap: ()=> url_launcher.launch(GITHUB_URL),
        ),
      ListTile(
        leading: Icon(Icons.bookmark, color: Colors.purple),
        title: Text('About Flutter Walkthrough'),
        onTap: ()=> _aboutDialog(context),
      )
    ],);
    return Scaffold(
      drawer: Drawer(elevation: 1.0, 
                     child: drawerItems
                     ), 
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        toolbarOpacity: 1.0,
      ),
      
      body: ListView(
        padding: EdgeInsets.all(8.0),
          children: <Widget>[
            Card(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 180.0,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/quake-image.png',
                             fit: BoxFit.cover),
                        ),
                        Positioned(
                          bottom: 16.0,
                          left: 16.0,
                          right: 16.0,
                          child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Earthquake Catalog',
                            style: Theme.of(context)
                                .textTheme
                                .headline
                                .copyWith(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                      ButtonTheme.bar(
                        child: ButtonBar(
                          alignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(
                              child: Text('EXPLORE'),
                              onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) { return Quake();}));}
                            ),
                          ],
                        ),
                      ),
                ]
              ),
            ),
            Card(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 180.0,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/newspaper-image.jpg',
                             fit: BoxFit.cover),
                        ),
                        Positioned(
                          bottom: 16.0,
                          left: 16.0,
                          right: 16.0,
                          child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Hacker News',
                            style: Theme.of(context)
                                .textTheme
                                .headline
                                .copyWith(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                      ButtonTheme.bar(
                        child: ButtonBar(
                          alignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(
                              child: Text('READ NEWS'),
                              onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) { return HackerNews();}));}
                            ),
                          ],
                        ),
                      ),
                ]
              ),
            )
          ],
    ));
  }
}

void _aboutDialog(BuildContext context) {
  final ThemeData themeData = Theme.of(context);
  final TextStyle aboutTextStyle = themeData.textTheme.body2;
  final TextStyle gitRepo = TextStyle(color: Colors.purple);
  const String message = 'Flutter is an early-stage, open-source project to help developers build high-performance, high-fidelity, mobile' +
                         'apps for IOS and Andriod from a single codebase. This Walkthrough is for understanding widgets placement and serialization in flutter'+
                         '\nTo see the source code for this app, please visit ';

  showAboutDialog(
      context: context,
      applicationVersion: 'February 2019',
      applicationLegalese: '© 2019 Trevor Iqbal', applicationIcon: Image.asset('assets/images/icon/custom-icon.png', width: 75, height: 75,),
      children: <Widget>[
        Padding(padding: const EdgeInsets.only(top: 24.0),
        child: RichText(
          text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  style: aboutTextStyle,
                  text: message,
                ),
                TextSpan(
                  text: ' git repo',
                  style: gitRepo,
                  recognizer: TapGestureRecognizer()..onTap = () {
                    url_launcher.launch('', forceSafariVC: false);
                  }
                )
              ]
          ),
        ),)
      ]
  );
}