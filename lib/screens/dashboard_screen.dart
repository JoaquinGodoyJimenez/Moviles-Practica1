import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:pmsna1/provider/theme_provider.dart';
import 'package:pmsna1/settings/styles_settings.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    themeProvider theme = Provider.of<themeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Tec'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'data:image/jpeg;base64,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')),
                accountName: Text('Rubensin Torres Frias'),
                accountEmail: Text('ruben.torres@itcelaya.edu.mx')),
            const ListTile(
                title: Text('Práctica 1'),
                subtitle: Text('Descripción de la práctica'),
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.chevron_right)),
            DayNightSwitcher(
              isDarkModeEnabled: isDarkModeEnabled,
              onStateChanged: (isDarkModeEnabled) {
                isDarkModeEnabled
                    ? theme.setthemeData(StyleSettings.darkTheme(context))
                    : theme.setthemeData(StyleSettings.lightTheme(context));
                this.isDarkModeEnabled = isDarkModeEnabled;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}