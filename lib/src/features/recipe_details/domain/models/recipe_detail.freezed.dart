// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecipeDetail {
  int get id;
  String get title;
  String? get image;
  int? get readyInMinutes;
  int? get servings;
  String? get summary;
  String? get instructions;
  List<ExtendedIngredient>? get extendedIngredients;
  List<AnalyzedInstruction>? get analyzedInstructions;
  Nutrition? get nutrition;

  /// Create a copy of RecipeDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecipeDetailCopyWith<RecipeDetail> get copyWith =>
      _$RecipeDetailCopyWithImpl<RecipeDetail>(
          this as RecipeDetail, _$identity);

  /// Serializes this RecipeDetail to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecipeDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.readyInMinutes, readyInMinutes) ||
                other.readyInMinutes == readyInMinutes) &&
            (identical(other.servings, servings) ||
                other.servings == servings) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.instructions, instructions) ||
                other.instructions == instructions) &&
            const DeepCollectionEquality()
                .equals(other.extendedIngredients, extendedIngredients) &&
            const DeepCollectionEquality()
                .equals(other.analyzedInstructions, analyzedInstructions) &&
            (identical(other.nutrition, nutrition) ||
                other.nutrition == nutrition));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      image,
      readyInMinutes,
      servings,
      summary,
      instructions,
      const DeepCollectionEquality().hash(extendedIngredients),
      const DeepCollectionEquality().hash(analyzedInstructions),
      nutrition);

  @override
  String toString() {
    return 'RecipeDetail(id: $id, title: $title, image: $image, readyInMinutes: $readyInMinutes, servings: $servings, summary: $summary, instructions: $instructions, extendedIngredients: $extendedIngredients, analyzedInstructions: $analyzedInstructions, nutrition: $nutrition)';
  }
}

/// @nodoc
abstract mixin class $RecipeDetailCopyWith<$Res> {
  factory $RecipeDetailCopyWith(
          RecipeDetail value, $Res Function(RecipeDetail) _then) =
      _$RecipeDetailCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      String? image,
      int? readyInMinutes,
      int? servings,
      String? summary,
      String? instructions,
      List<ExtendedIngredient>? extendedIngredients,
      List<AnalyzedInstruction>? analyzedInstructions,
      Nutrition? nutrition});

  $NutritionCopyWith<$Res>? get nutrition;
}

/// @nodoc
class _$RecipeDetailCopyWithImpl<$Res> implements $RecipeDetailCopyWith<$Res> {
  _$RecipeDetailCopyWithImpl(this._self, this._then);

  final RecipeDetail _self;
  final $Res Function(RecipeDetail) _then;

  /// Create a copy of RecipeDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? image = freezed,
    Object? readyInMinutes = freezed,
    Object? servings = freezed,
    Object? summary = freezed,
    Object? instructions = freezed,
    Object? extendedIngredients = freezed,
    Object? analyzedInstructions = freezed,
    Object? nutrition = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      readyInMinutes: freezed == readyInMinutes
          ? _self.readyInMinutes
          : readyInMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      servings: freezed == servings
          ? _self.servings
          : servings // ignore: cast_nullable_to_non_nullable
              as int?,
      summary: freezed == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
      instructions: freezed == instructions
          ? _self.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String?,
      extendedIngredients: freezed == extendedIngredients
          ? _self.extendedIngredients
          : extendedIngredients // ignore: cast_nullable_to_non_nullable
              as List<ExtendedIngredient>?,
      analyzedInstructions: freezed == analyzedInstructions
          ? _self.analyzedInstructions
          : analyzedInstructions // ignore: cast_nullable_to_non_nullable
              as List<AnalyzedInstruction>?,
      nutrition: freezed == nutrition
          ? _self.nutrition
          : nutrition // ignore: cast_nullable_to_non_nullable
              as Nutrition?,
    ));
  }

  /// Create a copy of RecipeDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NutritionCopyWith<$Res>? get nutrition {
    if (_self.nutrition == null) {
      return null;
    }

    return $NutritionCopyWith<$Res>(_self.nutrition!, (value) {
      return _then(_self.copyWith(nutrition: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _RecipeDetail implements RecipeDetail {
  const _RecipeDetail(
      {required this.id,
      required this.title,
      this.image,
      this.readyInMinutes,
      this.servings,
      this.summary,
      this.instructions,
      final List<ExtendedIngredient>? extendedIngredients,
      final List<AnalyzedInstruction>? analyzedInstructions,
      this.nutrition})
      : _extendedIngredients = extendedIngredients,
        _analyzedInstructions = analyzedInstructions;
  factory _RecipeDetail.fromJson(Map<String, dynamic> json) =>
      _$RecipeDetailFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String? image;
  @override
  final int? readyInMinutes;
  @override
  final int? servings;
  @override
  final String? summary;
  @override
  final String? instructions;
  final List<ExtendedIngredient>? _extendedIngredients;
  @override
  List<ExtendedIngredient>? get extendedIngredients {
    final value = _extendedIngredients;
    if (value == null) return null;
    if (_extendedIngredients is EqualUnmodifiableListView)
      return _extendedIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<AnalyzedInstruction>? _analyzedInstructions;
  @override
  List<AnalyzedInstruction>? get analyzedInstructions {
    final value = _analyzedInstructions;
    if (value == null) return null;
    if (_analyzedInstructions is EqualUnmodifiableListView)
      return _analyzedInstructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Nutrition? nutrition;

  /// Create a copy of RecipeDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecipeDetailCopyWith<_RecipeDetail> get copyWith =>
      __$RecipeDetailCopyWithImpl<_RecipeDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RecipeDetailToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecipeDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.readyInMinutes, readyInMinutes) ||
                other.readyInMinutes == readyInMinutes) &&
            (identical(other.servings, servings) ||
                other.servings == servings) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.instructions, instructions) ||
                other.instructions == instructions) &&
            const DeepCollectionEquality()
                .equals(other._extendedIngredients, _extendedIngredients) &&
            const DeepCollectionEquality()
                .equals(other._analyzedInstructions, _analyzedInstructions) &&
            (identical(other.nutrition, nutrition) ||
                other.nutrition == nutrition));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      image,
      readyInMinutes,
      servings,
      summary,
      instructions,
      const DeepCollectionEquality().hash(_extendedIngredients),
      const DeepCollectionEquality().hash(_analyzedInstructions),
      nutrition);

  @override
  String toString() {
    return 'RecipeDetail(id: $id, title: $title, image: $image, readyInMinutes: $readyInMinutes, servings: $servings, summary: $summary, instructions: $instructions, extendedIngredients: $extendedIngredients, analyzedInstructions: $analyzedInstructions, nutrition: $nutrition)';
  }
}

/// @nodoc
abstract mixin class _$RecipeDetailCopyWith<$Res>
    implements $RecipeDetailCopyWith<$Res> {
  factory _$RecipeDetailCopyWith(
          _RecipeDetail value, $Res Function(_RecipeDetail) _then) =
      __$RecipeDetailCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String? image,
      int? readyInMinutes,
      int? servings,
      String? summary,
      String? instructions,
      List<ExtendedIngredient>? extendedIngredients,
      List<AnalyzedInstruction>? analyzedInstructions,
      Nutrition? nutrition});

  @override
  $NutritionCopyWith<$Res>? get nutrition;
}

/// @nodoc
class __$RecipeDetailCopyWithImpl<$Res>
    implements _$RecipeDetailCopyWith<$Res> {
  __$RecipeDetailCopyWithImpl(this._self, this._then);

  final _RecipeDetail _self;
  final $Res Function(_RecipeDetail) _then;

  /// Create a copy of RecipeDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? image = freezed,
    Object? readyInMinutes = freezed,
    Object? servings = freezed,
    Object? summary = freezed,
    Object? instructions = freezed,
    Object? extendedIngredients = freezed,
    Object? analyzedInstructions = freezed,
    Object? nutrition = freezed,
  }) {
    return _then(_RecipeDetail(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      readyInMinutes: freezed == readyInMinutes
          ? _self.readyInMinutes
          : readyInMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      servings: freezed == servings
          ? _self.servings
          : servings // ignore: cast_nullable_to_non_nullable
              as int?,
      summary: freezed == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
      instructions: freezed == instructions
          ? _self.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String?,
      extendedIngredients: freezed == extendedIngredients
          ? _self._extendedIngredients
          : extendedIngredients // ignore: cast_nullable_to_non_nullable
              as List<ExtendedIngredient>?,
      analyzedInstructions: freezed == analyzedInstructions
          ? _self._analyzedInstructions
          : analyzedInstructions // ignore: cast_nullable_to_non_nullable
              as List<AnalyzedInstruction>?,
      nutrition: freezed == nutrition
          ? _self.nutrition
          : nutrition // ignore: cast_nullable_to_non_nullable
              as Nutrition?,
    ));
  }

  /// Create a copy of RecipeDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NutritionCopyWith<$Res>? get nutrition {
    if (_self.nutrition == null) {
      return null;
    }

    return $NutritionCopyWith<$Res>(_self.nutrition!, (value) {
      return _then(_self.copyWith(nutrition: value));
    });
  }
}

/// @nodoc
mixin _$ExtendedIngredient {
  int get id;
  String get name;
  String get original;
  String? get image;
  double? get amount;
  String? get unit;

  /// Create a copy of ExtendedIngredient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExtendedIngredientCopyWith<ExtendedIngredient> get copyWith =>
      _$ExtendedIngredientCopyWithImpl<ExtendedIngredient>(
          this as ExtendedIngredient, _$identity);

  /// Serializes this ExtendedIngredient to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExtendedIngredient &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.original, original) ||
                other.original == original) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.unit, unit) || other.unit == unit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, original, image, amount, unit);

  @override
  String toString() {
    return 'ExtendedIngredient(id: $id, name: $name, original: $original, image: $image, amount: $amount, unit: $unit)';
  }
}

/// @nodoc
abstract mixin class $ExtendedIngredientCopyWith<$Res> {
  factory $ExtendedIngredientCopyWith(
          ExtendedIngredient value, $Res Function(ExtendedIngredient) _then) =
      _$ExtendedIngredientCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      String original,
      String? image,
      double? amount,
      String? unit});
}

/// @nodoc
class _$ExtendedIngredientCopyWithImpl<$Res>
    implements $ExtendedIngredientCopyWith<$Res> {
  _$ExtendedIngredientCopyWithImpl(this._self, this._then);

  final ExtendedIngredient _self;
  final $Res Function(ExtendedIngredient) _then;

  /// Create a copy of ExtendedIngredient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? original = null,
    Object? image = freezed,
    Object? amount = freezed,
    Object? unit = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      original: null == original
          ? _self.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: freezed == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ExtendedIngredient implements ExtendedIngredient {
  const _ExtendedIngredient(
      {required this.id,
      required this.name,
      required this.original,
      this.image,
      this.amount,
      this.unit});
  factory _ExtendedIngredient.fromJson(Map<String, dynamic> json) =>
      _$ExtendedIngredientFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String original;
  @override
  final String? image;
  @override
  final double? amount;
  @override
  final String? unit;

  /// Create a copy of ExtendedIngredient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExtendedIngredientCopyWith<_ExtendedIngredient> get copyWith =>
      __$ExtendedIngredientCopyWithImpl<_ExtendedIngredient>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExtendedIngredientToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExtendedIngredient &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.original, original) ||
                other.original == original) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.unit, unit) || other.unit == unit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, original, image, amount, unit);

  @override
  String toString() {
    return 'ExtendedIngredient(id: $id, name: $name, original: $original, image: $image, amount: $amount, unit: $unit)';
  }
}

/// @nodoc
abstract mixin class _$ExtendedIngredientCopyWith<$Res>
    implements $ExtendedIngredientCopyWith<$Res> {
  factory _$ExtendedIngredientCopyWith(
          _ExtendedIngredient value, $Res Function(_ExtendedIngredient) _then) =
      __$ExtendedIngredientCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String original,
      String? image,
      double? amount,
      String? unit});
}

/// @nodoc
class __$ExtendedIngredientCopyWithImpl<$Res>
    implements _$ExtendedIngredientCopyWith<$Res> {
  __$ExtendedIngredientCopyWithImpl(this._self, this._then);

  final _ExtendedIngredient _self;
  final $Res Function(_ExtendedIngredient) _then;

  /// Create a copy of ExtendedIngredient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? original = null,
    Object? image = freezed,
    Object? amount = freezed,
    Object? unit = freezed,
  }) {
    return _then(_ExtendedIngredient(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      original: null == original
          ? _self.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: freezed == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$AnalyzedInstruction {
  List<InstructionStep> get steps;

  /// Create a copy of AnalyzedInstruction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AnalyzedInstructionCopyWith<AnalyzedInstruction> get copyWith =>
      _$AnalyzedInstructionCopyWithImpl<AnalyzedInstruction>(
          this as AnalyzedInstruction, _$identity);

  /// Serializes this AnalyzedInstruction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AnalyzedInstruction &&
            const DeepCollectionEquality().equals(other.steps, steps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(steps));

  @override
  String toString() {
    return 'AnalyzedInstruction(steps: $steps)';
  }
}

/// @nodoc
abstract mixin class $AnalyzedInstructionCopyWith<$Res> {
  factory $AnalyzedInstructionCopyWith(
          AnalyzedInstruction value, $Res Function(AnalyzedInstruction) _then) =
      _$AnalyzedInstructionCopyWithImpl;
  @useResult
  $Res call({List<InstructionStep> steps});
}

/// @nodoc
class _$AnalyzedInstructionCopyWithImpl<$Res>
    implements $AnalyzedInstructionCopyWith<$Res> {
  _$AnalyzedInstructionCopyWithImpl(this._self, this._then);

  final AnalyzedInstruction _self;
  final $Res Function(AnalyzedInstruction) _then;

  /// Create a copy of AnalyzedInstruction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steps = null,
  }) {
    return _then(_self.copyWith(
      steps: null == steps
          ? _self.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<InstructionStep>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AnalyzedInstruction implements AnalyzedInstruction {
  const _AnalyzedInstruction({required final List<InstructionStep> steps})
      : _steps = steps;
  factory _AnalyzedInstruction.fromJson(Map<String, dynamic> json) =>
      _$AnalyzedInstructionFromJson(json);

  final List<InstructionStep> _steps;
  @override
  List<InstructionStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  /// Create a copy of AnalyzedInstruction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AnalyzedInstructionCopyWith<_AnalyzedInstruction> get copyWith =>
      __$AnalyzedInstructionCopyWithImpl<_AnalyzedInstruction>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AnalyzedInstructionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AnalyzedInstruction &&
            const DeepCollectionEquality().equals(other._steps, _steps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_steps));

  @override
  String toString() {
    return 'AnalyzedInstruction(steps: $steps)';
  }
}

/// @nodoc
abstract mixin class _$AnalyzedInstructionCopyWith<$Res>
    implements $AnalyzedInstructionCopyWith<$Res> {
  factory _$AnalyzedInstructionCopyWith(_AnalyzedInstruction value,
          $Res Function(_AnalyzedInstruction) _then) =
      __$AnalyzedInstructionCopyWithImpl;
  @override
  @useResult
  $Res call({List<InstructionStep> steps});
}

/// @nodoc
class __$AnalyzedInstructionCopyWithImpl<$Res>
    implements _$AnalyzedInstructionCopyWith<$Res> {
  __$AnalyzedInstructionCopyWithImpl(this._self, this._then);

  final _AnalyzedInstruction _self;
  final $Res Function(_AnalyzedInstruction) _then;

  /// Create a copy of AnalyzedInstruction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? steps = null,
  }) {
    return _then(_AnalyzedInstruction(
      steps: null == steps
          ? _self._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<InstructionStep>,
    ));
  }
}

/// @nodoc
mixin _$InstructionStep {
  int get number;
  String get step;

  /// Create a copy of InstructionStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InstructionStepCopyWith<InstructionStep> get copyWith =>
      _$InstructionStepCopyWithImpl<InstructionStep>(
          this as InstructionStep, _$identity);

  /// Serializes this InstructionStep to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InstructionStep &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.step, step) || other.step == step));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, number, step);

  @override
  String toString() {
    return 'InstructionStep(number: $number, step: $step)';
  }
}

/// @nodoc
abstract mixin class $InstructionStepCopyWith<$Res> {
  factory $InstructionStepCopyWith(
          InstructionStep value, $Res Function(InstructionStep) _then) =
      _$InstructionStepCopyWithImpl;
  @useResult
  $Res call({int number, String step});
}

/// @nodoc
class _$InstructionStepCopyWithImpl<$Res>
    implements $InstructionStepCopyWith<$Res> {
  _$InstructionStepCopyWithImpl(this._self, this._then);

  final InstructionStep _self;
  final $Res Function(InstructionStep) _then;

  /// Create a copy of InstructionStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? step = null,
  }) {
    return _then(_self.copyWith(
      number: null == number
          ? _self.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      step: null == step
          ? _self.step
          : step // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _InstructionStep implements InstructionStep {
  const _InstructionStep({required this.number, required this.step});
  factory _InstructionStep.fromJson(Map<String, dynamic> json) =>
      _$InstructionStepFromJson(json);

  @override
  final int number;
  @override
  final String step;

  /// Create a copy of InstructionStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InstructionStepCopyWith<_InstructionStep> get copyWith =>
      __$InstructionStepCopyWithImpl<_InstructionStep>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InstructionStepToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InstructionStep &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.step, step) || other.step == step));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, number, step);

  @override
  String toString() {
    return 'InstructionStep(number: $number, step: $step)';
  }
}

/// @nodoc
abstract mixin class _$InstructionStepCopyWith<$Res>
    implements $InstructionStepCopyWith<$Res> {
  factory _$InstructionStepCopyWith(
          _InstructionStep value, $Res Function(_InstructionStep) _then) =
      __$InstructionStepCopyWithImpl;
  @override
  @useResult
  $Res call({int number, String step});
}

/// @nodoc
class __$InstructionStepCopyWithImpl<$Res>
    implements _$InstructionStepCopyWith<$Res> {
  __$InstructionStepCopyWithImpl(this._self, this._then);

  final _InstructionStep _self;
  final $Res Function(_InstructionStep) _then;

  /// Create a copy of InstructionStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? number = null,
    Object? step = null,
  }) {
    return _then(_InstructionStep(
      number: null == number
          ? _self.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      step: null == step
          ? _self.step
          : step // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Nutrition {
  List<Nutrient> get nutrients;

  /// Create a copy of Nutrition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NutritionCopyWith<Nutrition> get copyWith =>
      _$NutritionCopyWithImpl<Nutrition>(this as Nutrition, _$identity);

  /// Serializes this Nutrition to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Nutrition &&
            const DeepCollectionEquality().equals(other.nutrients, nutrients));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(nutrients));

  @override
  String toString() {
    return 'Nutrition(nutrients: $nutrients)';
  }
}

/// @nodoc
abstract mixin class $NutritionCopyWith<$Res> {
  factory $NutritionCopyWith(Nutrition value, $Res Function(Nutrition) _then) =
      _$NutritionCopyWithImpl;
  @useResult
  $Res call({List<Nutrient> nutrients});
}

/// @nodoc
class _$NutritionCopyWithImpl<$Res> implements $NutritionCopyWith<$Res> {
  _$NutritionCopyWithImpl(this._self, this._then);

  final Nutrition _self;
  final $Res Function(Nutrition) _then;

  /// Create a copy of Nutrition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nutrients = null,
  }) {
    return _then(_self.copyWith(
      nutrients: null == nutrients
          ? _self.nutrients
          : nutrients // ignore: cast_nullable_to_non_nullable
              as List<Nutrient>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Nutrition implements Nutrition {
  const _Nutrition({final List<Nutrient> nutrients = const []})
      : _nutrients = nutrients;
  factory _Nutrition.fromJson(Map<String, dynamic> json) =>
      _$NutritionFromJson(json);

  final List<Nutrient> _nutrients;
  @override
  @JsonKey()
  List<Nutrient> get nutrients {
    if (_nutrients is EqualUnmodifiableListView) return _nutrients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nutrients);
  }

  /// Create a copy of Nutrition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NutritionCopyWith<_Nutrition> get copyWith =>
      __$NutritionCopyWithImpl<_Nutrition>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NutritionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Nutrition &&
            const DeepCollectionEquality()
                .equals(other._nutrients, _nutrients));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_nutrients));

  @override
  String toString() {
    return 'Nutrition(nutrients: $nutrients)';
  }
}

/// @nodoc
abstract mixin class _$NutritionCopyWith<$Res>
    implements $NutritionCopyWith<$Res> {
  factory _$NutritionCopyWith(
          _Nutrition value, $Res Function(_Nutrition) _then) =
      __$NutritionCopyWithImpl;
  @override
  @useResult
  $Res call({List<Nutrient> nutrients});
}

/// @nodoc
class __$NutritionCopyWithImpl<$Res> implements _$NutritionCopyWith<$Res> {
  __$NutritionCopyWithImpl(this._self, this._then);

  final _Nutrition _self;
  final $Res Function(_Nutrition) _then;

  /// Create a copy of Nutrition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? nutrients = null,
  }) {
    return _then(_Nutrition(
      nutrients: null == nutrients
          ? _self._nutrients
          : nutrients // ignore: cast_nullable_to_non_nullable
              as List<Nutrient>,
    ));
  }
}

/// @nodoc
mixin _$Nutrient {
  String get name;
  double get amount;
  String get unit;

  /// Create a copy of Nutrient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NutrientCopyWith<Nutrient> get copyWith =>
      _$NutrientCopyWithImpl<Nutrient>(this as Nutrient, _$identity);

  /// Serializes this Nutrient to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Nutrient &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.unit, unit) || other.unit == unit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, amount, unit);

  @override
  String toString() {
    return 'Nutrient(name: $name, amount: $amount, unit: $unit)';
  }
}

/// @nodoc
abstract mixin class $NutrientCopyWith<$Res> {
  factory $NutrientCopyWith(Nutrient value, $Res Function(Nutrient) _then) =
      _$NutrientCopyWithImpl;
  @useResult
  $Res call({String name, double amount, String unit});
}

/// @nodoc
class _$NutrientCopyWithImpl<$Res> implements $NutrientCopyWith<$Res> {
  _$NutrientCopyWithImpl(this._self, this._then);

  final Nutrient _self;
  final $Res Function(Nutrient) _then;

  /// Create a copy of Nutrient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? amount = null,
    Object? unit = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Nutrient implements Nutrient {
  const _Nutrient(
      {required this.name, required this.amount, required this.unit});
  factory _Nutrient.fromJson(Map<String, dynamic> json) =>
      _$NutrientFromJson(json);

  @override
  final String name;
  @override
  final double amount;
  @override
  final String unit;

  /// Create a copy of Nutrient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NutrientCopyWith<_Nutrient> get copyWith =>
      __$NutrientCopyWithImpl<_Nutrient>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NutrientToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Nutrient &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.unit, unit) || other.unit == unit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, amount, unit);

  @override
  String toString() {
    return 'Nutrient(name: $name, amount: $amount, unit: $unit)';
  }
}

/// @nodoc
abstract mixin class _$NutrientCopyWith<$Res>
    implements $NutrientCopyWith<$Res> {
  factory _$NutrientCopyWith(_Nutrient value, $Res Function(_Nutrient) _then) =
      __$NutrientCopyWithImpl;
  @override
  @useResult
  $Res call({String name, double amount, String unit});
}

/// @nodoc
class __$NutrientCopyWithImpl<$Res> implements _$NutrientCopyWith<$Res> {
  __$NutrientCopyWithImpl(this._self, this._then);

  final _Nutrient _self;
  final $Res Function(_Nutrient) _then;

  /// Create a copy of Nutrient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? amount = null,
    Object? unit = null,
  }) {
    return _then(_Nutrient(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _self.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
