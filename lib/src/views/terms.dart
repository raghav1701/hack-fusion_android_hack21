import 'package:flutter/material.dart';
import 'package:social_media_app/social_media.dart';

class _TnCBody extends StatelessWidget {
  final double fontSize;

  const _TnCBody({
    this.fontSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextItem('To Do\n...\n...\n...'),
        buildHeaderText('Our Privacy Policy'),
        buildTextItem('...\n...\n...'),
        //TODO: Add Terms and Conditions
      ],
    );
  }

  Widget buildTextItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
        ),
      ),
    );
  }

  Widget buildHeaderText(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: currentAppTheme.isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        child: _TnCBody(),
      ),
    );
  }
}

class TermsAndConditionsDialog extends AlertDialog {
  TermsAndConditionsDialog({
    @required Function onDecline,
    @required Function onAccept,
  }) : super(
          title: Text('Terms and Conditions'),
          actions: [
            _TnCDialogActions(
              onDecline: onDecline,
              onAccept: onAccept,
            ),
          ],
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please read our terms and conditions carefully, and agree to continue.',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 8.0,
              ),
              _TnCBody(),
            ],
          ),
        );
}

class _TnCDialogActions extends StatefulWidget {
  final Function onDecline;
  final Function onAccept;

  const _TnCDialogActions({
    @required this.onDecline,
    @required this.onAccept,
  });

  @override
  __TnCDialogActionsState createState() => __TnCDialogActionsState();
}

class __TnCDialogActionsState extends State<_TnCDialogActions> {
  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Checkbox(
              value: accepted,
              onChanged: (val) {
                if (mounted) {
                  setState(() => accepted = val);
                }
              },
            ),
            Expanded(
              child: Text('I have read and agree to the terms and conditions'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text(
                'Decline',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: widget.onDecline,
            ),
            TextButton(
              child: Text(
                'Accept',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: accepted ? widget.onAccept : null,
            ),
          ],
        ),
      ],
    );
  }
}
