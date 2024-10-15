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
  if (node is AdjacentStrings) {
    jsnode['strings'] = convert(node.strings);
  }

  if (node is AnnotatedNode) {
    jsnode['documentationComment'] = convert(node.documentationComment);
    jsnode['firstTokenAfterCommentAndMetadata'] =
        convert(node.firstTokenAfterCommentAndMetadata);
    jsnode['metadata'] = convert(node.metadata);
    jsnode['sortedCommentAndAnnotations'] =
        convert(node.sortedCommentAndAnnotations);
  }

  if (node is Annotation) {
    jsnode['arguments'] = convert(node.arguments);
    jsnode['atSign'] = convert(node.atSign);
    jsnode['constructorName'] = convert(node.constructorName);
    jsnode['element'] = convert(node.element);
    jsnode['elementAnnotation'] = convert(node.elementAnnotation);
    jsnode['name'] = convert(node.name);
    jsnode['period'] = convert(node.period);
    jsnode['typeArguments'] = convert(node.typeArguments);
  }

  if (node is ArgumentList) {
    jsnode['arguments'] = convert(node.arguments);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
  }

  if (node is AsExpression) {
    jsnode['asOperator'] = convert(node.asOperator);
    jsnode['expression'] = convert(node.expression);
    jsnode['type'] = convert(node.type);
  }

  if (node is Assertion) {
    jsnode['assertKeyword'] = convert(node.assertKeyword);
    jsnode['comma'] = convert(node.comma);
    jsnode['condition'] = convert(node.condition);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['message'] = convert(node.message);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
  }

  if (node is AssertStatement) {
    jsnode['semicolon'] = convert(node.semicolon);
  }

  if (node is AssignedVariablePattern) {
    jsnode['element'] = convert(node.element);
  }

  if (node is AssignmentExpression) {
    jsnode['leftHandSide'] = convert(node.leftHandSide);
    jsnode['operator'] = convert(node.operator);
    jsnode['rightHandSide'] = convert(node.rightHandSide);
  }

  if (node is AugmentationImportDirective) {
    jsnode['augmentKeyword'] = convert(node.augmentKeyword);
    jsnode['element'] = convert(node.element);
    jsnode['importKeyword'] = convert(node.importKeyword);
    jsnode['semicolon'] = convert(node.semicolon);
  }

  if (node is AugmentedExpression) {
    jsnode['augmentedKeyword'] = convert(node.augmentedKeyword);
    jsnode['element'] = convert(node.element);
  }

  if (node is AugmentedInvocation) {
    jsnode['arguments'] = convert(node.arguments);
    jsnode['augmentedKeyword'] = convert(node.augmentedKeyword);
    jsnode['element'] = convert(node.element);
    jsnode['typeArguments'] = convert(node.typeArguments);
  }

  if (node is AwaitExpression) {
    jsnode['awaitKeyword'] = convert(node.awaitKeyword);
    jsnode['expression'] = convert(node.expression);
  }

  if (node is BinaryExpression) {
    jsnode['leftOperand'] = convert(node.leftOperand);
    jsnode['operator'] = convert(node.operator);
    jsnode['rightOperand'] = convert(node.rightOperand);
    jsnode['staticInvokeType'] = convert(node.staticInvokeType);
  }

  if (node is Block) {
    jsnode['leftBracket'] = convert(node.leftBracket);
    jsnode['rightBracket'] = convert(node.rightBracket);
    jsnode['statements'] = convert(node.statements);
  }

  if (node is BlockFunctionBody) {
    jsnode['block'] = convert(node.block);
  }

  if (node is BooleanLiteral) {
    jsnode['literal'] = convert(node.literal);
    jsnode['value'] = convert(node.value);
  }

  if (node is BreakStatement) {
    jsnode['breakKeyword'] = convert(node.breakKeyword);
    jsnode['label'] = convert(node.label);
    jsnode['semicolon'] = convert(node.semicolon);
    jsnode['target'] = convert(node.target);
  }

  if (node is CascadeExpression) {
    jsnode['cascadeSections'] = convert(node.cascadeSections);
    jsnode['isNullAware'] = convert(node.isNullAware);
    jsnode['target'] = convert(node.target);
  }

  if (node is CaseClause) {
    jsnode['caseKeyword'] = convert(node.caseKeyword);
    jsnode['guardedPattern'] = convert(node.guardedPattern);
  }

  if (node is CastPattern) {
    jsnode['asToken'] = convert(node.asToken);
    jsnode['pattern'] = convert(node.pattern);
    jsnode['type'] = convert(node.type);
  }

  if (node is CatchClause) {
    jsnode['body'] = convert(node.body);
    jsnode['catchKeyword'] = convert(node.catchKeyword);
    jsnode['comma'] = convert(node.comma);
    jsnode['exceptionParameter'] = convert(node.exceptionParameter);
    jsnode['exceptionType'] = convert(node.exceptionType);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['onKeyword'] = convert(node.onKeyword);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
    jsnode['stackTraceParameter'] = convert(node.stackTraceParameter);
  }

  if (node is CatchClauseParameter) {
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['name'] = convert(node.name);
  }

  if (node is ClassDeclaration) {
    jsnode['abstractKeyword'] = convert(node.abstractKeyword);
    jsnode['augmentKeyword'] = convert(node.augmentKeyword);
    jsnode['baseKeyword'] = convert(node.baseKeyword);
    jsnode['classKeyword'] = convert(node.classKeyword);
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['extendsClause'] = convert(node.extendsClause);
    jsnode['finalKeyword'] = convert(node.finalKeyword);
    jsnode['implementsClause'] = convert(node.implementsClause);
    jsnode['interfaceKeyword'] = convert(node.interfaceKeyword);
    jsnode['leftBracket'] = convert(node.leftBracket);
    jsnode['macroKeyword'] = convert(node.macroKeyword);
    jsnode['members'] = convert(node.members);
    jsnode['mixinKeyword'] = convert(node.mixinKeyword);
    jsnode['nativeClause'] = convert(node.nativeClause);
    jsnode['rightBracket'] = convert(node.rightBracket);
    jsnode['sealedKeyword'] = convert(node.sealedKeyword);
    jsnode['typeParameters'] = convert(node.typeParameters);
    jsnode['withClause'] = convert(node.withClause);
  }

  if (node is ClassTypeAlias) {
    jsnode['abstractKeyword'] = convert(node.abstractKeyword);
    jsnode['baseKeyword'] = convert(node.baseKeyword);
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['equals'] = convert(node.equals);
    jsnode['finalKeyword'] = convert(node.finalKeyword);
    jsnode['implementsClause'] = convert(node.implementsClause);
    jsnode['interfaceKeyword'] = convert(node.interfaceKeyword);
    jsnode['mixinKeyword'] = convert(node.mixinKeyword);
    jsnode['sealedKeyword'] = convert(node.sealedKeyword);
    jsnode['superclass'] = convert(node.superclass);
    jsnode['typeParameters'] = convert(node.typeParameters);
    jsnode['withClause'] = convert(node.withClause);
  }

  if (node is Combinator) {
    jsnode['keyword'] = convert(node.keyword);
  }

  if (node is Comment) {
    jsnode['codeBlocks'] = convert(node.codeBlocks);
    jsnode['docDirectives'] = convert(node.docDirectives);
    jsnode['docImports'] = convert(node.docImports);
    jsnode['hasNodoc'] = convert(node.hasNodoc);
    jsnode['references'] = convert(node.references);
    jsnode['tokens'] = convert(node.tokens);
  }

  if (node is CommentReference) {
    jsnode['expression'] = convert(node.expression);
    jsnode['newKeyword'] = convert(node.newKeyword);
  }

  if (node is CompilationUnit) {
    jsnode['beginToken'] = convert(node.beginToken);
    jsnode['declarations'] = convert(node.declarations);
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['directives'] = convert(node.directives);
    jsnode['endToken'] = convert(node.endToken);
    jsnode['featureSet'] = convert(node.featureSet);
    jsnode['languageVersionToken'] = convert(node.languageVersionToken);
    jsnode['scriptTag'] = convert(node.scriptTag);
  }

  if (node is CompoundAssignmentExpression) {
    jsnode['readElement'] = convert(node.readElement);
    jsnode['readType'] = convert(node.readType);
    jsnode['writeElement'] = convert(node.writeElement);
    jsnode['writeType'] = convert(node.writeType);
  }

  if (node is ConditionalExpression) {
    jsnode['colon'] = convert(node.colon);
    jsnode['condition'] = convert(node.condition);
    jsnode['elseExpression'] = convert(node.elseExpression);
    jsnode['question'] = convert(node.question);
    jsnode['thenExpression'] = convert(node.thenExpression);
  }

  if (node is Configuration) {
    jsnode['equalToken'] = convert(node.equalToken);
    jsnode['ifKeyword'] = convert(node.ifKeyword);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['name'] = convert(node.name);
    jsnode['resolvedUri'] = convert(node.resolvedUri);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
    jsnode['uri'] = convert(node.uri);
    jsnode['value'] = convert(node.value);
  }

  if (node is ConstantPattern) {
    jsnode['constKeyword'] = convert(node.constKeyword);
    jsnode['expression'] = convert(node.expression);
  }

  if (node is ConstructorDeclaration) {
    jsnode['augmentKeyword'] = convert(node.augmentKeyword);
    jsnode['body'] = convert(node.body);
    jsnode['constKeyword'] = convert(node.constKeyword);
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['externalKeyword'] = convert(node.externalKeyword);
    jsnode['factoryKeyword'] = convert(node.factoryKeyword);
    jsnode['initializers'] = convert(node.initializers);
    jsnode['name'] = convert(node.name);
    jsnode['parameters'] = convert(node.parameters);
    jsnode['period'] = convert(node.period);
    jsnode['redirectedConstructor'] = convert(node.redirectedConstructor);
    jsnode['returnType'] = convert(node.returnType);
    jsnode['separator'] = convert(node.separator);
  }

  if (node is ConstructorFieldInitializer) {
    jsnode['equals'] = convert(node.equals);
    jsnode['expression'] = convert(node.expression);
    jsnode['fieldName'] = convert(node.fieldName);
    jsnode['period'] = convert(node.period);
    jsnode['thisKeyword'] = convert(node.thisKeyword);
  }

  if (node is ConstructorName) {
    jsnode['name'] = convert(node.name);
    jsnode['period'] = convert(node.period);
    jsnode['type'] = convert(node.type);
  }

  if (node is ConstructorReference) {
    jsnode['constructorName'] = convert(node.constructorName);
  }

  if (node is ConstructorReferenceNode) {
    jsnode['staticElement'] = convert(node.staticElement);
  }

  if (node is ConstructorSelector) {
    jsnode['name'] = convert(node.name);
    jsnode['period'] = convert(node.period);
  }

  if (node is ContinueStatement) {
    jsnode['continueKeyword'] = convert(node.continueKeyword);
    jsnode['label'] = convert(node.label);
    jsnode['semicolon'] = convert(node.semicolon);
    jsnode['target'] = convert(node.target);
  }

  if (node is DartPattern) {
    jsnode['matchedValueType'] = convert(node.matchedValueType);
    jsnode['precedence'] = convert(node.precedence);
    jsnode['unParenthesized'] = convert(node.unParenthesized);
  }

  if (node is Declaration) {
    jsnode['declaredElement'] = convert(node.declaredElement);
  }

  if (node is DeclaredIdentifier) {
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['isConst'] = convert(node.isConst);
    jsnode['isFinal'] = convert(node.isFinal);
    jsnode['keyword'] = convert(node.keyword);
    jsnode['name'] = convert(node.name);
    jsnode['type'] = convert(node.type);
  }

  if (node is DeclaredVariablePattern) {
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['keyword'] = convert(node.keyword);
    jsnode['type'] = convert(node.type);
  }

  if (node is DefaultFormalParameter) {
    jsnode['defaultValue'] = convert(node.defaultValue);
    jsnode['parameter'] = convert(node.parameter);
    jsnode['separator'] = convert(node.separator);
  }

  if (node is Directive) {
    jsnode['element'] = convert(node.element);
  }

  if (node is DoStatement) {
    jsnode['body'] = convert(node.body);
    jsnode['condition'] = convert(node.condition);
    jsnode['doKeyword'] = convert(node.doKeyword);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
    jsnode['semicolon'] = convert(node.semicolon);
    jsnode['whileKeyword'] = convert(node.whileKeyword);
  }

  if (node is DottedName) {
    jsnode['components'] = convert(node.components);
  }

  if (node is DoubleLiteral) {
    jsnode['literal'] = convert(node.literal);
    jsnode['value'] = convert(node.value);
  }

  if (node is EmptyFunctionBody) {
    jsnode['semicolon'] = convert(node.semicolon);
  }

  if (node is EmptyStatement) {
    jsnode['semicolon'] = convert(node.semicolon);
  }

  if (node is EnumConstantArguments) {
    jsnode['argumentList'] = convert(node.argumentList);
    jsnode['constructorSelector'] = convert(node.constructorSelector);
    jsnode['typeArguments'] = convert(node.typeArguments);
  }

  if (node is EnumConstantDeclaration) {
    jsnode['arguments'] = convert(node.arguments);
    jsnode['augmentKeyword'] = convert(node.augmentKeyword);
    jsnode['constructorElement'] = convert(node.constructorElement);
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['name'] = convert(node.name);
  }

  if (node is EnumDeclaration) {
    jsnode['augmentKeyword'] = convert(node.augmentKeyword);
    jsnode['constants'] = convert(node.constants);
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['enumKeyword'] = convert(node.enumKeyword);
    jsnode['implementsClause'] = convert(node.implementsClause);
    jsnode['leftBracket'] = convert(node.leftBracket);
    jsnode['members'] = convert(node.members);
    jsnode['rightBracket'] = convert(node.rightBracket);
    jsnode['semicolon'] = convert(node.semicolon);
    jsnode['typeParameters'] = convert(node.typeParameters);
    jsnode['withClause'] = convert(node.withClause);
  }

  if (node is ExportDirective) {
    jsnode['element'] = convert(node.element);
    jsnode['exportKeyword'] = convert(node.exportKeyword);
  }

  if (node is Expression) {
    jsnode['inConstantContext'] = convert(node.inConstantContext);
    jsnode['isAssignable'] = convert(node.isAssignable);
    jsnode['precedence'] = convert(node.precedence);
    jsnode['staticParameterElement'] = convert(node.staticParameterElement);
    jsnode['staticType'] = convert(node.staticType);
  }

  if (node is ExpressionFunctionBody) {
    jsnode['expression'] = convert(node.expression);
    jsnode['functionDefinition'] = convert(node.functionDefinition);
    jsnode['keyword'] = convert(node.keyword);
    jsnode['semicolon'] = convert(node.semicolon);
    jsnode['star'] = convert(node.star);
  }

  if (node is ExpressionStatement) {
    jsnode['expression'] = convert(node.expression);
    jsnode['semicolon'] = convert(node.semicolon);
  }

  if (node is ExtendsClause) {
    jsnode['extendsKeyword'] = convert(node.extendsKeyword);
    jsnode['superclass'] = convert(node.superclass);
  }

  if (node is ExtensionDeclaration) {
    jsnode['augmentKeyword'] = convert(node.augmentKeyword);
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['extensionKeyword'] = convert(node.extensionKeyword);
    jsnode['leftBracket'] = convert(node.leftBracket);
    jsnode['members'] = convert(node.members);
    jsnode['name'] = convert(node.name);
    jsnode['onClause'] = convert(node.onClause);
    jsnode['rightBracket'] = convert(node.rightBracket);
    jsnode['typeKeyword'] = convert(node.typeKeyword);
    jsnode['typeParameters'] = convert(node.typeParameters);
  }

  if (node is ExtensionOnClause) {
    jsnode['extendedType'] = convert(node.extendedType);
    jsnode['onKeyword'] = convert(node.onKeyword);
  }

  if (node is ExtensionOverride) {
    jsnode['argumentList'] = convert(node.argumentList);
    jsnode['element'] = convert(node.element);
    jsnode['extendedType'] = convert(node.extendedType);
    jsnode['importPrefix'] = convert(node.importPrefix);
    jsnode['isNullAware'] = convert(node.isNullAware);
    jsnode['name'] = convert(node.name);
    jsnode['typeArguments'] = convert(node.typeArguments);
    jsnode['typeArgumentTypes'] = convert(node.typeArgumentTypes);
  }

  if (node is ExtensionTypeDeclaration) {
    jsnode['augmentKeyword'] = convert(node.augmentKeyword);
    jsnode['constKeyword'] = convert(node.constKeyword);
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['extensionKeyword'] = convert(node.extensionKeyword);
    jsnode['implementsClause'] = convert(node.implementsClause);
    jsnode['leftBracket'] = convert(node.leftBracket);
    jsnode['members'] = convert(node.members);
    jsnode['representation'] = convert(node.representation);
    jsnode['rightBracket'] = convert(node.rightBracket);
    jsnode['typeKeyword'] = convert(node.typeKeyword);
    jsnode['typeParameters'] = convert(node.typeParameters);
  }

  if (node is FieldDeclaration) {
    jsnode['abstractKeyword'] = convert(node.abstractKeyword);
    jsnode['augmentKeyword'] = convert(node.augmentKeyword);
    jsnode['covariantKeyword'] = convert(node.covariantKeyword);
    jsnode['externalKeyword'] = convert(node.externalKeyword);
    jsnode['fields'] = convert(node.fields);
    jsnode['isStatic'] = convert(node.isStatic);
    jsnode['semicolon'] = convert(node.semicolon);
    jsnode['staticKeyword'] = convert(node.staticKeyword);
  }

  if (node is FieldFormalParameter) {
    jsnode['keyword'] = convert(node.keyword);
    jsnode['name'] = convert(node.name);
    jsnode['parameters'] = convert(node.parameters);
    jsnode['period'] = convert(node.period);
    jsnode['question'] = convert(node.question);
    jsnode['thisKeyword'] = convert(node.thisKeyword);
    jsnode['type'] = convert(node.type);
    jsnode['typeParameters'] = convert(node.typeParameters);
  }

  if (node is ForEachParts) {
    jsnode['inKeyword'] = convert(node.inKeyword);
    jsnode['iterable'] = convert(node.iterable);
  }

  if (node is ForEachPartsWithDeclaration) {
    jsnode['loopVariable'] = convert(node.loopVariable);
  }

  if (node is ForEachPartsWithIdentifier) {
    jsnode['identifier'] = convert(node.identifier);
  }

  if (node is ForEachPartsWithPattern) {
    jsnode['keyword'] = convert(node.keyword);
    jsnode['metadata'] = convert(node.metadata);
    jsnode['pattern'] = convert(node.pattern);
  }

  if (node is ForElement) {
    jsnode['awaitKeyword'] = convert(node.awaitKeyword);
    jsnode['body'] = convert(node.body);
    jsnode['forKeyword'] = convert(node.forKeyword);
    jsnode['forLoopParts'] = convert(node.forLoopParts);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
  }

  if (node is FormalParameter) {
    jsnode['covariantKeyword'] = convert(node.covariantKeyword);
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['isConst'] = convert(node.isConst);
    jsnode['isExplicitlyTyped'] = convert(node.isExplicitlyTyped);
    jsnode['isFinal'] = convert(node.isFinal);
    jsnode['isNamed'] = convert(node.isNamed);
    jsnode['isOptional'] = convert(node.isOptional);
    jsnode['isOptionalNamed'] = convert(node.isOptionalNamed);
    jsnode['isOptionalPositional'] = convert(node.isOptionalPositional);
    jsnode['isPositional'] = convert(node.isPositional);
    jsnode['isRequired'] = convert(node.isRequired);
    jsnode['isRequiredNamed'] = convert(node.isRequiredNamed);
    jsnode['isRequiredPositional'] = convert(node.isRequiredPositional);
    jsnode['metadata'] = convert(node.metadata);
    jsnode['name'] = convert(node.name);
    jsnode['requiredKeyword'] = convert(node.requiredKeyword);
  }

  if (node is FormalParameterList) {
    jsnode['leftDelimiter'] = convert(node.leftDelimiter);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['parameterElements'] = convert(node.parameterElements);
    jsnode['parameters'] = convert(node.parameters);
    jsnode['rightDelimiter'] = convert(node.rightDelimiter);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
  }

  if (node is ForParts) {
    jsnode['condition'] = convert(node.condition);
    jsnode['leftSeparator'] = convert(node.leftSeparator);
    jsnode['rightSeparator'] = convert(node.rightSeparator);
    jsnode['updaters'] = convert(node.updaters);
  }

  if (node is ForPartsWithDeclarations) {
    jsnode['variables'] = convert(node.variables);
  }

  if (node is ForPartsWithExpression) {
    jsnode['initialization'] = convert(node.initialization);
  }

  if (node is ForPartsWithPattern) {
    jsnode['variables'] = convert(node.variables);
  }

  if (node is ForStatement) {
    jsnode['awaitKeyword'] = convert(node.awaitKeyword);
    jsnode['body'] = convert(node.body);
    jsnode['forKeyword'] = convert(node.forKeyword);
    jsnode['forLoopParts'] = convert(node.forLoopParts);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
  }

  if (node is FunctionBody) {
    jsnode['isAsynchronous'] = convert(node.isAsynchronous);
    jsnode['isGenerator'] = convert(node.isGenerator);
    jsnode['isSynchronous'] = convert(node.isSynchronous);
    jsnode['keyword'] = convert(node.keyword);
    jsnode['star'] = convert(node.star);
  }

  if (node is FunctionDeclaration) {
    jsnode['augmentKeyword'] = convert(node.augmentKeyword);
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['externalKeyword'] = convert(node.externalKeyword);
    jsnode['functionExpression'] = convert(node.functionExpression);
    jsnode['isGetter'] = convert(node.isGetter);
    jsnode['isSetter'] = convert(node.isSetter);
    jsnode['propertyKeyword'] = convert(node.propertyKeyword);
    jsnode['returnType'] = convert(node.returnType);
  }

  if (node is FunctionDeclarationStatement) {
    jsnode['functionDeclaration'] = convert(node.functionDeclaration);
  }

  if (node is FunctionExpression) {
    jsnode['body'] = convert(node.body);
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['parameters'] = convert(node.parameters);
    jsnode['typeParameters'] = convert(node.typeParameters);
  }

  if (node is FunctionExpressionInvocation) {
    jsnode['function'] = convert(node.function);
    jsnode['staticElement'] = convert(node.staticElement);
  }

  if (node is FunctionReference) {
    jsnode['function'] = convert(node.function);
    jsnode['typeArguments'] = convert(node.typeArguments);
    jsnode['typeArgumentTypes'] = convert(node.typeArgumentTypes);
  }

  if (node is FunctionTypeAlias) {
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['parameters'] = convert(node.parameters);
    jsnode['returnType'] = convert(node.returnType);
    jsnode['typeParameters'] = convert(node.typeParameters);
  }

  if (node is FunctionTypedFormalParameter) {
    jsnode['name'] = convert(node.name);
    jsnode['parameters'] = convert(node.parameters);
    jsnode['question'] = convert(node.question);
    jsnode['returnType'] = convert(node.returnType);
    jsnode['typeParameters'] = convert(node.typeParameters);
  }

  if (node is GenericFunctionType) {
    jsnode['functionKeyword'] = convert(node.functionKeyword);
    jsnode['parameters'] = convert(node.parameters);
    jsnode['returnType'] = convert(node.returnType);
    jsnode['typeParameters'] = convert(node.typeParameters);
  }

  if (node is GenericTypeAlias) {
    jsnode['equals'] = convert(node.equals);
    jsnode['functionType'] = convert(node.functionType);
    jsnode['type'] = convert(node.type);
    jsnode['typeParameters'] = convert(node.typeParameters);
  }

  if (node is GuardedPattern) {
    jsnode['pattern'] = convert(node.pattern);
    jsnode['whenClause'] = convert(node.whenClause);
  }

  if (node is HideCombinator) {
    jsnode['hiddenNames'] = convert(node.hiddenNames);
  }

  if (node is Identifier) {
    jsnode['name'] = convert(node.name);
    jsnode['staticElement'] = convert(node.staticElement);
  }

  if (node is IfElement) {
    jsnode['caseClause'] = convert(node.caseClause);
    jsnode['elseElement'] = convert(node.elseElement);
    jsnode['elseKeyword'] = convert(node.elseKeyword);
    jsnode['expression'] = convert(node.expression);
    jsnode['ifKeyword'] = convert(node.ifKeyword);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
    jsnode['thenElement'] = convert(node.thenElement);
  }

  if (node is IfStatement) {
    jsnode['caseClause'] = convert(node.caseClause);
    jsnode['elseKeyword'] = convert(node.elseKeyword);
    jsnode['elseStatement'] = convert(node.elseStatement);
    jsnode['expression'] = convert(node.expression);
    jsnode['ifKeyword'] = convert(node.ifKeyword);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
    jsnode['thenStatement'] = convert(node.thenStatement);
  }

  if (node is ImplementsClause) {
    jsnode['implementsKeyword'] = convert(node.implementsKeyword);
    jsnode['interfaces'] = convert(node.interfaces);
  }

  if (node is ImplicitCallReference) {
    jsnode['expression'] = convert(node.expression);
    jsnode['staticElement'] = convert(node.staticElement);
    jsnode['typeArguments'] = convert(node.typeArguments);
    jsnode['typeArgumentTypes'] = convert(node.typeArgumentTypes);
  }

  if (node is ImportDirective) {
    jsnode['asKeyword'] = convert(node.asKeyword);
    jsnode['deferredKeyword'] = convert(node.deferredKeyword);
    jsnode['element'] = convert(node.element);
    jsnode['importKeyword'] = convert(node.importKeyword);
    jsnode['prefix'] = convert(node.prefix);
  }

  if (node is ImportPrefixReference) {
    jsnode['element'] = convert(node.element);
    jsnode['name'] = convert(node.name);
    jsnode['period'] = convert(node.period);
  }

  if (node is IndexExpression) {
    jsnode['index'] = convert(node.index);
    jsnode['isCascaded'] = convert(node.isCascaded);
    jsnode['isNullAware'] = convert(node.isNullAware);
    jsnode['leftBracket'] = convert(node.leftBracket);
    jsnode['period'] = convert(node.period);
    jsnode['question'] = convert(node.question);
    jsnode['realTarget'] = convert(node.realTarget);
    jsnode['rightBracket'] = convert(node.rightBracket);
    jsnode['target'] = convert(node.target);
  }

  if (node is InstanceCreationExpression) {
    jsnode['argumentList'] = convert(node.argumentList);
    jsnode['constructorName'] = convert(node.constructorName);
    jsnode['isConst'] = convert(node.isConst);
    jsnode['keyword'] = convert(node.keyword);
  }

  if (node is IntegerLiteral) {
    jsnode['literal'] = convert(node.literal);
    jsnode['value'] = convert(node.value);
  }

  if (node is InterpolationExpression) {
    jsnode['expression'] = convert(node.expression);
    jsnode['leftBracket'] = convert(node.leftBracket);
    jsnode['rightBracket'] = convert(node.rightBracket);
  }

  if (node is InterpolationString) {
    jsnode['contents'] = convert(node.contents);
    jsnode['contentsEnd'] = convert(node.contentsEnd);
    jsnode['contentsOffset'] = convert(node.contentsOffset);
    jsnode['value'] = convert(node.value);
  }

  if (node is InvocationExpression) {
    jsnode['argumentList'] = convert(node.argumentList);
    jsnode['function'] = convert(node.function);
    jsnode['staticInvokeType'] = convert(node.staticInvokeType);
    jsnode['typeArguments'] = convert(node.typeArguments);
    jsnode['typeArgumentTypes'] = convert(node.typeArgumentTypes);
  }

  if (node is IsExpression) {
    jsnode['expression'] = convert(node.expression);
    jsnode['isOperator'] = convert(node.isOperator);
    jsnode['notOperator'] = convert(node.notOperator);
    jsnode['type'] = convert(node.type);
  }

  if (node is Label) {
    jsnode['colon'] = convert(node.colon);
    jsnode['label'] = convert(node.label);
  }

  if (node is LabeledStatement) {
    jsnode['labels'] = convert(node.labels);
    jsnode['statement'] = convert(node.statement);
  }

  if (node is LibraryAugmentationDirective) {
    jsnode['augmentKeyword'] = convert(node.augmentKeyword);
    jsnode['libraryKeyword'] = convert(node.libraryKeyword);
    jsnode['semicolon'] = convert(node.semicolon);
  }

  if (node is LibraryDirective) {
    jsnode['element'] = convert(node.element);
    jsnode['libraryKeyword'] = convert(node.libraryKeyword);
    jsnode['name2'] = convert(node.name2);
    jsnode['semicolon'] = convert(node.semicolon);
  }

  if (node is LibraryIdentifier) {
    jsnode['components'] = convert(node.components);
  }

  if (node is ListLiteral) {
    jsnode['elements'] = convert(node.elements);
    jsnode['leftBracket'] = convert(node.leftBracket);
    jsnode['rightBracket'] = convert(node.rightBracket);
  }

  if (node is ListPattern) {
    jsnode['elements'] = convert(node.elements);
    jsnode['leftBracket'] = convert(node.leftBracket);
    jsnode['requiredType'] = convert(node.requiredType);
    jsnode['rightBracket'] = convert(node.rightBracket);
    jsnode['typeArguments'] = convert(node.typeArguments);
  }

  if (node is LogicalAndPattern) {
    jsnode['leftOperand'] = convert(node.leftOperand);
    jsnode['operator'] = convert(node.operator);
    jsnode['rightOperand'] = convert(node.rightOperand);
  }

  if (node is LogicalOrPattern) {
    jsnode['leftOperand'] = convert(node.leftOperand);
    jsnode['operator'] = convert(node.operator);
    jsnode['rightOperand'] = convert(node.rightOperand);
  }

  if (node is MapLiteralEntry) {
    jsnode['key'] = convert(node.key);
    jsnode['separator'] = convert(node.separator);
    jsnode['value'] = convert(node.value);
  }

  if (node is MapPattern) {
    jsnode['elements'] = convert(node.elements);
    jsnode['leftBracket'] = convert(node.leftBracket);
    jsnode['requiredType'] = convert(node.requiredType);
    jsnode['rightBracket'] = convert(node.rightBracket);
    jsnode['typeArguments'] = convert(node.typeArguments);
  }

  if (node is MapPatternEntry) {
    jsnode['key'] = convert(node.key);
    jsnode['separator'] = convert(node.separator);
    jsnode['value'] = convert(node.value);
  }

  if (node is MethodDeclaration) {
    jsnode['augmentKeyword'] = convert(node.augmentKeyword);
    jsnode['body'] = convert(node.body);
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['externalKeyword'] = convert(node.externalKeyword);
    jsnode['isAbstract'] = convert(node.isAbstract);
    jsnode['isGetter'] = convert(node.isGetter);
    jsnode['isOperator'] = convert(node.isOperator);
    jsnode['isSetter'] = convert(node.isSetter);
    jsnode['isStatic'] = convert(node.isStatic);
    jsnode['modifierKeyword'] = convert(node.modifierKeyword);
    jsnode['name'] = convert(node.name);
    jsnode['operatorKeyword'] = convert(node.operatorKeyword);
    jsnode['parameters'] = convert(node.parameters);
    jsnode['propertyKeyword'] = convert(node.propertyKeyword);
    jsnode['returnType'] = convert(node.returnType);
    jsnode['typeParameters'] = convert(node.typeParameters);
  }

  if (node is MethodInvocation) {
    jsnode['isCascaded'] = convert(node.isCascaded);
    jsnode['isNullAware'] = convert(node.isNullAware);
    jsnode['methodName'] = convert(node.methodName);
    jsnode['operator'] = convert(node.operator);
    jsnode['realTarget'] = convert(node.realTarget);
    jsnode['target'] = convert(node.target);
  }

  if (node is MethodReferenceExpression) {
    jsnode['staticElement'] = convert(node.staticElement);
  }

  if (node is MixinDeclaration) {
    jsnode['augmentKeyword'] = convert(node.augmentKeyword);
    jsnode['baseKeyword'] = convert(node.baseKeyword);
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['implementsClause'] = convert(node.implementsClause);
    jsnode['leftBracket'] = convert(node.leftBracket);
    jsnode['members'] = convert(node.members);
    jsnode['mixinKeyword'] = convert(node.mixinKeyword);
    jsnode['onClause'] = convert(node.onClause);
    jsnode['rightBracket'] = convert(node.rightBracket);
    jsnode['typeParameters'] = convert(node.typeParameters);
  }

  if (node is MixinOnClause) {
    jsnode['onKeyword'] = convert(node.onKeyword);
    jsnode['superclassConstraints'] = convert(node.superclassConstraints);
  }

  if (node is NamedCompilationUnitMember) {
    jsnode['name'] = convert(node.name);
  }

  if (node is NamedExpression) {
    jsnode['element'] = convert(node.element);
    jsnode['expression'] = convert(node.expression);
    jsnode['name'] = convert(node.name);
  }

  if (node is NamedType) {
    jsnode['element'] = convert(node.element);
    jsnode['importPrefix'] = convert(node.importPrefix);
    jsnode['isDeferred'] = convert(node.isDeferred);
    jsnode['name2'] = convert(node.name2);
    jsnode['type'] = convert(node.type);
    jsnode['typeArguments'] = convert(node.typeArguments);
  }

  if (node is NamespaceDirective) {
    jsnode['combinators'] = convert(node.combinators);
    jsnode['configurations'] = convert(node.configurations);
    jsnode['semicolon'] = convert(node.semicolon);
  }

  if (node is NativeClause) {
    jsnode['name'] = convert(node.name);
    jsnode['nativeKeyword'] = convert(node.nativeKeyword);
  }

  if (node is NativeFunctionBody) {
    jsnode['nativeKeyword'] = convert(node.nativeKeyword);
    jsnode['semicolon'] = convert(node.semicolon);
    jsnode['stringLiteral'] = convert(node.stringLiteral);
  }

  if (node is NormalFormalParameter) {
    jsnode['documentationComment'] = convert(node.documentationComment);
    jsnode['sortedCommentAndAnnotations'] =
        convert(node.sortedCommentAndAnnotations);
  }

  if (node is NullAssertPattern) {
    jsnode['operator'] = convert(node.operator);
    jsnode['pattern'] = convert(node.pattern);
  }

  if (node is NullCheckPattern) {
    jsnode['operator'] = convert(node.operator);
    jsnode['pattern'] = convert(node.pattern);
  }

  if (node is NullLiteral) {
    jsnode['literal'] = convert(node.literal);
  }

  if (node is ObjectPattern) {
    jsnode['fields'] = convert(node.fields);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
    jsnode['type'] = convert(node.type);
  }

  if (node is ParenthesizedExpression) {
    jsnode['expression'] = convert(node.expression);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
  }

  if (node is ParenthesizedPattern) {
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['pattern'] = convert(node.pattern);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
  }

  if (node is PartDirective) {
    jsnode['configurations'] = convert(node.configurations);
    jsnode['element'] = convert(node.element);
    jsnode['partKeyword'] = convert(node.partKeyword);
    jsnode['semicolon'] = convert(node.semicolon);
  }

  if (node is PartOfDirective) {
    jsnode['libraryName'] = convert(node.libraryName);
    jsnode['ofKeyword'] = convert(node.ofKeyword);
    jsnode['partKeyword'] = convert(node.partKeyword);
    jsnode['semicolon'] = convert(node.semicolon);
    jsnode['uri'] = convert(node.uri);
  }

  if (node is PatternAssignment) {
    jsnode['equals'] = convert(node.equals);
    jsnode['expression'] = convert(node.expression);
    jsnode['pattern'] = convert(node.pattern);
  }

  if (node is PatternField) {
    jsnode['effectiveName'] = convert(node.effectiveName);
    jsnode['element'] = convert(node.element);
    jsnode['name'] = convert(node.name);
    jsnode['pattern'] = convert(node.pattern);
  }

  if (node is PatternFieldName) {
    jsnode['colon'] = convert(node.colon);
    jsnode['name'] = convert(node.name);
  }

  if (node is PatternVariableDeclaration) {
    jsnode['equals'] = convert(node.equals);
    jsnode['expression'] = convert(node.expression);
    jsnode['keyword'] = convert(node.keyword);
    jsnode['pattern'] = convert(node.pattern);
  }

  if (node is PatternVariableDeclarationStatement) {
    jsnode['declaration'] = convert(node.declaration);
    jsnode['semicolon'] = convert(node.semicolon);
  }

  if (node is PostfixExpression) {
    jsnode['operand'] = convert(node.operand);
    jsnode['operator'] = convert(node.operator);
    jsnode['staticElement'] = convert(node.staticElement);
  }

  if (node is PrefixedIdentifier) {
    jsnode['identifier'] = convert(node.identifier);
    jsnode['isDeferred'] = convert(node.isDeferred);
    jsnode['period'] = convert(node.period);
    jsnode['prefix'] = convert(node.prefix);
  }

  if (node is PrefixExpression) {
    jsnode['operand'] = convert(node.operand);
    jsnode['operator'] = convert(node.operator);
  }

  if (node is PropertyAccess) {
    jsnode['isCascaded'] = convert(node.isCascaded);
    jsnode['isNullAware'] = convert(node.isNullAware);
    jsnode['operator'] = convert(node.operator);
    jsnode['propertyName'] = convert(node.propertyName);
    jsnode['realTarget'] = convert(node.realTarget);
    jsnode['target'] = convert(node.target);
  }

  if (node is RecordLiteral) {
    jsnode['constKeyword'] = convert(node.constKeyword);
    jsnode['fields'] = convert(node.fields);
    jsnode['isConst'] = convert(node.isConst);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
  }

  if (node is RecordPattern) {
    jsnode['fields'] = convert(node.fields);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
  }

  if (node is RecordTypeAnnotation) {
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['namedFields'] = convert(node.namedFields);
    jsnode['positionalFields'] = convert(node.positionalFields);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
  }

  if (node is RecordTypeAnnotationField) {
    jsnode['metadata'] = convert(node.metadata);
    jsnode['name'] = convert(node.name);
    jsnode['type'] = convert(node.type);
  }

  if (node is RecordTypeAnnotationNamedField) {
    jsnode['name'] = convert(node.name);
  }

  if (node is RecordTypeAnnotationNamedFields) {
    jsnode['fields'] = convert(node.fields);
    jsnode['leftBracket'] = convert(node.leftBracket);
    jsnode['rightBracket'] = convert(node.rightBracket);
  }

  if (node is RedirectingConstructorInvocation) {
    jsnode['argumentList'] = convert(node.argumentList);
    jsnode['constructorName'] = convert(node.constructorName);
    jsnode['period'] = convert(node.period);
    jsnode['staticElement'] = convert(node.staticElement);
    jsnode['thisKeyword'] = convert(node.thisKeyword);
  }

  if (node is RelationalPattern) {
    jsnode['element'] = convert(node.element);
    jsnode['operand'] = convert(node.operand);
    jsnode['operator'] = convert(node.operator);
  }

  if (node is RepresentationConstructorName) {
    jsnode['name'] = convert(node.name);
    jsnode['period'] = convert(node.period);
  }

  if (node is RepresentationDeclaration) {
    jsnode['constructorElement'] = convert(node.constructorElement);
    jsnode['constructorName'] = convert(node.constructorName);
    jsnode['fieldElement'] = convert(node.fieldElement);
    jsnode['fieldMetadata'] = convert(node.fieldMetadata);
    jsnode['fieldName'] = convert(node.fieldName);
    jsnode['fieldType'] = convert(node.fieldType);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
  }

  if (node is RestPatternElement) {
    jsnode['operator'] = convert(node.operator);
    jsnode['pattern'] = convert(node.pattern);
  }

  if (node is RethrowExpression) {
    jsnode['rethrowKeyword'] = convert(node.rethrowKeyword);
  }

  if (node is ReturnStatement) {
    jsnode['expression'] = convert(node.expression);
    jsnode['returnKeyword'] = convert(node.returnKeyword);
    jsnode['semicolon'] = convert(node.semicolon);
  }

  if (node is ScriptTag) {
    jsnode['scriptTag'] = convert(node.scriptTag);
  }

  if (node is SetOrMapLiteral) {
    jsnode['elements'] = convert(node.elements);
    jsnode['isMap'] = convert(node.isMap);
    jsnode['isSet'] = convert(node.isSet);
    jsnode['leftBracket'] = convert(node.leftBracket);
    jsnode['rightBracket'] = convert(node.rightBracket);
  }

  if (node is ShowCombinator) {
    jsnode['shownNames'] = convert(node.shownNames);
  }

  if (node is SimpleFormalParameter) {
    jsnode['keyword'] = convert(node.keyword);
    jsnode['type'] = convert(node.type);
  }

  if (node is SimpleIdentifier) {
    jsnode['isQualified'] = convert(node.isQualified);
    jsnode['tearOffTypeArgumentTypes'] = convert(node.tearOffTypeArgumentTypes);
    jsnode['token'] = convert(node.token);
  }

  if (node is SimpleStringLiteral) {
    jsnode['literal'] = convert(node.literal);
    jsnode['value'] = convert(node.value);
  }

  if (node is SingleStringLiteral) {
    jsnode['contentsEnd'] = convert(node.contentsEnd);
    jsnode['contentsOffset'] = convert(node.contentsOffset);
    jsnode['isMultiline'] = convert(node.isMultiline);
    jsnode['isRaw'] = convert(node.isRaw);
    jsnode['isSingleQuoted'] = convert(node.isSingleQuoted);
  }

  if (node is SpreadElement) {
    jsnode['expression'] = convert(node.expression);
    jsnode['isNullAware'] = convert(node.isNullAware);
    jsnode['spreadOperator'] = convert(node.spreadOperator);
  }

  if (node is StringInterpolation) {
    jsnode['elements'] = convert(node.elements);
    jsnode['firstString'] = convert(node.firstString);
    jsnode['lastString'] = convert(node.lastString);
  }

  if (node is StringLiteral) {
    jsnode['stringValue'] = convert(node.stringValue);
  }

  if (node is SuperConstructorInvocation) {
    jsnode['argumentList'] = convert(node.argumentList);
    jsnode['constructorName'] = convert(node.constructorName);
    jsnode['period'] = convert(node.period);
    jsnode['superKeyword'] = convert(node.superKeyword);
  }

  if (node is SuperExpression) {
    jsnode['superKeyword'] = convert(node.superKeyword);
  }

  if (node is SuperFormalParameter) {
    jsnode['keyword'] = convert(node.keyword);
    jsnode['name'] = convert(node.name);
    jsnode['parameters'] = convert(node.parameters);
    jsnode['period'] = convert(node.period);
    jsnode['question'] = convert(node.question);
    jsnode['superKeyword'] = convert(node.superKeyword);
    jsnode['type'] = convert(node.type);
    jsnode['typeParameters'] = convert(node.typeParameters);
  }

  if (node is SwitchCase) {
    jsnode['expression'] = convert(node.expression);
  }

  if (node is SwitchExpression) {
    jsnode['cases'] = convert(node.cases);
    jsnode['expression'] = convert(node.expression);
    jsnode['leftBracket'] = convert(node.leftBracket);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['rightBracket'] = convert(node.rightBracket);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
    jsnode['switchKeyword'] = convert(node.switchKeyword);
  }

  if (node is SwitchExpressionCase) {
    jsnode['arrow'] = convert(node.arrow);
    jsnode['expression'] = convert(node.expression);
    jsnode['guardedPattern'] = convert(node.guardedPattern);
  }

  if (node is SwitchMember) {
    jsnode['colon'] = convert(node.colon);
    jsnode['keyword'] = convert(node.keyword);
    jsnode['labels'] = convert(node.labels);
    jsnode['statements'] = convert(node.statements);
  }

  if (node is SwitchPatternCase) {
    jsnode['guardedPattern'] = convert(node.guardedPattern);
  }

  if (node is SwitchStatement) {
    jsnode['expression'] = convert(node.expression);
    jsnode['leftBracket'] = convert(node.leftBracket);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['members'] = convert(node.members);
    jsnode['rightBracket'] = convert(node.rightBracket);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
    jsnode['switchKeyword'] = convert(node.switchKeyword);
  }

  if (node is SymbolLiteral) {
    jsnode['components'] = convert(node.components);
    jsnode['poundSign'] = convert(node.poundSign);
  }

  if (node is ThisExpression) {
    jsnode['thisKeyword'] = convert(node.thisKeyword);
  }

  if (node is ThrowExpression) {
    jsnode['expression'] = convert(node.expression);
    jsnode['throwKeyword'] = convert(node.throwKeyword);
  }

  if (node is TopLevelVariableDeclaration) {
    jsnode['augmentKeyword'] = convert(node.augmentKeyword);
    jsnode['externalKeyword'] = convert(node.externalKeyword);
    jsnode['semicolon'] = convert(node.semicolon);
    jsnode['variables'] = convert(node.variables);
  }

  if (node is TryStatement) {
    jsnode['body'] = convert(node.body);
    jsnode['catchClauses'] = convert(node.catchClauses);
    jsnode['finallyBlock'] = convert(node.finallyBlock);
    jsnode['finallyKeyword'] = convert(node.finallyKeyword);
    jsnode['tryKeyword'] = convert(node.tryKeyword);
  }

  if (node is TypeAlias) {
    jsnode['augmentKeyword'] = convert(node.augmentKeyword);
    jsnode['semicolon'] = convert(node.semicolon);
    jsnode['typedefKeyword'] = convert(node.typedefKeyword);
  }

  if (node is TypeAnnotation) {
    jsnode['question'] = convert(node.question);
    jsnode['type'] = convert(node.type);
  }

  if (node is TypeArgumentList) {
    jsnode['arguments'] = convert(node.arguments);
    jsnode['leftBracket'] = convert(node.leftBracket);
    jsnode['rightBracket'] = convert(node.rightBracket);
  }

  if (node is TypedLiteral) {
    jsnode['constKeyword'] = convert(node.constKeyword);
    jsnode['isConst'] = convert(node.isConst);
    jsnode['typeArguments'] = convert(node.typeArguments);
  }

  if (node is TypeLiteral) {
    jsnode['type'] = convert(node.type);
  }

  if (node is TypeParameter) {
    jsnode['bound'] = convert(node.bound);
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['extendsKeyword'] = convert(node.extendsKeyword);
    jsnode['name'] = convert(node.name);
  }

  if (node is TypeParameterList) {
    jsnode['leftBracket'] = convert(node.leftBracket);
    jsnode['rightBracket'] = convert(node.rightBracket);
    jsnode['typeParameters'] = convert(node.typeParameters);
  }

  if (node is UriBasedDirective) {
    jsnode['uri'] = convert(node.uri);
  }

  if (node is VariableDeclaration) {
    jsnode['declaredElement'] = convert(node.declaredElement);
    jsnode['equals'] = convert(node.equals);
    jsnode['initializer'] = convert(node.initializer);
    jsnode['isConst'] = convert(node.isConst);
    jsnode['isFinal'] = convert(node.isFinal);
    jsnode['isLate'] = convert(node.isLate);
    jsnode['name'] = convert(node.name);
  }

  if (node is VariableDeclarationList) {
    jsnode['isConst'] = convert(node.isConst);
    jsnode['isFinal'] = convert(node.isFinal);
    jsnode['isLate'] = convert(node.isLate);
    jsnode['keyword'] = convert(node.keyword);
    jsnode['lateKeyword'] = convert(node.lateKeyword);
    jsnode['type'] = convert(node.type);
    jsnode['variables'] = convert(node.variables);
  }

  if (node is VariableDeclarationStatement) {
    jsnode['semicolon'] = convert(node.semicolon);
    jsnode['variables'] = convert(node.variables);
  }

  if (node is VariablePattern) {
    jsnode['name'] = convert(node.name);
  }

  if (node is WhenClause) {
    jsnode['expression'] = convert(node.expression);
    jsnode['whenKeyword'] = convert(node.whenKeyword);
  }

  if (node is WhileStatement) {
    jsnode['body'] = convert(node.body);
    jsnode['condition'] = convert(node.condition);
    jsnode['leftParenthesis'] = convert(node.leftParenthesis);
    jsnode['rightParenthesis'] = convert(node.rightParenthesis);
    jsnode['whileKeyword'] = convert(node.whileKeyword);
  }

  if (node is WildcardPattern) {
    jsnode['keyword'] = convert(node.keyword);
    jsnode['name'] = convert(node.name);
    jsnode['type'] = convert(node.type);
  }

  if (node is WithClause) {
    jsnode['mixinTypes'] = convert(node.mixinTypes);
    jsnode['withKeyword'] = convert(node.withKeyword);
  }

  if (node is YieldStatement) {
    jsnode['expression'] = convert(node.expression);
    jsnode['semicolon'] = convert(node.semicolon);
    jsnode['star'] = convert(node.star);
    jsnode['yieldKeyword'] = convert(node.yieldKeyword);
  }

  return jsnode;
}

JSAny? convert(Object? obj) {
  if (obj == null) return null;
  if (obj is Iterable) return convertList(obj);
  if (obj is SyntacticEntity) return convertNode(obj);
  return convertObject(obj);
}
