import 'dart:async';

import 'package:chopper/chopper.dart';

class AuthHandler {
  final String clientId;
  final String authDomain;
  final String redirectUri;

  AuthHandler(this.clientId, this.authDomain, this.redirectUri);

  FutureOr<Request> onRequest(Request request) async {
    const String jwt = "";
    return applyHeader(request, 'Authorization', "Bearer $jwt");
  }
}
