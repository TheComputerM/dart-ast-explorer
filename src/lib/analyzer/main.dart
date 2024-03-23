import 'dart:js_interop';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/src/dart/ast/ast.dart';

extension type AstTreeNode._(JSObject _) implements JSObject {
  external AstTreeNode(
    int id,
    String type,
    String source,
    int start,
    int end,
  );
  external int id;
  external String type;

  external AstTreeNode findChild(int id);
}

extension type AstTreeBuilder._(JSObject _) implements JSObject {
  external AstTreeBuilder();
  external AstTreeNode rootNode;

  external void visitNode(AstTreeNode node);
  external void popNode();
}

@JS('tree')
external AstTreeBuilder get tree;

class AstTreeVisitor extends UnifyingAstVisitor<void> {
  @override
  void visitNode(AstNode node) {
    var treeNode = AstTreeNode(
      node.hashCode,
      node.runtimeType.toString(),
      node.toSource(),
      node.offset,
      node.end,
    );

    tree.visitNode(treeNode);

    super.visitNode(node);
    tree.popNode();
  }
}

void main(List<String> arguments) {
  final result = parseString(
    content: arguments.first,
    featureSet: FeatureSet.latestLanguageVersion(),
    throwIfDiagnostics: false,
  );

  result.unit.visitChildren(AstTreeVisitor());
}
