import 'package:flutter/material.dart';
import 'package:grex_floating_view/grx_floating_view.dart';

import 'pages/list.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InApp PIP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter InApp PIP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final floatingViewService = GrxFloatingViewService(
    context: context,
    options: GrxFloatingViewOptions(
      position: const GrxPosition(
        alignment: Alignment.bottomRight,
        offset: Offset(0, 60),
      ),
      style: GrxFloatingViewStyle(
        border: Border.all(
          color: const Color.fromARGB(255, 65, 65, 65),
          width: 1.0,
        ),
      ),
    ),
  );

  _putOverlay() {
    floatingViewService.putOverlay(
      widget: ListPage(
        service: floatingViewService,
        items: List.generate(100, (index) => index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (floatingViewService.overlayActive) {
          floatingViewService.enableFloatingView();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: const Text("Add Video With Drag Overlay"),
                onPressed: () {
                  _putOverlay();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
