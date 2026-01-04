import 'package:demodartapi/api_key.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main(List<String> arguments) {
  //getRequet();

  sentDataAsync({
    "id": 4,
    "name": "Kalin",
    "lastName": "Ston",
    "balance": 5000,
  });
}

getRequet() {
  String url =
      "https://gist.githubusercontent.com/kalistons/efdbe248b5985967f2472be3ee264a87/raw/175845bfa3939c640c2b5a3f827ff69895923762/accounts.json";
  Future<Response> response = get(Uri.parse(url));
  response.then((value) {
    print(value.body);

    List<dynamic> listAccounts = json.decode(value.body);
    Map<String, dynamic> carlaAccount = listAccounts.firstWhere(
      (account) => account['name'] == "Carla",
    );
    print(carlaAccount['balance']);
  });
}

getAsyncRequest() async {
  String url =
      "https://gist.githubusercontent.com/kalistons/efdbe248b5985967f2472be3ee264a87/raw/175845bfa3939c640c2b5a3f827ff69895923762/accounts.json";
  Response response = await get(Uri.parse(url));
  print(response.body);

  List<dynamic> listAccounts = json.decode(response.body);
  Map<String, dynamic> carlaAccount = listAccounts.firstWhere(
    (account) => account['name'] == "Carla",
  );
  print(carlaAccount['balance']);
}

Future<List<dynamic>> requestDataAsync() async {
  String url =
      "https://gist.githubusercontent.com/kalistons/efdbe248b5985967f2472be3ee264a87/raw/175845bfa3939c640c2b5a3f827ff69895923762/accounts.json";
  Response response = await get(Uri.parse(url));

  return json.decode(response.body);
}

sentDataAsync(Map<String, dynamic> newAccount) async {
  List<dynamic> accounts = await requestDataAsync();
  accounts.add(newAccount);
  String content = json.encode(accounts);
  print(content);

  String url = "https://api.github.com/gists/efdbe248b5985967f2472be3ee264a87";
  Response response = await post(
    Uri.parse(url),
    headers: {"Authorization": "Bearer $apiKey"},

    body: json.encode({
      "description": "accounts.json", 
      "files": {
      "accounts.json": {
        "content": content
        } 
    }}),
  );
  print(response.statusCode);
}
