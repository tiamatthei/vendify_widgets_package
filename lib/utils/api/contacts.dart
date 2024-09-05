import 'dart:convert';
import 'dart:developer';

import 'package:vendify_widgets_package/utils/api/base_api.dart';
import 'package:vendify_widgets_package/classes/contacts/contact.dart';
import 'package:vendify_widgets_package/classes/contacts/contact_label.dart';
import 'package:vendify_widgets_package/classes/contacts/contact_state.dart';
import 'package:vendify_widgets_package/classes/contacts/contact_status.dart';
import 'package:vendify_widgets_package/classes/contacts/interactions.dart';

class ContactsApi extends BaseApi {
  static const String contactsEndpoint = 'contacts';
  Future<List<ContactModel>> getAllTenantContacts(
      {int page = 1,
      String? orderFilter,
      List<Map<String, String>> contactFilters = const [],
      String? query,
      DateTime? startDate,
      DateTime? endDate}) async {
    Map<String, String> queryParams = {
      'page': page.toString(),
    };
    if (orderFilter != null) {
      queryParams['order'] = orderFilter;
    }

    if (contactFilters.isNotEmpty) {
      for (Map<String, String> filter in contactFilters) {
        queryParams.addAll(filter);
      }
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
      String respBody = await BaseApi.get("$contactsEndpoint/tenant", withToken: true, queryParams: queryParams);
      List<ContactModel> model = contactModelFromJson(respBody);
      return model;
    } catch (e) {
      log("Error trying to get contacts: $e");
      return [];
    }
  }

  Future<ContactModel?> getContact(int id) async {
    try {
      String respBody = await BaseApi.get('$contactsEndpoint/$id/details', withToken: true);
      Map<String, dynamic> body = jsonDecode(respBody);
      ContactModel contact = ContactModel.fromJson(body);
      return contact;
    } catch (e) {
      log("Error trying to get contact: $e");
      return null;
    }
  }

  Future<List<ContactModel>> getUserContacts({
    int page = 1,
    String? orderFilter,
    List<Map<String, dynamic>> contactFilters = const [],
  }) async {
    String endpoint = contactsEndpoint;
    Map<String, String> queryParams = {
      'page': page.toString(),
    };
    if (orderFilter != null) {
      queryParams['order'] = orderFilter;
    }

    if (contactFilters.isNotEmpty) {
      List<String> states = [];
      List<String> labels = [];
      for (var filter in contactFilters) {
        if (filter.containsKey('state')) {
          states.add(filter['state']);
        }
        if (filter.containsKey('label')) {
          labels.add(filter['label']);
        }
      }
      if (states.isNotEmpty) {
        queryParams['state'] = states.join(',');
      }
      if (labels.isNotEmpty) {
        queryParams['label'] = labels.join(',');
      }
    }

    try {
      String respBody = await BaseApi.get(endpoint, withToken: true, queryParams: queryParams);
      List<ContactModel> model = contactModelFromJson(respBody);
      return model;
    } catch (e) {
      log("Error trying to get contacts: $e");
      return [];
    }
  }

  Future<bool?> createContact(ContactModel contact) async {
    try {
      var response = await BaseApi.post(contactsEndpoint, contact.toJson(), withToken: true);
      var data = jsonDecode(response);
      if (data['exists']) {
        return false;
      }
      return true;
    } catch (e) {
      log("Error trying to create contact: $e");
      return null;
    }
  }

  Future<bool> updateContact(Map<String, dynamic> contact, int id) async {
    try {
      await BaseApi.patch('$contactsEndpoint/$id/edit', contact, withToken: true);
      return true;
    } catch (e) {
      log("Error trying to update contact: $e");
      return false;
    }
  }

  Future<List<ContactLabel>?> getContactLabels() async {
    try {
      String respBody = await BaseApi.get('$contactsEndpoint/labels', withToken: true);
      List<dynamic> body = jsonDecode(respBody);
      List<ContactLabel> labels = body.map((label) => ContactLabel.fromJson(label)).toList();
      return labels;
    } catch (e) {
      log("Error trying to get contact labels: $e");
      return null;
    }
  }

  Future<List<ContactState>?> getContactStates() async {
    try {
      String respBody = await BaseApi.get('$contactsEndpoint/states', withToken: true);
      List<dynamic> body = jsonDecode(respBody);
      List<ContactState> states = body.map((state) => ContactState.fromJson(state)).toList();
      return states;
    } catch (e) {
      log("Error trying to get contact states: $e");
      return null;
    }
  }


  Future<List<ContactStatus>?> getContactStatus() async {
    try {
      String respBody = await BaseApi.get('$contactsEndpoint/status', withToken: true);
      List<dynamic> body = jsonDecode(respBody);
      List<ContactStatus> status = body.map((status) => ContactStatus.fromJson(status)).toList();
      return status;
    } catch (e) {
      log("Error trying to get contact status: $e");
      return null;
    }
  }

  Future<bool> updateContactState(int contactId, int stateId) async {
    try {
      String respBody =
          await BaseApi.patch('$contactsEndpoint/$contactId/state', {'stateId': stateId}, withToken: true);
      Map<String, dynamic> body = jsonDecode(respBody);
      return body['success'];
    } catch (e) {
      log("Error trying to update contact state: $e");
      return false;
    }
  }

  Future<bool> markAsSeen(int contactId) async {
    //TODO CHECK IF THIS WORKS CORRECTLY
    try {
      String respBody = await BaseApi.post('$contactsEndpoint/$contactId/seen', {}, withToken: true);
      Map<String, dynamic> body = jsonDecode(respBody);
      return body['success'];
    } catch (e) {
      log("Error trying to mark contact as seen: $e");
      return false;
    }
  }

  Future<bool> addLabelToContact(int contactId, int labelId) async {
    try {
      String respBody =
          await BaseApi.post('$contactsEndpoint/$contactId/labels', {'labelId': labelId}, withToken: true);
      Map<String, dynamic> body = jsonDecode(respBody);
      return body['success'];
    } catch (e) {
      log("Error trying to add label to contact: $e");
      return false;
    }
  }

  Future<bool> removeLabelFromContact(int contactId, int labelId) async {
    try {
      String respBody =
          await BaseApi.delete('$contactsEndpoint/$contactId/labels', {'labelId': labelId}, withToken: true);
      Map<String, dynamic> body = jsonDecode(respBody);
      return body['success'];
    } catch (e) {
      log("Error trying to remove label from contact: $e");
      return false;
    }
  }

  Future<List<Interaction>> getContactInteractions(int contactId) async {
    try {
      String respBody = await BaseApi.get('$contactsEndpoint/$contactId/interactions', withToken: true);
      List<dynamic> body = jsonDecode(respBody);
      List<Interaction> interactions = body.map((interaction) => Interaction.fromJson(interaction)).toList();
      return interactions;
    } catch (e) {
      log("Error trying to get contact interactions: $e");
      return [];
    }
  }

  Future<List<Interaction>> getMostRecentInteractions() async {
    try {
      String respBody = await BaseApi.get('$contactsEndpoint/interactions', withToken: true);
      List<dynamic> body = jsonDecode(respBody);
      List<Interaction> interactions = body.map((interaction) => Interaction.fromJson(interaction)).toList();
      return interactions;
    } catch (e) {
      log("Error trying to get most recent interactions: $e");
      return [];
    }
  }

  Future<bool> markInteractionAsSeen(int interactionId) async {
    try {
      String respBody = await BaseApi.patch('$contactsEndpoint/interactions/$interactionId', {}, withToken: true);
      Map<String, dynamic> body = jsonDecode(respBody);
      return body['success'];
    } catch (e) {
      log("Error trying to mark interaction as seen: $e");
      return false;
    }
  }
}