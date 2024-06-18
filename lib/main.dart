import 'package:flutter/material.dart';

import 'js_interop.dart';
import 'tabinfo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentView = 0;
  bool isLoading = false;
  TabInfoModel? tabInfo;
  List<TabInfoModel>? tabsData;

  @override
  void initState() {
    currentView = 0;
    super.initState();
  }

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    final resp = await JsInterop.getTabInfo();
    isLoading = false;
    tabInfo = resp;

    setState(() {});
  }

  Future<void> getAllData() async {
    setState(() {
      isLoading = true;
    });

    final resp = await JsInterop.getAllTabInfo();
    isLoading = false;
    tabsData = resp;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => setState(() => currentView = 0),
                    child: const Text("Active Tab")),
                ElevatedButton(
                  onPressed: () => setState(() => currentView = 1),
                  child: const Text("All Tabs"),
                ),
              ],
            ),
            Expanded(
              child: currentView == 0
                  ? Container(
                      padding: const EdgeInsets.all(10),
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: tabInfo == null
                                          ? const Text("No tab informaiton.")
                                          : ListTile(
                                              title: Text(tabInfo!.title),
                                              subtitle: Text(tabInfo!.url),
                                            ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: getData,
                                        child: const Text("Get Tab"),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(10),
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: tabsData == null
                                          ? const Text("No tab informaiton.")
                                          : ListView(
                                              children: tabsData!
                                                  .map((e) => ListTile(
                                                        title: Text(e.title),
                                                        subtitle: Text(e.url),
                                                      ))
                                                  .toList(),
                                            ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: getAllData,
                                        child: const Text("Get All Tabs"),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
