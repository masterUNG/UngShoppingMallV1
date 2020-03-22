import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ungshoppingmall/screens/home.dart';
import 'package:ungshoppingmall/widget/add_list_product.dart';
import 'package:ungshoppingmall/widget/show_list_product.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  String login = '...';
  Widget currentWidget = ShowListProduct();

  // Method
  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Widget showListProduct() {
    return ListTile(
      leading: Icon(Icons.list,size: 36.0,color: Colors.purple,),
      title: Text('List Product'),
      subtitle: Text('Show All List Product'),
      onTap: () {
        setState(() {
          currentWidget = ShowListProduct();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget showAddList() {
    return ListTile(
      leading: Icon(Icons.playlist_add, size: 36.0,color: Colors.green.shade900,),
      title: Text('Add List Product'),subtitle: Text('Add New Product to Database'),
      onTap: () {
        setState(() {
          currentWidget = AddListProduct();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Future<void> findDisplayName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      login = firebaseUser.displayName;
    });
    print('login = $login');
  }

  Widget showLogin() {
    return Text(
      'Login by $login',
      style: TextStyle(color: Colors.white),
    );
  }

  Widget showAppName() {
    return Text(
      'Ung Shopping Mall',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Mansalva',
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showHead() {
    return DrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/shop.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          showLogo(),
          showAppName(),
          SizedBox(
            height: 6.0,
          ),
          showLogin(),
        ],
      ),
    );
  }

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          showHead(),
          showListProduct(),
          showAddList(),
        ],
      ),
    );
  }

  Widget signOutButton() {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Sign Out',
      onPressed: () {
        myAlert();
      },
    );
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are You Sure ?'),
            content: Text('Do You Want Sign Out ?'),
            actions: <Widget>[
              cancelButton(),
              okButton(),
            ],
          );
        });
  }

  Widget okButton() {
    return FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
        processSignOut();
      },
    );
  }

  Future<void> processSignOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Widget cancelButton() {
    return FlatButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
        actions: <Widget>[signOutButton()],
      ),
      body: currentWidget,
      drawer: showDrawer(),
    );
  }
}
