import 'dart:convert';
import 'dart:developer';

import 'package:vendify_widgets_package/utils/api/base_api.dart';

class GroupsApi extends BaseApi {
  static const String groupsEndpoint = 'groups';

  // Get child groups by parentGroupId.
  Future<List<int>?> getChildGroupsByParentGroupAndUser(
      int parentGroupId) async {
    String endpoint = '$groupsEndpoint/child-groups/$parentGroupId';
    try {
      String respBody = await BaseApi.get(endpoint, withToken: true);
      List<dynamic> jsonList = jsonDecode(respBody);
      return jsonList.map((e) => int.parse(e.toString())).toList();
    } catch (e) {
      log("Error in getChildGroupsByParentGroupAndUser: $e");
      return null;
    }
  }

  // Get contacts count by state and form field grouped by group.
  Future<List<Map<String, dynamic>>>
      getCountContactsByStateAndFormFieldGroupedByGroups({
    int? formFieldId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      Map<String, String> queryParameters = {};
      if (formFieldId != null) {
        queryParameters['form_field_id'] = formFieldId.toString();
      }
      if (startDate != null) {
        queryParameters['start_date'] =
            startDate.toIso8601String().split('T')[0];
      }
      if (endDate != null) {
        queryParameters['end_date'] = endDate.toIso8601String().split('T')[0];
      }
      String respBody = await BaseApi.get(
          '$groupsEndpoint/contacts-by-state-and-form-field',
          withToken: true,
          queryParams: queryParameters);
      List<dynamic> data = jsonDecode(respBody);
      List<Map<String, dynamic>> contacts =
          data.map((contact) => contact as Map<String, dynamic>).toList();
      return contacts;
    } catch (e) {
      log("Error in getCountContactsByStateAndFormFieldGroupedByGroups: $e");
      return [];
    }
  }
}
