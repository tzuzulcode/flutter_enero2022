import 'package:http/http.dart' as http;


class HttpHelper{
  final Uri baseUrl = Uri(path: "https://backendtzuzulcode.wl.r.appspot.com/movies");

  Future<String> getMovies() async{
    http.Response result = await http.get(baseUrl);
    return "";
  }
}