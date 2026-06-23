import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/design_system/design_system.dart';
import 'package:flutter_clean_architecture_template/features/cart/presentation/pages/cart_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildDesignSystemTestApp(Widget home) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        final designTheme = AppDesignTheme.light();

        return DesignSystemApp(
          designTheme: designTheme,
          child: MaterialApp(theme: designTheme.toThemeData(), home: home),
        );
      },
    );
  }

  testWidgets('design system button handles taps', (tester) async {
    var tapCount = 0;

    await tester.pumpWidget(
      buildDesignSystemTestApp(
        Scaffold(
          body: Center(
            child: DsButton(label: 'Continue', onPressed: () => tapCount++),
          ),
        ),
      ),
    );

    expect(find.text('Continue'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pump();

    expect(tapCount, 1);
  });

  testWidgets('text widget hides empty values', (tester) async {
    await tester.pumpWidget(
      buildDesignSystemTestApp(
        const Scaffold(
          body: Column(
            children: [TextWidget(''), TextWidget.title('Visible title')],
          ),
        ),
      ),
    );

    expect(find.text(''), findsNothing);
    expect(find.text('Visible title'), findsOneWidget);
  });

  testWidgets('scaffold app bar footer and states render', (tester) async {
    await tester.pumpWidget(
      buildDesignSystemTestApp(
        const DsScaffold(
          title: 'Dashboard',
          body: DsEmpty(title: 'Empty state'),
          footer: DsButton(label: 'Footer action', onPressed: null),
        ),
      ),
    );

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Empty state'), findsOneWidget);
    expect(find.text('Footer action'), findsOneWidget);
  });

  testWidgets('dialog and bottom sheet open', (tester) async {
    await tester.pumpWidget(
      buildDesignSystemTestApp(
        Builder(
          builder: (context) => DsScaffold(
            body: Column(
              children: [
                DsButton(
                  label: 'Open dialog',
                  onPressed: () => DsDialog.alert(
                    context: context,
                    title: 'Alert title',
                    message: 'Alert message',
                  ),
                ),
                DsButton(
                  label: 'Open sheet',
                  onPressed: () => DsBottomSheet.show(
                    context: context,
                    title: 'Sheet title',
                    child: const TextWidget('Sheet body'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open dialog'));
    await tester.pumpAndSettle();
    expect(find.text('Alert title'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Open sheet'));
    await tester.pumpAndSettle();
    expect(find.text('Sheet title'), findsOneWidget);
    expect(find.text('Sheet body'), findsOneWidget);
  });

  testWidgets('snackbar shows feedback message', (tester) async {
    await tester.pumpWidget(
      buildDesignSystemTestApp(
        Builder(
          builder: (context) => DsScaffold(
            body: DsButton(
              label: 'Show snackbar',
              onPressed: () => DsSnackbar.success(context, 'Saved'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show snackbar'));
    await tester.pump();

    expect(find.text('Saved'), findsOneWidget);
  });

  testWidgets('cart page exercises design system components', (tester) async {
    await tester.pumpWidget(buildDesignSystemTestApp(const CartPage()));

    expect(find.text('Design System Cart'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Order summary'),
      220,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Order summary'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('State widgets'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('State widgets'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Overlays and feedback'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Overlays and feedback'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Coupon code'),
      -300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.enterText(find.byType(TextFormField).first, 'SAVE20');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    tester.testTextInput.hide();
    await tester.pump();
    expect(find.text('SAVE20'), findsWidgets);

    await tester.scrollUntilVisible(
      find.text('Success'),
      400,
      scrollable: find.byType(Scrollable).first,
    );
    final successButton = find.widgetWithText(ElevatedButton, 'Success');
    await Scrollable.ensureVisible(
      tester.element(successButton),
      alignment: 0.35,
    );
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(successButton);
    await tester.pump();
    expect(find.text('Saved'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Alert'),
      100,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.widgetWithText(OutlinedButton, 'Alert'));
    await tester.pumpAndSettle();
    expect(find.text('Alert dialog'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Base bottom sheet'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    final baseSheetButton = find.widgetWithText(
      ElevatedButton,
      'Base bottom sheet',
    );
    await Scrollable.ensureVisible(
      tester.element(baseSheetButton),
      alignment: 0.35,
    );
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(baseSheetButton);
    await tester.pumpAndSettle();
    expect(find.text('Base bottom sheet'), findsWidgets);
    expect(find.text('Sheet body'), findsNothing);
    await tester.tapAt(const Offset(20, 20));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Action sheet'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    final actionSheetButton = find.widgetWithText(
      OutlinedButton,
      'Action sheet',
    );
    await Scrollable.ensureVisible(
      tester.element(actionSheetButton),
      alignment: 0.35,
    );
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(actionSheetButton);
    await tester.pumpAndSettle();
    expect(find.text('Apply discount'), findsOneWidget);
    await tester.tap(find.text('Apply discount'));
    await tester.pumpAndSettle();
    expect(find.text('Selected action: discount'), findsOneWidget);
  });
}
