import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:social_media_app/social_media.dart';

class WelcomeScreen extends StatefulWidget {
  static const _buttonPadding = 42.0;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  ProgressDialog progressDialog;

  void handleButtons(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushNamed(Routes.signup);
    } else if (index == 1) {
      Navigator.of(context).pushNamed(Routes.signin);
    } else {
      handleGoogleLogin(context);
    }
  }

  Future<void> handleGoogleLogin(BuildContext context) async {
    await FirebaseAuthService(
      onStart: () {
        progressDialog.show();
      },
      onFinish: (user) {
        progressDialog.hide();
        Navigator.of(context).pushReplacementNamed(Routes.dashboard);
      },
      onError: (code, message) {
        progressDialog.hide();
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
      },
    ).googleOAuth();
  }

  final image = Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 24.0,
    ),
    child: Image.asset(
      Assets.welcomePageImage,
      fit: BoxFit.fitWidth,
    ),
  );

  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(
      context,
      isDismissible: false,
      type: ProgressDialogType.Normal,
      customBody: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        child: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16.0),
            Text('Initialised Signing Process...'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              image,
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Hey, How U Doin?',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Text(
                'To Continue',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              WelcomePageButton(
                buttonText: 'Sign Up',
                onPressed: () {
                  handleButtons(context, 0);
                },
              ),
              WelcomePageButton(
                buttonText: 'Login',
                onPressed: () {
                  handleButtons(context, 1);
                },
                fillWithDark: false,
              ),
              Divider(
                indent: WelcomeScreen._buttonPadding + 30.0,
                endIndent: WelcomeScreen._buttonPadding + 30.0,
                height: 30.0,
              ),
              Builder(
                builder: (context) {
                  return WelcomePageButton(
                    buttonText: 'Continue with Google',
                    onPressed: () {
                      handleButtons(context, 2);
                    },
                  );
                }
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Read our '),
                    InteractiveText(
                      text: 'Terms and Conditions',
                      onTap: () {
                        //TODO: SHOW TERMS AND CONDITIONS
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
