import 'package:vendify_widgets_package/classes/users/user_parent.dart';

UserParent? loggedUser;

const String apiBaseUrl = String.fromEnvironment("API_BASE_URL", defaultValue: "localhost:3000");
const String environment = String.fromEnvironment("APP_ENV", defaultValue: "dev");
