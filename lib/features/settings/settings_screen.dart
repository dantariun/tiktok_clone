import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: const Locale("es"),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: ListView(
          children: [
            SwitchListTile.adaptive(
              value: context.watch<PlaybackConfigViewModel>().muted,
              onChanged: (value) =>
                  context.read<PlaybackConfigViewModel>().setMuted(value),
              title: const Text("Mute Video"),
              subtitle: const Text("Videos will be muted by default"),
            ),
            SwitchListTile.adaptive(
              value: context.watch<PlaybackConfigViewModel>().autoplay,
              onChanged: (value) =>
                  context.read<PlaybackConfigViewModel>().setAutoplay(value),
              title: const Text("Autoplay"),
              subtitle: const Text("Videos will start playing automatically"),
            ),
            // Checkbox(
            //   value: _notifications,
            //   onChanged: _onNotificationsChanged,
            // ),
            // Switch.adaptive(
            //   value: _notifications,
            //   onChanged: _onNotificationsChanged,
            // ),
            SwitchListTile.adaptive(
              value: _notifications,
              onChanged: _onNotificationsChanged,
              title: const Text("Enable notifications"),
            ),

            // CheckboxListTile.adaptive(
            //   value: _notifications,
            //   onChanged: _onNotificationsChanged,
            //   title: const Text("Enable notifications"),
            // ),
            ListTile(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now(),
                  );
                  if (kDebugMode) {
                    print(date);
                  }
                  if (mounted) return;
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (kDebugMode) {
                    print(time);
                  }
                  if (mounted) return;
                  final booking = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2030),
                  );
                  if (kDebugMode) {
                    print(booking);
                  }
                },
                title: const Text(
                  "What is your birthday",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                )),
            ListTile(
              onTap: () => showAboutDialog(context: context),
              title: const Text("About TikTok Clone"),
            ),
            ListTile(
              onTap: () {
                showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                          title: const Text("Are you sure?"),
                          content: const Text("plx dont go"),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text("no"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            CupertinoDialogAction(
                              child: const Text("yes"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ));
              },
              title: const Text(
                "Log out (ios)",
                style: TextStyle(color: Colors.red),
              ),
            ),
            ListTile(
              onTap: () {
                showCupertinoDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Are you sure?"),
                          content: const Text("plx dont go"),
                          actions: [
                            IconButton(
                              icon: const FaIcon(
                                  FontAwesomeIcons.skullCrossbones),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: const Text("yes"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ));
              },
              title: const Text(
                "Log out (android)",
                style: TextStyle(color: Colors.red),
              ),
            ),
            ListTile(
              title: const Text(
                "Log out ( ios : bottom)",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                          title: const Text("Are you sure?"),
                          actions: [
                            CupertinoActionSheetAction(
                              isDefaultAction: true,
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Not log out"),
                            ),
                            CupertinoActionSheetAction(
                              isDestructiveAction: true,
                              child: const Text("yes"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ));
              },
            )
          ],
        ),
      ),
    );
  }
}
