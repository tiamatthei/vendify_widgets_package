import 'package:vendify_widgets_package/classes/user.dart';

User? loggedUser;

const String apiBaseUrl = String.fromEnvironment("API_BASE_URL", defaultValue: "localhost:3000");
const String environment = String.fromEnvironment("APP_ENV", defaultValue: "dev");
