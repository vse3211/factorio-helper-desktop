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
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Container(
                    width: 200,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Поиск модов',
                      ),
                    ),
                  ),
                ),
                Text('Доступные моды:'),
                Expanded(
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 5,
                    children: <Widget>[
                      SizedBox(
                        width: 500,
                        height: 500,
                        child: GridTile(
                          header: Container(
                            height: 40,
                            child: Center(
                              child: Text('Krastorio 2'),
                            ),
                            color: Colors.black38,
                          ),
                          child: Image.network(
                            'https://assets-mod.factorio.com/assets/0bbd7809fe9151ac3f7cd1c3c604e13d4c8598d9.thumb.png',
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: progress.expectedTotalBytes != null
                                      ? progress.cumulativeBytesLoaded /
                                      progress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                          footer: Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: const Text('Установить'),
                                  onPressed: () {
                                  },
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  child: const Text('Удалить'),
                                  onPressed: () {
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
