import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'generated/locale_keys.g.dart';
import 'lang_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('en'),
      Locale('th'),
    ],
    path: 'assets/lang',
    child: const MyApp(),
    fallbackLocale: const Locale('en'),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Easy localization'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  bool _gender = true;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void switchGender(bool val) {
    setState(() {
      _gender = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.title).tr(),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const LanguageView(),
                    fullscreenDialog: true),
              );
            },
            child: const Icon(
              Icons.language,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(
              flex: 1,
            ),
            Text(
              LocaleKeys.gender_with_arg,
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ).tr(args: [';)'], gender: _gender ? 'female' : 'male'),
            Text(
              tr(LocaleKeys.gender, gender: _gender ? 'female' : 'male'),
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              tr(LocaleKeys.title),
              style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const FaIcon(FontAwesomeIcons.male),
                Switch(value: _gender, onChanged: switchGender),
                const FaIcon(FontAwesomeIcons.female),
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            const Text(LocaleKeys.msg).tr(args: ['aissat', 'Flutter']),
            const Text(LocaleKeys.msg_named)
                .tr(namedArgs: {'lang': 'Dart'}, args: ['Easy localization']),
            const Text(LocaleKeys.clicked).plural(counter),
            TextButton(
              onPressed: () {
                incrementCounter();
              },
              child: const Text(LocaleKeys.clickMe).tr(),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
                plural(LocaleKeys.amount, counter,
                    format: NumberFormat.currency(
                        locale: Intl.defaultLocale, symbol: '???')),
                style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                context.resetLocale();
              },
              child: const Text(LocaleKeys.reset_locale).tr(),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        child: const Text('+1'),
      ),
    );
  }
}
