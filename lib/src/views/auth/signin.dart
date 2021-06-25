import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:social_media_app/social_media.dart';

typedef _FormCallback = void Function(String val);

class SigninScreen extends StatefulWidget {
  static const btnPadding = 42.0;

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  ProgressDialog progressDialog;
  String email, password, error;

  void saveForm() {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    FocusScope.of(context).unfocus();
    handleSignIn();
  }

  void handleSignIn() async {
    var service = FirebaseAuthService(
      email: email,
      password: password,
      onStart: () {
        if (mounted) {
          setState(() => error = null);
          progressDialog.show();
        }
      },
      onFinish: (user) async {
        await progressDialog.hide();
        var result = await FirestoreService.getRole(user?.uid);
        await sharedPreferences.saveUserRole(level: int.tryParse(result.message));
        Navigator.of(context).pushNamedAndRemoveUntil(Routes.dashboard, (route) => false);
      },
      onError: (code, message) {
        if (mounted) {
          progressDialog.hide();
          setState(() => error = message);
        }
      },
    );
    await service.loginUser();
  }

  void handleForgotPassword() {
    //TODO: Forgot Password
  }

  void handleButton() {
    Navigator.of(context).pushReplacementNamed(Routes.signup);
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
            Text('Logging In...'),
          ],
        ),
      ),
    );
  }

  final image = Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 32.0,
      vertical: 64.0,
    ),
    child: Image.asset(
      Assets.loginPageImage,
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
                  hintText: 'Email',
                  onSaved: (val) => email = val,
                  textInputType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
                buildTextFormField(
                  hintText: 'Password',
                  onSaved: (val) => password = val,
                  validator: requiredFormField,
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
                  buttonText: 'Login',
                  onPressed: saveForm,
                ),
                SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account? '),
                    InteractiveText(
                      'Sign Up',
                      onTap: handleButton,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                InteractiveText(
                  'Forgot Password?',
                  onTap: handleForgotPassword,
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
