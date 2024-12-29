import 'dart:convert';
import 'dart:developer';
import 'package:vendify_widgets_package/classes/etraining/assistant_config.dart';
import 'package:vendify_widgets_package/utils/api/base_api.dart';

class AssistantApi extends BaseApi {
  static const String assistantEndpoint = 'assistant';

  Future<AssistantConfig?> createAssistantConfig(int tenantId, Map<String, dynamic> assistantConfig) async {
    String endpoint = assistantEndpoint;
    try {
      log("Creating assistant config...");
      String respBody = await BaseApi.post(
          endpoint,
          {
            'tenantId': tenantId,
            ...assistantConfig,
          },
          withToken: true);
      return AssistantConfig.fromJson(jsonDecode(respBody));
    } catch (e) {
      log("Error trying to create assistant config: $e");
      return null;
    }
  }

  Future<List<AssistantConfig>?> getAssistantConfigs(int tenantId) async {
    String endpoint = assistantEndpoint;
    try {
      log("Getting assistant configs...");
      String respBody = await BaseApi.get(endpoint, queryParams: {'tenantId': tenantId.toString()}, withToken: true);
      return (jsonDecode(respBody) as List).map((e) => AssistantConfig.fromJson(e)).toList();
    } catch (e) {
      log("Error trying to get assistant configs: $e");
      return null;
    }
  }

  Future<AssistantConfig?> getAssistantConfigById(int tenantId, int id) async {
    String endpoint = '$assistantEndpoint/$id';
    try {
      log("Getting assistant config by id...");
      String respBody = await BaseApi.get(endpoint, queryParams: {'tenantId': tenantId.toString()}, withToken: true);
      return AssistantConfig.fromJson(jsonDecode(respBody));
    } catch (e) {
      log("Error trying to get assistant config by id: $e");
      return null;
    }
  }

  Future<List<AssistantConfig>?> getAssistantConfigsByTenantId(int tenantId) async {
    String endpoint = '$assistantEndpoint/tenant';
    try {
      log("Getting assistant configs by tenant id...");
      String respBody = await BaseApi.get(endpoint, queryParams: {'tenantId': tenantId.toString()}, withToken: true);
      return (jsonDecode(respBody) as List).map((e) => AssistantConfig.fromJson(e)).toList();
    } catch (e) {
      log("Error trying to get assistant configs by tenant id: $e");
      return null;
    }
  }

  Future<AssistantConfig?> updateAssistantConfig(int tenantId, int id, Map<String, dynamic> updateConfig) async {
    String endpoint = '$assistantEndpoint/$id';
    try {
      log("Updating assistant config...");
      String respBody = await BaseApi.patch(endpoint, {'tenantId': tenantId, ...updateConfig}, withToken: true);
      return AssistantConfig.fromJson(jsonDecode(respBody));
    } catch (e) {
      log("Error trying to update assistant config: $e");
      return null;
    }
  }

  Future<bool> deleteAssistantConfig(int tenantId, int id) async {
    String endpoint = '$assistantEndpoint/$id';
    try {
      log("Deleting assistant config...");
      await BaseApi.delete(endpoint, {'tenantId': tenantId.toString()}, withToken: true);
      return true;
    } catch (e) {
      log("Error trying to delete assistant config: $e");
      return false;
    }
  }
}
