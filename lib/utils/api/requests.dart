import 'dart:convert';
import 'dart:developer';

import 'package:vendify_widgets_package/utils/api/base_api.dart';
import 'package:vendify_widgets_package/classes/contacts/request.dart';
import 'package:vendify_widgets_package/classes/contacts/request_resolution.dart';
import 'package:vendify_widgets_package/classes/contacts/request_type.dart';

class RequestsApi extends BaseApi {
  static const String requestsEndpoint = 'requests';

  Future<List<Request>> getTenantRequests(
      {int page = 1,
      String resolvedFilter = 'all',
      String? orderBy = 'updatedAt',
      String? query,
      DateTime? startDate,
      DateTime? endDate
      //List<Map<String, String>> requestFilters = const [],
      }) async {
    Map<String, String>? queryParams = {
      'page': page.toString(),
    };
    if (orderBy != null) {
      queryParams['order'] = orderBy;
    }
    switch (resolvedFilter) {
      case 'rejected':
        queryParams['resolved'] = false.toString();
        break;
      case 'aproved':
        queryParams['resolved'] = true.toString();
        break;
      case 'pending':
        queryParams['resolved'] = null.toString();
        break;
      default:
        break;
    }

    if (query != null && query.isNotEmpty) {
      queryParams['search'] = query;
    }

    if (startDate != null) {
      queryParams['start_date'] = startDate.toIso8601String().split('T')[0];
    }

    if (endDate != null) {
      queryParams['end_date'] = endDate.toIso8601String().split('T')[0];
    }

    try {
      String respBody = await BaseApi.get("$requestsEndpoint/tenant", withToken: true, queryParams: queryParams);
      List<dynamic> body = jsonDecode(respBody);
      List<Request> model = List<Request>.from(body.map((x) => Request.fromJson(x)));
      return model;
    } catch (e) {
      return [];
    }
  }

  Future<List<Request>> getUserRequests() async {
    try {
      String respBody = await BaseApi.get('$requestsEndpoint/executive', withToken: true);
      List<Request> model = (jsonDecode(respBody) as List).map((e) => Request.fromJson(e)).toList();
      return model;
    } catch (e) {
      log("Error trying to get requests: $e");
      return [];
    }
  }

  Future<List<RequestType>> getRequestTypes(int tenantId) async {
    Map<String, String> queryParams = {
      'tenantId': tenantId.toString(),
    };

    try {
      String respBody = await BaseApi.get("$requestsEndpoint/types", withToken: true, queryParams: queryParams);
      List<dynamic> body = jsonDecode(respBody);
      List<RequestType> model = List<RequestType>.from(body.map((x) => RequestType.fromJson(x)));
      return model;
    } catch (e) {
      log("Error trying to get request types: $e");
      return [];
    }
  }

  Future<List<RequestResolution>> getRequestResolutions() async {
    try {
      String respBody = await BaseApi.get("$requestsEndpoint/resolutions", withToken: true);
      List<dynamic> body = jsonDecode(respBody);
      List<RequestResolution> model = List<RequestResolution>.from(body.map((x) => RequestResolution.fromJson(x)));
      return model;
    } catch (e) {
      log("Error trying to get request resolutions: $e");
      return [];
    }
  }

  Future<bool> createRequest(int userId, int contactId, int requestTypeId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'contactId': contactId,
      'requestTypeId': requestTypeId,
    };

    try {
      await BaseApi.post(
        requestsEndpoint,
        body,
        withToken: true,
      );
      return true;
    } catch (e) {
      log("Error trying to create request: $e");
      return false;
    }
  }

  Future<bool> updateRequest(int requestId, Map<String, dynamic> changes) async {
    try {
      await BaseApi.patch(
        "$requestsEndpoint/$requestId",
        changes,
        withToken: true,
      );
      return true;
    } catch (e) {
      log("Error trying to update request: $e");
      return false;
    }
  }

  Future<List<Request>> getExecutiveRequests(int userId) async {
    Map<String, String> queryParams = {
      'userId': userId.toString(),
    };

    try {
      String respBody = await BaseApi.get("$requestsEndpoint/executive", withToken: true, queryParams: queryParams);
      List<dynamic> body = jsonDecode(respBody);
      List<Request> requests = List<Request>.from(body.map((x) => Request.fromJson(x)));
      return requests;
    } catch (e) {
      log("Error trying to get executive requests: $e");
      return [];
    }
  }

  Future<List<Request>> getContactRequests(int contactId) async {
    try {
      String respBody = await BaseApi.get("$requestsEndpoint/$contactId/contact", withToken: true);
      List<dynamic> body = jsonDecode(respBody);
      List<Request> requests = List<Request>.from(body.map((x) => Request.fromJson(x)));
      return requests;
    } catch (e) {
      log("Error trying to get contact requests: $e");
      return [];
    }
  }

  Future<List<Map>> getMetricas() async {
    //Esto es una lista de mapas, pero realmente viene solo un mapa siempre,
    //TODO arreglar el backend para que devuelva un mapa en vez de una lista
    //TODO cambiar acá para que devuelva un mapa en vez de una lista
    try {
      String respBody = await BaseApi.get("$requestsEndpoint/metrics", withToken: true);
      List<dynamic> body = jsonDecode(respBody);
      List<Map> metricas = List<Map>.from(body.map((x) => x as Map));
      return metricas;
    } catch (e) {
      log("Error trying to get metricas: $e");
      return [];
    }
  }
}
