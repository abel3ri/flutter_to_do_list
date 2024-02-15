import 'package:firebase_local/utils/constants.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    Future<void> _launchTelegramUrl() async {
      await launchUrl(
        Uri.parse(telegramUserName),
        mode: LaunchMode.externalApplication,
      );
    }

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: MediaQuery.of(context).size.height * 0.1,
          bottom: MediaQuery.of(context).size.height * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Menu",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                ),
                const Divider(color: Colors.white, thickness: 0.3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Current theme",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      isDarkMode
                          ? Brightness.dark.name.capitalize
                          : Brightness.light.name.capitalize,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            // color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: _launchTelegramUrl,
                  icon:
                      const Icon(Icons.telegram, color: Colors.blue, size: 36),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  "V 1.0.0",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
