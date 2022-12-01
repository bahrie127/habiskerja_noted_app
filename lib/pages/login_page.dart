import 'package:flutter/material.dart';
import 'package:flutter_notes_app/pages/home_screen.dart';
import 'package:flutter_notes_app/utils/show_alert_dialog.dart';
import 'package:flutter_notes_app/utils/user_shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPage> {
  late TextEditingController nameController;
  late TextEditingController pinController;
  bool isPinExist = false;
  String? _pin;

  @override
  void initState() {
    nameController = TextEditingController();
    pinController = TextEditingController();
    String? pin = UserSharedPreferences.getPin();
    if (pin != null) {
      setState(() {
        isPinExist = true;
        _pin = pin;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.brown.shade50,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Buku Catatan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              if (isPinExist == false)
                const Text(
                  'Nama',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              if (isPinExist == false)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 60,
                  ),
                  child: TextField(
                    controller: nameController,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.all(0),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              const Text(
                'PIN',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 100,
                ),
                child: TextField(
                  controller: pinController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.all(0),
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (isPinExist) {
                    if (pinController.text.isNotEmpty) {
                      if (_pin! == pinController.text) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const HomePage();
                            },
                          ),
                        );
                      } else {
                        return showAlertDialog(
                          context: context,
                          title: 'Error',
                          content: 'Pin salah',
                        );
                      }
                    } else {
                      return showAlertDialog(
                        context: context,
                        title: 'Error',
                        content: 'Pin wajib diisi',
                      );
                    }
                  } else if (nameController.text.isNotEmpty &&
                      pinController.text.isNotEmpty) {
                    await UserSharedPreferences.setName(
                      name: nameController.text,
                      pin: pinController.text,
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const HomePage();
                        },
                      ),
                    );
                  } else {
                    return showAlertDialog(
                      context: context,
                      title: 'Error',
                      content: 'Nama dan pin wajib diisi',
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    )),
                child: const Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 20,
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
