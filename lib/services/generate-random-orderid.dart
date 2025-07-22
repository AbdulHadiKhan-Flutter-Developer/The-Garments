import 'dart:math';

String GenerateRandomOrderId() {
  DateTime time = DateTime.now();

  int randomnumber = Random().nextInt(13654);

  String OrderId = '${time.microsecond}_$randomnumber';

  return OrderId;
}
