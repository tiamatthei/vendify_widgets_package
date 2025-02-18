import 'dart:convert';
import 'dart:developer';

import 'package:vendify_widgets_package/classes/contacts/contact.dart';
import 'package:vendify_widgets_package/classes/forms/form.dart';
import 'package:vendify_widgets_package/classes/forms/form_field.dart';
import 'package:vendify_widgets_package/classes/forms/form_field_value.dart';
import 'package:vendify_widgets_package/classes/forms/form_response.dart';
import 'package:vendify_widgets_package/utils/api/base_api.dart';

class FormsApi extends BaseApi {
  static const String formsEndpoint = 'forms';

  Future<List<FormModel>?> getForms() async {
    String endpoint = formsEndpoint;
    try {
      String respBody = await BaseApi.get(endpoint, withToken: true);
      List<FormModel> model = (jsonDecode(respBody) as List).map((e) => FormModel.fromJson(e)).toList();
      return model;
    } catch (e) {
      log("Error trying to get forms: $e");
      return [];
    }
  }

  Future<FormModel> getFormData(int formId) async {
    String endpoint = '$formsEndpoint/$formId';
    try {
      String respBody = await BaseApi.get(endpoint, withToken: true);
      FormModel model = FormModel.fromJson(jsonDecode(respBody));
      return model;
    } catch (e) {
      log("Error trying to get form data: $e");
      return FormModel(formId: 0, formFields: []);
    }
  }

  Future<bool> createForm(
    String formTitle,
    String formDescription,
    List<FormFieldModel> formFields,
  ) async {
    String endpoint = '$formsEndpoint/create';

    Map<String, dynamic> formDetails = {
      'title': formTitle,
      'description': formDescription,
      'fields': formFields.map((e) => e.toJson()).toList(),
    };

    try {
      log("Creating form...");
      await BaseApi.post(endpoint, formDetails, withToken: true);
      return true;
    } catch (e) {
      log("Error trying to create form: $e");
      return false;
    }
  }

  Future<bool> updateForm(int formId, Map<String, dynamic> formDetails) async {
    String endpoint = '$formsEndpoint/update/$formId';
    try {
      log("Updating form...");
      await BaseApi.patch(endpoint, formDetails, withToken: true);
      return true;
    } catch (e) {
      log("Error trying to update form: $e");
      return false;
    }
  }

  Future<bool> deleteForm(int formId) async {
    String endpoint = '$formsEndpoint/delete/$formId';
    try {
      log("Deleting form...");
      await BaseApi.delete(endpoint, {}, withToken: true);
      return true;
    } catch (e) {
      log("Error trying to delete form: $e");
      return false;
    }
  }

  Future<bool> registerFormResponse(FormResponseModel response) async {
    String endpoint = '$formsEndpoint/response';
    try {
      log("Registering form response...");
      Map<String, dynamic> formResponse = {
        'formId': response.formId,
        'contactId': response.contactId,
        'responses': response.formFieldValues?.map((e) => e.toJson()).toList(),
      };
      await BaseApi.post(endpoint, formResponse, withToken: true);
      return true;
    } catch (e) {
      log("Error trying to register form response: $e");
      return false;
    }
  }

  Future<ContactModel?> registerInitialFormResponse(FormResponseModel response, {ContactModel? contactInfo, double? latitude, double? longitude}) async {
    String endpoint = '$formsEndpoint/initial-response';
    try {
      Map<String, dynamic> body = response.toJson();
      if (latitude != null) body['latitude'] = latitude;
      if (longitude != null) body['longitude'] = longitude;
      if (contactInfo != null) body['contactInfo'] = contactInfo.toJson();

      final responseString = await BaseApi.post(endpoint, body, withToken: true);

      final responseJson = jsonDecode(responseString) as Map<String, dynamic>;

      log(responseJson.toString());

      if (responseJson['success'] == true) {
        return ContactModel.fromJson(responseJson['data']);
      } else {
        throw Exception(responseJson['message'] ?? 'Error desconocido al registrar la respuesta inicial.');
      }
    } catch (e) {
      log("Error trying to register initial form response: $e");
      throw Exception(e.toString());
    }
  }

  Future<List<FormResponseModel>?> getFormResponses(int formId) async {
    //Get all responses for a form (used for admin)
    String endpoint = '$formsEndpoint/responses/$formId';
    try {
      String respBody = await BaseApi.get(endpoint, withToken: true);
      List<FormResponseModel> model = (jsonDecode(respBody) as List).map((e) => FormResponseModel.fromJson(e)).toList();
      return model;
    } catch (e) {
      log("Error trying to get form responses: $e");
      return [];
    }
  }

  Future<FormResponseModel> getFormResponse(int formResponseId) async {
    //Get the data of a single form response in particular
    String endpoint = '$formsEndpoint/response/$formResponseId';
    try {
      String respBody = await BaseApi.get(endpoint, withToken: true);
      FormResponseModel model = FormResponseModel.fromJson(jsonDecode(respBody));
      return model;
    } catch (e) {
      log("Error trying to get form response: $e");
      return FormResponseModel();
    }
  }

  Future<List<FormResponseModel>?> getContactFormResponses(int contactId) async {
    //Get all form responses for a contact
    String endpoint = '$formsEndpoint/responses/contact/$contactId';
    try {
      String respBody = await BaseApi.get(endpoint, withToken: true);
      List<FormResponseModel> model = (jsonDecode(respBody) as List).map((e) => FormResponseModel.fromJson(e)).toList();
      return model;
    } catch (e) {
      log("Error trying to get contact form responses: $e");
      return [];
    }
  }

  Future<bool> updateFormResponseValues(List<FormFieldValueModel> formFieldValues, {ContactModel? contactInfo}) async {
    String endpoint = '$formsEndpoint/response';
    log("Updating form response values...");
    try {
      Map<String, dynamic> formResponse = {
        'responses': formFieldValues.map((e) => e.toJson()).toList(),
      };
      if (contactInfo != null) {
        formResponse['contactInfo'] = contactInfo.toJson();
      }
      log("Form response: $formResponse");
      await BaseApi.patch(endpoint, formResponse, withToken: true);
      log("Form response updated successfully");
      return true;
    } catch (e) {
      log("Error trying to update form response values: $e");
      return false;
    }
  }

  Future<List<FormResponseModel>?> getContactsWithFormResponses(int formId) async {
    String endpoint = '$formsEndpoint/responses/contacts/$formId';
    try {
      String respBody = await BaseApi.get(endpoint, withToken: true);
      log("Response body: $respBody");
      List<FormResponseModel> contacts = (jsonDecode(respBody) as List)
          .map((e) => FormResponseModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return contacts;
    } catch (e) {
      log("Error trying to get contacts with form responses: $e");
      return [];
    }
  }

  Future<Map<String, int>> getFormFieldValueStats(int formId, int formFieldId, {String? startDate, String? endDate, List<int>? groupIds, List<int>? executiveIds}) async {
    String endpoint = '$formsEndpoint/stats/$formId/$formFieldId';
    try {
      Map<String, String> queryParams = {};
      if (startDate != null) queryParams['startDate'] = startDate;
      if (endDate != null) queryParams['endDate'] = endDate;
      if (groupIds != null) queryParams['groupIds'] = groupIds.join(',');
      if (executiveIds != null) queryParams['executiveIds'] = executiveIds.join(',');

      String respBody = await BaseApi.get(endpoint, withToken: true, queryParams: queryParams);
      Map<String, int> stats = Map<String, int>.from(jsonDecode(respBody));
      return stats;
    } catch (e) {
      log("Error trying to get form field value stats: $e");
      return {};
    }
  }
}
