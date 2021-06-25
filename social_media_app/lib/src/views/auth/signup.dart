import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:social_media_app/social_media.dart';

typedef _FormCallback = void Function(String val);

class SignupScreen extends StatefulWidget {
  static const btnPadding = 42.0;

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  ProgressDialog progressDialog;
  String name, email, password, error;

  void saveForm() {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    FocusScope.of(context).unfocus();
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (_) => TermsAndConditionsDialog(
        onDecline: () => Navigator.of(context).pop(),
        onAccept: () {
          Navigator.of(context).pop();
          handleSignUp();
        },
      ),
    );
  }

  void handleSignUp() async {
    var service = FirebaseAuthService(
      email: email,
      password: password,
      name: name,
      onStart: () {
        if (mounted) {
          setState(() => error = null);
          progressDialog.show();
        }
      },
      onFinish: (user, accessLevel) async {
        await progressDialog.hide();
        await sharedPreferences.saveUserRole(level: accessLevel);
        Navigator.of(context).pushNamedAndRemoveUntil(Routes.dashboard, (route) => false);
      },
      onError: (code, message) {
        if (mounted) {
          progressDialog.hide();
          setState(() => error = message);
        }
      },
    );
    await service.createUser();
  }

  void handleButton() {
    Navigator.of(context).pushReplacementNamed(Routes.signin);
  }

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
            Text('Signing up new user...'),
          ],
        ),
      ),
    );
  }

  final image = Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 44.0,
      vertical: 44.0,
    ),
    child: Image.asset(
      Assets.signupPageImage,
      fit: BoxFit.fitWidth,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                image,
                buildTextFormField(
                  hintText: 'Name',
                  onSaved: (val) => name = val,
                  validator: validateName,
                ),
                buildTextFormField(
                  hintText: 'Email',
                  onSaved: (val) => email = val,
                  textInputType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
                buildTextFormField(
                  hintText: 'Password',
                  onSaved: (val) => password = val,
                  validator: validatePassword,
                  textInputType: TextInputType.visiblePassword,
                  showText: false,
                ),
                Visibility(
                  visible: error != null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SignupScreen.btnPadding,
                      vertical: 8.0
                    ),
                    child: Text('$error', style: ThemeConstants.kErrorMessageTextStyle),
                  ),
                  replacement: SizedBox(
                    height: 16.0,
                  ),
                ),
                AuthButton(
                  buttonText: 'Sign Up',
                  onPressed: saveForm,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? '),
                    InteractiveText(
                      'Login',
                      onTap: handleButton,
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField({String hintText, _FormCallback onSaved, _FormCallback validator, TextInputType textInputType, bool showText = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SignupScreen.btnPadding,
        vertical: 8.0,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          errorMaxLines: 3,
        ),
        onSaved: onSaved,
        validator: validator,
        keyboardType: textInputType,
        obscureText: !showText,
      ),
    );
  }
}
