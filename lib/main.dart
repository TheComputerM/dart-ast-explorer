import 'dart:js_interop';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:dart_ast_explorer/walker.g.dart';

@JS()
external void setAst(JSAny? tree);

void main(List<String> arguments) {
  final result = parseString(
    content: arguments.first,
    featureSet: FeatureSet.latestLanguageVersion(),
    throwIfDiagnostics: false,
  );

  setAst(convert(result.unit.declarations));
}
