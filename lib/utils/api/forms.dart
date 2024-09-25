import 'dart:convert';
import 'dart:developer';

import 'package:vendify_widgets_package/classes/forms/form.dart';
import 'package:vendify_widgets_package/classes/forms/form_field.dart';
import 'package:vendify_widgets_package/utils/api/base_api.dart';

class FormsApi extends BaseApi {
  static const String formsEndpoint = 'forms';

  Future<List<FormModel>?> getForms() async {
    String endpoint = '$formsEndpoint';
    try {
      String respBody = await BaseApi.get(endpoint, withToken: true);
      List<FormModel> model = (jsonDecode(respBody) as List).map((e) => FormModel.fromJson(e)).toList();
      return model;
    } catch (e) {
      log("Error trying to get forms: $e");
      return [];
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
}
