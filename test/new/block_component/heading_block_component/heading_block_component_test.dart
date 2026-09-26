import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../infra/testable_editor.dart';

void main() {
  group('heading block component', () {
    testWidgets('uses the default font size for each heading level',
        (tester) async {
      final editor = tester.editor;
      for (var level = 1; level <= 6; level++) {
        editor.addNode(headingNode(level: level, text: 'Heading $level'));
      }
      await editor.startTesting();

      const fontSizes = [32.0, 28.0, 24.0, 18.0, 18.0, 18.0];
      for (var level = 1; level <= fontSizes.length; level++) {
        final richText = tester.widget<RichText>(
          find.descendant(
            of: find.byType(AppFlowyRichText).at(level - 1),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is RichText &&
                  widget.text.toPlainText() == 'Heading $level',
            ),
          ),
        );
        final textSpan = richText.text as TextSpan;
        final headingSpan = textSpan.children!.single as TextSpan;

        expect(headingSpan.style?.fontSize, fontSizes[level - 1]);
      }

      await editor.dispose();
    });
  });
}
