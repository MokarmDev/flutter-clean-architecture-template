import 'core/constants/api_endpoints.dart';
import 'core/constants/app_strings.dart';
import 'main_common.dart';

void main() async {
  await mainCommon(name: AppStrings.dev, baseUrl: ApiEndpoints.baseUrlDev);
}
