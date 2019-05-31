import 'package:cztery_pory_roku/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserData> getUser() async {
  final SharedPreferences user = await SharedPreferences.getInstance();
  var id = user.getInt('id');
  var name = user.getString('name');
  var lastName = user.getString('lastName');

  return UserData(id, name, lastName);
}
