// Run `dart run tool/gen_parser.dart` in project root.

import 'dart:io';
import 'dart:mirrors';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;

/// Returns a list of [ClassMirror] of objects which can be traversed in the AST
List<ClassMirror> getAstNodeClassMirrors() {
  // lifted from package:analyzer/dart/ast/ast.dart
  final classes = [
    AdjacentStrings,
    AnnotatedNode,
    Annotation,
    ArgumentList,
    AsExpression,
    AssertInitializer,
    Assertion,
    AssertStatement,
    AssignedVariablePattern,
    AssignmentExpression,
    AstNode,
    AstVisitor,
    AugmentationImportDirective,
    AugmentedExpression,
    AugmentedInvocation,
    AwaitExpression,
    BinaryExpression,
    Block,
    BlockFunctionBody,
    BooleanLiteral,
    BreakStatement,
    CascadeExpression,
    CaseClause,
    CastPattern,
    CatchClause,
    CatchClauseParameter,
    ClassDeclaration,
    ClassMember,
    ClassTypeAlias,
    CollectionElement,
    Combinator,
    Comment,
    CommentReferableExpression,
    CommentReference,
    CompilationUnit,
    CompilationUnitMember,
    CompoundAssignmentExpression,
    ConditionalExpression,
    Configuration,
    ConstantPattern,
    ConstructorDeclaration,
    ConstructorFieldInitializer,
    ConstructorInitializer,
    ConstructorName,
    ConstructorReference,
    ConstructorReferenceNode,
    ConstructorSelector,
    ContinueStatement,
    DartPattern,
    Declaration,
    DeclaredIdentifier,
    DeclaredVariablePattern,
    DefaultFormalParameter,
    Directive,
    DoStatement,
    DottedName,
    DoubleLiteral,
    EmptyFunctionBody,
    EmptyStatement,
    EnumConstantArguments,
    EnumConstantDeclaration,
    EnumDeclaration,
    ExportDirective,
    Expression,
    ExpressionFunctionBody,
    ExpressionStatement,
    ExtendsClause,
    ExtensionDeclaration,
    ExtensionOnClause,
    ExtensionOverride,
    ExtensionTypeDeclaration,
    FieldDeclaration,
    FieldFormalParameter,
    ForEachParts,
    ForEachPartsWithDeclaration,
    ForEachPartsWithIdentifier,
    ForEachPartsWithPattern,
    ForElement,
    ForLoopParts,
    FormalParameter,
    FormalParameterList,
    ForParts,
    ForPartsWithDeclarations,
    ForPartsWithExpression,
    ForPartsWithPattern,
    ForStatement,
    FunctionBody,
    FunctionDeclaration,
    FunctionDeclarationStatement,
    FunctionExpression,
    FunctionExpressionInvocation,
    FunctionReference,
    FunctionTypeAlias,
    FunctionTypedFormalParameter,
    GenericFunctionType,
    GenericTypeAlias,
    GuardedPattern,
    HideCombinator,
    Identifier,
    IfElement,
    IfStatement,
    ImplementsClause,
    ImplicitCallReference,
    ImportDirective,
    ImportPrefixReference,
    IndexExpression,
    InstanceCreationExpression,
    IntegerLiteral,
    InterpolationElement,
    InterpolationExpression,
    InterpolationString,
    InvocationExpression,
    IsExpression,
    Label,
    LabeledStatement,
    LibraryAugmentationDirective,
    LibraryDirective,
    LibraryIdentifier,
    ListLiteral,
    ListPattern,
    ListPatternElement,
    Literal,
    LogicalAndPattern,
    LogicalOrPattern,
    MapLiteralEntry,
    MapPattern,
    MapPatternElement,
    MapPatternEntry,
    MethodDeclaration,
    MethodInvocation,
    MethodReferenceExpression,
    MixinDeclaration,
    MixinOnClause,
    NamedCompilationUnitMember,
    NamedExpression,
    NamedType,
    NamespaceDirective,
    NativeClause,
    NativeFunctionBody,
    NodeList,
    NormalFormalParameter,
    NullAssertPattern,
    NullCheckPattern,
    NullLiteral,
    NullShortableExpression,
    ObjectPattern,
    ParenthesizedExpression,
    ParenthesizedPattern,
    PartDirective,
    PartOfDirective,
    PatternAssignment,
    PatternField,
    PatternFieldName,
    PatternVariableDeclaration,
    PatternVariableDeclarationStatement,
    PostfixExpression,
    PrefixedIdentifier,
    PrefixExpression,
    PropertyAccess,
    RecordLiteral,
    RecordPattern,
    RecordTypeAnnotation,
    RecordTypeAnnotationField,
    RecordTypeAnnotationNamedField,
    RecordTypeAnnotationNamedFields,
    RecordTypeAnnotationPositionalField,
    RedirectingConstructorInvocation,
    RelationalPattern,
    RepresentationConstructorName,
    RepresentationDeclaration,
    RestPatternElement,
    RethrowExpression,
    ReturnStatement,
    ScriptTag,
    SetOrMapLiteral,
    ShowCombinator,
    SimpleFormalParameter,
    SimpleIdentifier,
    SimpleStringLiteral,
    SingleStringLiteral,
    SpreadElement,
    Statement,
    StringInterpolation,
    StringLiteral,
    SuperConstructorInvocation,
    SuperExpression,
    SuperFormalParameter,
    SwitchCase,
    SwitchDefault,
    SwitchExpression,
    SwitchExpressionCase,
    SwitchMember,
    SwitchPatternCase,
    SwitchStatement,
    SymbolLiteral,
    ThisExpression,
    ThrowExpression,
    TopLevelVariableDeclaration,
    TryStatement,
    TypeAlias,
    TypeAnnotation,
    TypeArgumentList,
    TypedLiteral,
    TypeLiteral,
    TypeParameter,
    TypeParameterList,
    UriBasedDirective,
    VariableDeclaration,
    VariableDeclarationList,
    VariableDeclarationStatement,
    VariablePattern,
    WhenClause,
    WhileStatement,
    WildcardPattern,
    WithClause,
    YieldStatement
  ];

  final result = classes
      .map(reflectClass)
      .where((mirror) => mirror.isSubtypeOf(reflectType(SyntacticEntity)))
      .toList(growable: false);

  // print(currentMirrorSystem()
  //     .libraries[Uri(scheme: 'package', path: 'analyzer/dart/ast/ast.dart')]!
  //     .libraryDependencies
  //     .where((dependency) => dependency.isExport)
  //     .first
  //     .metadata
  //     .toList());

  return result;
}

/// Returns a map of object names with a list of their properties
Map<String, List<String>> getAstNodesPropertiesMap(List<ClassMirror> mirrors) {
  final deprecatedMirror = reflectType(Deprecated);

  final blacklist = {
    "CompilationUnit": {"lineInfo", "sortedDirectivesAndDeclarations"},
    "NullShortableExpression": {"nullShortingTermination"},
    "Expression": {"unParenthesized"},
    "Statement": {"unlabeled"},
    "Annotation": {"parent"}
  };

  List<String> getProperties(ClassMirror mirror) {
    final classname = MirrorSystem.getName(mirror.simpleName);

    return mirror.declarations.values
        .map((property) {
          final isDeprecated = property.metadata.any(
            (metadata) => metadata.type.isAssignableTo(deprecatedMirror),
          );
          if (property is MethodMirror && property.isGetter && !isDeprecated) {
            return MirrorSystem.getName(property.simpleName);
          }
          return null;
        })
        .whereType<String>()
        .where((name) {
          return blacklist[classname]?.contains(name) != true;
        })
        .toList(growable: false);
  }

  var result = {
    for (final mirror in mirrors)
      MirrorSystem.getName(mirror.simpleName): getProperties(mirror)
  };

  result.removeWhere((_, properties) => properties.isEmpty);
  result.remove("AstNode");

  print("Number of AST classes considered: ${result.length}");

  return result;
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

JSString _formatType(Type type) {
  var typeString = type.toString();
  if (typeString.endsWith("Impl")) {
    typeString = typeString.substring(0, typeString.length - "Impl".length);
  }
  return typeString.toJS;
}

JSAny convertObject(Object obj) {
  if (obj is bool) return obj.toJS;
  if (obj is int) return obj.toJS;
  if (obj is String) return obj.toJS;
  final jsobj = JSObject();
  jsobj['type'] = _formatType(obj.runtimeType);
  return jsobj;
}

JSArray convertList(Iterable nodeList) {
  return nodeList.map(convert).toList(growable: false).toJS;
}

JSObject convertNode(SyntacticEntity node) {
  final jsnode = JSObject();
  jsnode['type'] = _formatType(node.runtimeType);
  $addNodeProperties
  return jsnode;
}

JSAny? convert(Object? obj) {
  if (obj == null) return null;
  if (obj is Iterable) return convertList(obj);
  if (obj is SyntacticEntity) return convertNode(obj);
  return convertObject(obj);
}
""";

  final formatter = DartFormatter();
  File(p.join(
    p.dirname(Platform.script.path),
    "..",
    "lib",
    "parser.g.dart",
  )).writeAsStringSync(formatter.format(template));
}
