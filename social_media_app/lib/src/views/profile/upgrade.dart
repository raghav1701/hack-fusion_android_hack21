import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:social_media_app/social_media.dart';

typedef _OnSavedCallback = void Function(String val);

class UpgradeProfileScreen extends StatefulWidget {
  @override
  _UpgradeProfileScreenState createState() => _UpgradeProfileScreenState();
}

class _UpgradeProfileScreenState extends State<UpgradeProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  ProgressDialog progressDialog;

  bool submitted = false;
  int level;
  String phone, address, docLink;

  void saveForm() async {
    setState(() {
      submitted = true;
    });
    if (!formKey.currentState.validate() || level == null) return;
    formKey.currentState.save();

    FocusScope.of(context).unfocus();
    await progressDialog.show();
    var result = await FirestoreService().postUpgradeRequest(RequestItem(
        uid: FirebaseAuthService.user.uid,
        name: FirebaseAuthService.user.displayName,
        email: FirebaseAuthService.user.email,
        phone: phone,
        address: address,
        docLink: docLink,
        level: level,
        timestamp: Timestamp.now(),
      ),
    );

    if (!mounted) return;

    await progressDialog.hide();
    ScaffoldMessenger.of(scaffoldKey.currentContext)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(result.message),
      ));
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
            Text('Adding Upgrade Request...'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Upgrade Level'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Please fill up the form below'),
              SizedBox(height: 8.0),
              Text('Note-', style: TextStyle(fontWeight: FontWeight.w600)),
              Text(
                  'All your information will be manually verified by our officials, and only upon confirmation you\'ll get higher access.'),
              SizedBox(height: 16.0),
              buildTextField(
                'Phone',
                onSaved: (val) => phone = val,
              ),
              buildTextField(
                'Address',
                onSaved: (val) => address = val,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Text(
                    'Upload photo of any of your original govt. id in some cloud and share link in the field below.'),
              ),
              buildTextField(
                'Government Id',
                onSaved: (val) => docLink = val,
              ),
              SizedBox(height: 4.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text('Upgrade to'),
              ),
              buildRadio('NGO', 2),
              buildRadio('Govt Official', 3),
              Visibility(
                visible: submitted && level == null,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                  ),
                  child: Text(
                    'This is a required field',
                    style: ThemeConstants.kErrorMessageTextStyle
                        .copyWith(fontSize: 12.0),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              AuthButton(
                buttonText: 'Submit',
                onPressed: saveForm,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hintText,
      {_OnSavedCallback onSaved, _OnSavedCallback validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
        ),
        onSaved: onSaved,
        validator: validator ?? requiredFormField,
      ),
    );
  }

  Widget buildRadio(String text, int value) {
    return Row(
      children: [
        Radio<int>(
          value: value,
          groupValue: level,
          onChanged: (val) => setState(() => level = val),
        ),
        Text(text),
      ],
    );
  }
}
