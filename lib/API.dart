import 'package:http/http.dart' as http;

Future Getdata(url) async {
  http.Response Response = await http.get(url);
  return Response.body;
}

Future Postdata(url) async{
  http.Response response = await http.post(url);
  return response.body;
}