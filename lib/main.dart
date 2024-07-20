import 'dart:js_interop';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

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
  external String source;
  external int start;
  external int end;

  external AstTreeNode findChild(int id);
}

extension type AstTreeBuilder._(JSObject _) implements JSObject {
  external AstTreeBuilder();
  external AstTreeNode rootNode;

  external void enterNode(AstTreeNode node);
  external void exitNode();
}

@JS('tree')
external AstTreeBuilder get tree;

class AstTreeVisitor extends UnifyingAstVisitor<void> {
  @override
  void visitNode(AstNode node) {
    // create a AST tree node that is connected to JS
    var treeNode = AstTreeNode(
      node.hashCode,
      node.runtimeType.toString(),
      node.toSource(),
      node.offset,
      node.end,
    );

    // Add the node to the tree
    tree.enterNode(treeNode);

    super.visitNode(node);

    // Exit the node so, this helps in determining the current parent node
    tree.exitNode();
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
