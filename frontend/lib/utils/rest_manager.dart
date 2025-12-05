import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'error_listener.dart';

enum TypeHeader { json, urlencoded }

class RestManager {
  ErrorListener delegate;
  String token;

  Future<Response> _makeRequest(String serverAddress, String servicePath, String method, TypeHeader type, {Map<String, dynamic> value, dynamic body}) async {
    print(value.toString());
    Uri uri = Uri.http(serverAddress, servicePath, value);
    bool errorOccurred = false;
    while (true) {
      print(uri.toString());
      try {
        Response response;
        // setting content type
        String contentType;
        dynamic formattedBody;
        if (type == TypeHeader.json) {
          contentType = "application/json;charset=utf-8";
          formattedBody = json.encode(body);
          print(formattedBody);
          print(67);

        } else if (type == TypeHeader.urlencoded) {
          contentType = "application/x-www-form-urlencoded";
          formattedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
          print(formattedBody);
          print(31);
        }
        // setting headers
        Map<String, String> headers = Map();
        // if(contentType != null)
        headers[HttpHeaders.contentTypeHeader] = contentType;

        print(headers[HttpHeaders.authorizationHeader]);
        if (token != null) {
          headers[HttpHeaders.authorizationHeader] = 'bearer $token';
        }
        // making request
        switch (method) {
          case "post":

            print(headers[HttpHeaders.authorizationHeader]);
            print("si");
            print(uri);
            print(headers);
            response = await post(
              uri,
              headers: headers,
              body: formattedBody,
            );
            print("20");
            print(response.body);
            break;
          case "get":
            {  print(headers);
            print("get");
              response = await get(
                uri,
                headers: headers,
              );
              print(response.body);
              print("get");

            }
            break;
          case "put":
            response = await put(
              uri,
              headers: headers,
            );
            break;
          case "delete":
            response = await delete(
              uri,
              headers: headers,
            );
            break;
        }
        if (delegate != null && errorOccurred) {
          print("NETWORK GONE");
          delegate.errorNetworkGone();
          errorOccurred = false;
        }
        return response;
      } catch (err) {
        print(err);
        if (delegate != null && !errorOccurred) {
          delegate.errorNetworkOccurred("connection_error");
          errorOccurred = true;
        }
        await Future.delayed(
            const Duration(seconds: 5), () => null); // not the best solution
      }
    }
  }

  Future<Response> makePostRequest(
      String serverAddress, String servicePath, dynamic body,
      {Map<String, dynamic> value,
        TypeHeader type = TypeHeader.json}) async {
    return _makeRequest(serverAddress, servicePath, "post", type, body: body, value: value);
  }

  Future<Response> makeGetRequest(String serverAddress, String servicePath,
      [Map<String, dynamic> value, TypeHeader type]) async {
    return _makeRequest(serverAddress, servicePath, "get", type , value: value);
  }

  Future<Response> makePutRequest(String serverAddress, String servicePath,
      [Map<String, dynamic> value, TypeHeader type]) async {
    return _makeRequest(serverAddress, servicePath, "put", type, value: value);
  }

  Future<Response> makeDeleteRequest(String serverAddress, String servicePath,
      [Map<String, dynamic> value, TypeHeader type]) async {
    return _makeRequest(serverAddress, servicePath, "delete", type,
        value: value);
  }

}
