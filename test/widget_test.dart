import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/shared/widgets/no_data_found_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('NoDataFoundWidget renders empty-state title', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NoDataFoundWidget(title: 'No Data Found'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No Data Found'), findsOneWidget);
  });
}
