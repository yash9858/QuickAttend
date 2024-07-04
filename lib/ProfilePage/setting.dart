import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:QuickAttend/Themes/theme_controller.dart';

class SettingsPage extends StatelessWidget {
  final ThemeController themeController = Get.find<ThemeController>();

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var mh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mh * 0.02, vertical: mh * 0.01),
          child: Column(
          children: [
            Obx((){
              return InkWell(
                  borderRadius: BorderRadius.circular(mh * 0.02),
                  onTap: (){},
                    child: Card(
                      child: SwitchListTile(
                        title: const Text(
                          'Dark Mode',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        value: themeController.isDark.value,
                        onChanged: (value) {
                          themeController.changeTheme();
                          },
                        ),
                      )
                  );
                },),
            SizedBox(height: mh * 0.02,),
            InkWell(
              borderRadius: BorderRadius.circular(mh * 0.02),
              onTap: (){},
              child: const Card(
                child: ListTile(
                  title: Text(
                    'Notification Setting',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: mh * 0.02,),
            InkWell(
              borderRadius: BorderRadius.circular(mh * 0.02),
              onTap: (){},
              child: const Card(
                child: ListTile(
                  title: Text(
                    'Language Setting',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: mh * 0.02,),
            InkWell(
              borderRadius: BorderRadius.circular(mh * 0.02),
              onTap: (){},
              child: const Card(
                child: ListTile(
                  title: Text(
                    'Change Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ));
  }
}
