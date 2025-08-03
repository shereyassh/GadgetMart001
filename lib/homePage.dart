import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'analyticsSection/manageAnalytics.dart';
import 'feedbackPage.dart';
import 'historySection/manageHistory.dart';
import 'loginPage.dart';
import 'itemSection/manageItem.dart';
import 'models/user_model.dart';
import 'userPage.dart';
//import 'dummy.dart';

//void main() => runApp(HomePage());
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formkey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();

  Widget _manageItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).cardColor, // for Material/Buttons
                child: MaterialButton(
                    //padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                    minWidth: MediaQuery.of(context).size.width * 0.60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ItemPage()));
                    },
                    child: Text(
                      "MANAGE ITEM",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inknutAntiqua(
                        textStyle: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.secondary, // blue accent
                            fontWeight: FontWeight.bold),
                      ),
                    )))
          ],
        ),
      ],
    );
  }

  Widget _saleshistory() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).cardColor, // for Material/Buttons
                child: MaterialButton(
                    //padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                    minWidth: MediaQuery.of(context).size.width * 0.60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HistoryPage()));
                    },
                    child: Text(
                      "SALES HISTORY",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inknutAntiqua(
                        textStyle: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.secondary, // blue accent
                            fontWeight: FontWeight.bold),
                      ),
                    )))
          ],
        ),
      ],
    );
  }

  Widget _analytics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).cardColor, // for Material/Buttons
                child: MaterialButton(
                    //padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                    minWidth: MediaQuery.of(context).size.width * 0.60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AnalyticsPage()));
                    },
                    child: Text(
                      "ANALYTICS",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inknutAntiqua(
                        textStyle: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.secondary, // blue accent
                            fontWeight: FontWeight.bold),
                      ),
                    )))
          ],
        ),
      ],
    );
  }

  Widget _feedback() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).cardColor, // for Material/Buttons
                child: MaterialButton(
                    //padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                    minWidth: MediaQuery.of(context).size.width * 0.60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeedbackPage()));
                    },
                    child: Text(
                      "SEND FEEDBACK",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inknutAntiqua(
                        textStyle: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.secondary, // blue accent
                            fontWeight: FontWeight.bold),
                      ),
                    )))
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.userModel = UserModel.fromMap(value.data() ?? {});
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            TextButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              icon: userModel.username == null
                  ? Container()
                  : Text(
                      "${userModel.username} ",
                      style: GoogleFonts.spaceMono(
                        textStyle: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.secondary, // yellow accent
                            decorationColor: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
              label: Icon(
                Icons.account_circle_rounded,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              ),
            ),
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/logo.png"),
                    backgroundColor: Colors.transparent,
                    radius: 140,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                _manageItem(),
                const SizedBox(
                  height: 10,
                ),
                _saleshistory(),
                const SizedBox(
                  height: 10,
                ),
                _analytics(),
                const SizedBox(
                  height: 10,
                ),
                _feedback(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          icon: const Icon(Icons.exit_to_app_outlined),
          label: Text(
            'Logout',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: () => {
            setState(() {
              FirebaseAuth.instance.signOut();
            }),
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()))
          },
        ),
      ),
    );
  }
}
