import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  testWidgets('MyPortfolio homepage loads successfully', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MyApp(apiClient: ApiClient()));

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
