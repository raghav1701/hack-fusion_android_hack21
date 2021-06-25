import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:social_media_app/social_media.dart';

enum _ButtonType {
  SIGNUP,
  LOGIN,
  GOOGLE,
  TnC,
}

class WelcomeScreen extends StatefulWidget {
  static const _buttonPadding = 42.0;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  ProgressDialog progressDialog;

  void handleButtons(BuildContext context, _ButtonType btn) {
    if (btn == _ButtonType.SIGNUP) {
      Navigator.of(context).pushNamed(Routes.signup);
    } else if (btn == _ButtonType.LOGIN) {
      Navigator.of(context).pushNamed(Routes.signin);
    } else if (btn == _ButtonType.GOOGLE) {
      handleGoogleLogin(context);
    } else if (btn == _ButtonType.TnC) {
      Navigator.of(context).pushNamed(Routes.terms);
    }
  }

  Future<void> handleGoogleLogin(BuildContext context) async {
    await FirebaseAuthService(
      onStart: () {
        progressDialog.show();
      },
      onFinish: (user) {
        progressDialog.hide();
        if (user != null) {
          Navigator.of(context).pushReplacementNamed(Routes.dashboard);
        }
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
      horizontal: 32.0,
      vertical: 24.0,
    ),
    child: Image.asset(
      Assets.welcomePageImage,
      fit: BoxFit.fitWidth,
    ),
  );

  final divider = Divider(
    indent: WelcomeScreen._buttonPadding + 32.0,
    endIndent: WelcomeScreen._buttonPadding + 32.0,
    height: 30.0,
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
                height: 8.0,
              ),
              Text(
                'Apna\nParyawaran',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff0fb63e),
                  fontSize: 30,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Text(
                'Join hands to save the\nEnvironment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16.0,
              ),
              AuthButton(
                buttonText: 'Sign Up',
                onPressed: () {
                  handleButtons(context, _ButtonType.SIGNUP);
                },
              ),
              AuthButton(
                buttonText: 'Login',
                onPressed: () {
                  handleButtons(context, _ButtonType.LOGIN);
                },
                fillWithDark: false,
              ),
              divider,
              Builder(
                builder: (context) {
                  return AuthButton(
                    buttonText: 'Continue with Google',
                    onPressed: () {
                      handleButtons(context, _ButtonType.GOOGLE);
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
                      'Terms and Conditions',
                      onTap: () {
                        handleButtons(context, _ButtonType.TnC);
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
