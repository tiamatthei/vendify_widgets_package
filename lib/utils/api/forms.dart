import 'dart:convert';
import 'dart:developer';

import 'package:vendify_widgets_package/classes/forms/form.dart';
import 'package:vendify_widgets_package/classes/forms/form_field.dart';
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

  Future<List<FormResponseModel>?> getFormResponses(int formId) async {
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
}
