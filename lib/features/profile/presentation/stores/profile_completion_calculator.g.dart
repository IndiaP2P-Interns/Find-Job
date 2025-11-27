// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_completion_calculator.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileCompletionCalculator on _ProfileCompletionCalculator, Store {
  Computed<int>? _$completionPercentageComputed;

  @override
  int get completionPercentage => (_$completionPercentageComputed ??=
          Computed<int>(() => super.completionPercentage,
              name: '_ProfileCompletionCalculator.completionPercentage'))
      .value;
  Computed<String>? _$completionMessageComputed;

  @override
  String get completionMessage => (_$completionMessageComputed ??=
          Computed<String>(() => super.completionMessage,
              name: '_ProfileCompletionCalculator.completionMessage'))
      .value;

  @override
  String toString() {
    return '''
completionPercentage: ${completionPercentage},
completionMessage: ${completionMessage}
    ''';
  }
}
