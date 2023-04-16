import 'package:http/http.dart' as http;

Getdata (String url) async{
  http.Response res = await http.get(Uri.parse(url));
  return res.body;
}