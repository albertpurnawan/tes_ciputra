import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tes_ciputra/Model/elixirs.dart';
import 'package:tes_ciputra/Model/parentelixirs.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Data/data.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => Page1State();
}

class Page1State extends State<Page1> {
  bool loading = true;
  List<parentelixirs> data = [];
  Timer? debouncer;
  bool showdetail = false;
  String url = 'https://wizard-world-api.herokuapp.com/wizards';
  bool dataIsEmpty = true;

  @override
  void initState() {
    super.initState();
    loading = true;

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callBack, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callBack);
  }

  void dataLoaded() {
    setState(() {
      loading = false;
    });
  }

  Future init() async => debounce(() async {
        final data = await Data.getData(context: context, url: url);
        if (data.length > 0) {
          setState(() {
            dataIsEmpty = false;
          });
        }
        if (!mounted) return;
        setState(() {
          this.data = data;
          loading = false;
        });
      });

  @override
  Widget build(BuildContext context) {
    // User user = ModalRoute.of(context)!.settings.arguments as User;
    // setState(() {
    //   this.user = user;
    // });
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
        title: Text(
          "Page1",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: loading
          ? loadingImage()
          : Column(
              children: <Widget>[
                Text("Count Data: ${data.length}"),
                dataIsEmpty
                    ? AlertDialog(
                        title: Text("My title"),
                        content: Text("This is my message."),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {},
                          )
                        ],
                      )
                    : Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final id = data[index].id;
                                return buildCard(
                                  data[index].detail,
                                  data[index].id,
                                  data[index].firstName,
                                  data[index].lastName,
                                );
                              },
                            )))
              ],
            ),
    );
  }

  GestureDetector buildCard(
    List<elixirs> data,
    String id,
    String firstName,
    String lastName,
  ) {
    return GestureDetector(
        onTap: () {
          setState(() => showdetail = !showdetail);
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(158, 158, 158, 1),
                  offset: Offset(0.0, 3.0))
            ]),
            child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("id: " + id),
                      Text("firstName: " + firstName),
                      Text("lastName: " + lastName),
                      showdetail
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: data.map((e) {
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("id: ${e.id}"),
                                        Text("name: ${e.name}")
                                      ],
                                    ),
                                  ),
                                );
                              }).toList())
                          : SizedBox()
                    ]))));
  }

  Widget loadingImage() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset("assets/lottie/loading.json"),
          ),
        ],
      ),
    );
  }
}
