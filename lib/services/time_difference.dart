import 'package:cloud_firestore/cloud_firestore.dart';

String timeDifference(Timestamp timestamp) {
  DateTime then = timestamp.toDate();
  DateTime now = DateTime.now();

  Duration timeDifference = now.difference(then);

  if (timeDifference.inDays >= 1) {
    return '${timeDifference.inDays} days ago';
  } else if (timeDifference.inHours >= 1) {
    return '${timeDifference.inHours} hours ago';
  } else if (timeDifference.inMinutes >= 1) {
    return '${timeDifference.inMinutes} minutes ago';
  } else {
    return 'now';
  }
}