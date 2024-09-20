// Run `dart run tool/gen_parser.dart` in project root.

import 'dart:io';
import 'dart:mirrors';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;
import 'package:analyzer/dart/ast/visitor.dart';

final _formatter = DartFormatter();

/// Returns a list of [ClassMirror] of objects which can be traversed in the AST
List<ClassMirror> getAstNodeClassMirrors() {
  return reflectClass(SimpleAstVisitor)
      .declarations
      .values
      .map((method) {
        if (MirrorSystem.getName(method.simpleName).contains('visit') &&
            method is MethodMirror) {
          return method.parameters.first.type;
        }
        return null;
      })
      .whereType<ClassMirror>()
      .toList(growable: false);
}

/// Returns a map of object names of ast elements with a list of their properties' name
Map<String, List<String>> getAstNodesPropertiesMap(List<ClassMirror> mirrors) {
  List<String> getters(ClassMirror classmirror) {
    final deprecatedMirror = reflectType(Deprecated);
    return classmirror.declarations.values
        .map((value) {
          final isDeprecated = value.metadata.any(
            (metadata) => metadata.type.isAssignableTo(deprecatedMirror),
          );
          if (value is MethodMirror && value.isGetter && !isDeprecated) {
            return MirrorSystem.getName(value.simpleName);
          }
          return null;
        })
        .whereType<String>()
        .toList(growable: false);
  }

  return {
    for (final mirror in mirrors)
      MirrorSystem.getName(mirror.simpleName): getters(mirror)
  };
}

void main() {
  final astNodesProperties = getAstNodesPropertiesMap(getAstNodeClassMirrors());

  final addNodeProperties = astNodesProperties.entries
      .map((node) {
        return """
        if (node is ${node.key}) {
          ${node.value.map((property) => "jsnode['$property'] = convert(node.$property)").join(";\n")};
        }
        """;
      })
      .whereType<String>()
      .join('\n');

  final template = """
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';

JSObject convertObject(Object obj) {
  final jsobj = JSObject();
  jsobj['string'] = obj.toString().toJS;
  jsobj['type'] = obj.runtimeType.toString().toJS;
  return jsobj;
}

JSObject convertList(Iterable nodeList) {
  return nodeList.map(convert).toList(growable: false).toJS;
}

JSObject convertNode(SyntacticEntity node) {
  final jsnode = convertObject(node);
  $addNodeProperties
  return jsnode;
}

JSObject? convert(Object? obj) {
  if (obj == null) return null;
  if (obj is Iterable) return convertList(obj);
  if (obj is SyntacticEntity) return convertNode(obj);
  return convertObject(obj);
}
""";

  File(p.join(
    p.dirname(Platform.script.path),
    "..",
    "lib",
    "parser.g.dart",
  )).writeAsStringSync(_formatter.format(template));
}
