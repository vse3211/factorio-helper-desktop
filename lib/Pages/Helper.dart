import 'package:flutter/material.dart';
import 'dart:async';
import '../libs/ContextHelperTools.dart';
import '../main.dart';

class HelperApp extends StatelessWidget {
  const HelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: FHD(),
    );
  }
}

class FHD extends StatefulWidget {
  const FHD({super.key});

  @override
  State<FHD> createState() => _FHDState();
}

class _FHDState extends State<FHD> {
  Color _seedColor = const Color(0xFFffa900);
  ThemeData? _currentTheme;
  void _changeTheme() {
    setState(() {
      _seedColor = Colors.red;

      _currentTheme = Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
        ),
      );
    });
  }

  final Size developerSize = Size(1280, 800);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColor = theme.colorScheme.primary;
    final Color secondaryColor = theme.colorScheme.secondary;
    final Size windowSize = MediaQuery.of(context).size;


    final ContextHelperTools cHT = ContextHelperTools(context, developerSize);

    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          automaticallyImplyLeading: false,
          title: const Text(
            'Factorio Helper Desktop',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [],
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: Container(
                                        width: 200,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText:
                                            'Поиск модов',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                        'Доступные моды:'
                                    ),
                                    Expanded(
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        children: [
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
