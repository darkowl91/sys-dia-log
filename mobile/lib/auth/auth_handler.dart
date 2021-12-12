import 'dart:async';

import 'package:chopper/chopper.dart';

class AuthHandler implements RequestInterceptor {
  @override
  Future<Request> onRequest(Request request) async {
    const String jwt = "";
    return applyHeader(request, 'authorization', "Bearer $jwt");
  }
}
