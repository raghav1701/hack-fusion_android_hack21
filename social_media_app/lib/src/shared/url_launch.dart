import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/social_media.dart';
import 'package:url_launcher/url_launcher.dart';

Future<Result> callto(String phone) async {
  var url = 'tel://$phone';
  if (await canLaunch(url)) {
    await launch(url);
    return Result(code: Code.SUCCESS);
  } else {
    return Result(code: Code.EXCEPTION, message: 'Failed to open phone');
  }
}

Future<Result> launchMaps(GeoPoint source, GeoPoint destination) async {
  var url = "http://maps.google.com/maps?saddr="
      + source.latitude.toString() + ","
      + source.longitude.toString() + "&daddr="
      + destination.latitude.toString() + ","
      + destination.longitude.toString();
  if (await canLaunch(url)) {
    await launch(url);
    return Result(code: Code.SUCCESS);
  } else {
    return Result(code: Code.EXCEPTION, message: 'Failed to open maps');
  }
}
