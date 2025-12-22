// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schemas.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDeckCollection on Isar {
  IsarCollection<Deck> get decks => this.collection();
}

const DeckSchema = CollectionSchema(
  name: r'Deck',
  id: 4151526915841928397,
  properties: {
    r'deckName': PropertySchema(
      id: 0,
      name: r'deckName',
      type: IsarType.string,
    ),
    r'parentDeckId': PropertySchema(
      id: 1,
      name: r'parentDeckId',
      type: IsarType.long,
    )
  },
  estimateSize: _deckEstimateSize,
  serialize: _deckSerialize,
  deserialize: _deckDeserialize,
  deserializeProp: _deckDeserializeProp,
  idName: r'id',
  indexes: {
    r'deckName': IndexSchema(
      id: -1630801007533096493,
      name: r'deckName',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'deckName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'cards': LinkSchema(
      id: -2302322946404862437,
      name: r'cards',
      target: r'FlashCard',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _deckGetId,
  getLinks: _deckGetLinks,
  attach: _deckAttach,
  version: '3.1.0+1',
);

int _deckEstimateSize(
  Deck object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.deckName.length * 3;
  return bytesCount;
}

void _deckSerialize(
  Deck object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.deckName);
  writer.writeLong(offsets[1], object.parentDeckId);
}

Deck _deckDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Deck();
  object.deckName = reader.readString(offsets[0]);
  object.id = id;
  object.parentDeckId = reader.readLong(offsets[1]);
  return object;
}

P _deckDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _deckGetId(Deck object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _deckGetLinks(Deck object) {
  return [object.cards];
}

void _deckAttach(IsarCollection<dynamic> col, Id id, Deck object) {
  object.id = id;
  object.cards.attach(col, col.isar.collection<FlashCard>(), r'cards', id);
}

extension DeckByIndex on IsarCollection<Deck> {
  Future<Deck?> getByDeckName(String deckName) {
    return getByIndex(r'deckName', [deckName]);
  }

  Deck? getByDeckNameSync(String deckName) {
    return getByIndexSync(r'deckName', [deckName]);
  }

  Future<bool> deleteByDeckName(String deckName) {
    return deleteByIndex(r'deckName', [deckName]);
  }

  bool deleteByDeckNameSync(String deckName) {
    return deleteByIndexSync(r'deckName', [deckName]);
  }

  Future<List<Deck?>> getAllByDeckName(List<String> deckNameValues) {
    final values = deckNameValues.map((e) => [e]).toList();
    return getAllByIndex(r'deckName', values);
  }

  List<Deck?> getAllByDeckNameSync(List<String> deckNameValues) {
    final values = deckNameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'deckName', values);
  }

  Future<int> deleteAllByDeckName(List<String> deckNameValues) {
    final values = deckNameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'deckName', values);
  }

  int deleteAllByDeckNameSync(List<String> deckNameValues) {
    final values = deckNameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'deckName', values);
  }

  Future<Id> putByDeckName(Deck object) {
    return putByIndex(r'deckName', object);
  }

  Id putByDeckNameSync(Deck object, {bool saveLinks = true}) {
    return putByIndexSync(r'deckName', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDeckName(List<Deck> objects) {
    return putAllByIndex(r'deckName', objects);
  }

  List<Id> putAllByDeckNameSync(List<Deck> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'deckName', objects, saveLinks: saveLinks);
  }
}

extension DeckQueryWhereSort on QueryBuilder<Deck, Deck, QWhere> {
  QueryBuilder<Deck, Deck, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DeckQueryWhere on QueryBuilder<Deck, Deck, QWhereClause> {
  QueryBuilder<Deck, Deck, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Deck, Deck, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Deck, Deck, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Deck, Deck, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterWhereClause> deckNameEqualTo(String deckName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'deckName',
        value: [deckName],
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterWhereClause> deckNameNotEqualTo(
      String deckName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deckName',
              lower: [],
              upper: [deckName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deckName',
              lower: [deckName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deckName',
              lower: [deckName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deckName',
              lower: [],
              upper: [deckName],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DeckQueryFilter on QueryBuilder<Deck, Deck, QFilterCondition> {
  QueryBuilder<Deck, Deck, QAfterFilterCondition> deckNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> deckNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> deckNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> deckNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deckName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> deckNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> deckNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> deckNameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> deckNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deckName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> deckNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deckName',
        value: '',
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> deckNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deckName',
        value: '',
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> parentDeckIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentDeckId',
        value: value,
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> parentDeckIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentDeckId',
        value: value,
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> parentDeckIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentDeckId',
        value: value,
      ));
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> parentDeckIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentDeckId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DeckQueryObject on QueryBuilder<Deck, Deck, QFilterCondition> {}

extension DeckQueryLinks on QueryBuilder<Deck, Deck, QFilterCondition> {
  QueryBuilder<Deck, Deck, QAfterFilterCondition> cards(
      FilterQuery<FlashCard> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'cards');
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> cardsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cards', length, true, length, true);
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> cardsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cards', 0, true, 0, true);
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> cardsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cards', 0, false, 999999, true);
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> cardsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cards', 0, true, length, include);
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> cardsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'cards', length, include, 999999, true);
    });
  }

  QueryBuilder<Deck, Deck, QAfterFilterCondition> cardsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'cards', lower, includeLower, upper, includeUpper);
    });
  }
}

extension DeckQuerySortBy on QueryBuilder<Deck, Deck, QSortBy> {
  QueryBuilder<Deck, Deck, QAfterSortBy> sortByDeckName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckName', Sort.asc);
    });
  }

  QueryBuilder<Deck, Deck, QAfterSortBy> sortByDeckNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckName', Sort.desc);
    });
  }

  QueryBuilder<Deck, Deck, QAfterSortBy> sortByParentDeckId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentDeckId', Sort.asc);
    });
  }

  QueryBuilder<Deck, Deck, QAfterSortBy> sortByParentDeckIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentDeckId', Sort.desc);
    });
  }
}

extension DeckQuerySortThenBy on QueryBuilder<Deck, Deck, QSortThenBy> {
  QueryBuilder<Deck, Deck, QAfterSortBy> thenByDeckName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckName', Sort.asc);
    });
  }

  QueryBuilder<Deck, Deck, QAfterSortBy> thenByDeckNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckName', Sort.desc);
    });
  }

  QueryBuilder<Deck, Deck, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Deck, Deck, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Deck, Deck, QAfterSortBy> thenByParentDeckId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentDeckId', Sort.asc);
    });
  }

  QueryBuilder<Deck, Deck, QAfterSortBy> thenByParentDeckIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentDeckId', Sort.desc);
    });
  }
}

extension DeckQueryWhereDistinct on QueryBuilder<Deck, Deck, QDistinct> {
  QueryBuilder<Deck, Deck, QDistinct> distinctByDeckName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deckName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Deck, Deck, QDistinct> distinctByParentDeckId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentDeckId');
    });
  }
}

extension DeckQueryProperty on QueryBuilder<Deck, Deck, QQueryProperty> {
  QueryBuilder<Deck, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Deck, String, QQueryOperations> deckNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deckName');
    });
  }

  QueryBuilder<Deck, int, QQueryOperations> parentDeckIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentDeckId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFlashCardCollection on Isar {
  IsarCollection<FlashCard> get flashCards => this.collection();
}

const FlashCardSchema = CollectionSchema(
  name: r'FlashCard',
  id: 2394645075128407362,
  properties: {
    r'correctAnswer': PropertySchema(
      id: 0,
      name: r'correctAnswer',
      type: IsarType.string,
      enumMap: _FlashCardcorrectAnswerEnumValueMap,
    ),
    r'deckOwnerId': PropertySchema(
      id: 1,
      name: r'deckOwnerId',
      type: IsarType.long,
    ),
    r'explanation': PropertySchema(
      id: 2,
      name: r'explanation',
      type: IsarType.string,
    ),
    r'optionA': PropertySchema(
      id: 3,
      name: r'optionA',
      type: IsarType.string,
    ),
    r'optionB': PropertySchema(
      id: 4,
      name: r'optionB',
      type: IsarType.string,
    ),
    r'optionC': PropertySchema(
      id: 5,
      name: r'optionC',
      type: IsarType.string,
    ),
    r'optionD': PropertySchema(
      id: 6,
      name: r'optionD',
      type: IsarType.string,
    ),
    r'question': PropertySchema(
      id: 7,
      name: r'question',
      type: IsarType.string,
    )
  },
  estimateSize: _flashCardEstimateSize,
  serialize: _flashCardSerialize,
  deserialize: _flashCardDeserialize,
  deserializeProp: _flashCardDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _flashCardGetId,
  getLinks: _flashCardGetLinks,
  attach: _flashCardAttach,
  version: '3.1.0+1',
);

int _flashCardEstimateSize(
  FlashCard object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.correctAnswer.name.length * 3;
  {
    final value = object.explanation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.optionA.length * 3;
  bytesCount += 3 + object.optionB.length * 3;
  bytesCount += 3 + object.optionC.length * 3;
  bytesCount += 3 + object.optionD.length * 3;
  bytesCount += 3 + object.question.length * 3;
  return bytesCount;
}

void _flashCardSerialize(
  FlashCard object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.correctAnswer.name);
  writer.writeLong(offsets[1], object.deckOwnerId);
  writer.writeString(offsets[2], object.explanation);
  writer.writeString(offsets[3], object.optionA);
  writer.writeString(offsets[4], object.optionB);
  writer.writeString(offsets[5], object.optionC);
  writer.writeString(offsets[6], object.optionD);
  writer.writeString(offsets[7], object.question);
}

FlashCard _flashCardDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FlashCard();
  object.correctAnswer = _FlashCardcorrectAnswerValueEnumMap[
          reader.readStringOrNull(offsets[0])] ??
      Answer.A;
  object.deckOwnerId = reader.readLong(offsets[1]);
  object.explanation = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.optionA = reader.readString(offsets[3]);
  object.optionB = reader.readString(offsets[4]);
  object.optionC = reader.readString(offsets[5]);
  object.optionD = reader.readString(offsets[6]);
  object.question = reader.readString(offsets[7]);
  return object;
}

P _flashCardDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_FlashCardcorrectAnswerValueEnumMap[
              reader.readStringOrNull(offset)] ??
          Answer.A) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FlashCardcorrectAnswerEnumValueMap = {
  r'A': r'A',
  r'B': r'B',
  r'C': r'C',
  r'D': r'D',
};
const _FlashCardcorrectAnswerValueEnumMap = {
  r'A': Answer.A,
  r'B': Answer.B,
  r'C': Answer.C,
  r'D': Answer.D,
};

Id _flashCardGetId(FlashCard object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _flashCardGetLinks(FlashCard object) {
  return [];
}

void _flashCardAttach(IsarCollection<dynamic> col, Id id, FlashCard object) {
  object.id = id;
}

extension FlashCardQueryWhereSort
    on QueryBuilder<FlashCard, FlashCard, QWhere> {
  QueryBuilder<FlashCard, FlashCard, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FlashCardQueryWhere
    on QueryBuilder<FlashCard, FlashCard, QWhereClause> {
  QueryBuilder<FlashCard, FlashCard, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FlashCardQueryFilter
    on QueryBuilder<FlashCard, FlashCard, QFilterCondition> {
  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      correctAnswerEqualTo(
    Answer value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'correctAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      correctAnswerGreaterThan(
    Answer value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'correctAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      correctAnswerLessThan(
    Answer value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'correctAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      correctAnswerBetween(
    Answer lower,
    Answer upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'correctAnswer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      correctAnswerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'correctAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      correctAnswerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'correctAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      correctAnswerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'correctAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      correctAnswerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'correctAnswer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      correctAnswerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'correctAnswer',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      correctAnswerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'correctAnswer',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> deckOwnerIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deckOwnerId',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      deckOwnerIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deckOwnerId',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> deckOwnerIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deckOwnerId',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> deckOwnerIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deckOwnerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      explanationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'explanation',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      explanationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'explanation',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> explanationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      explanationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> explanationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> explanationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'explanation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      explanationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> explanationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> explanationContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> explanationMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'explanation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      explanationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explanation',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      explanationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'explanation',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionAEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'optionA',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionAGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'optionA',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionALessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'optionA',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionABetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'optionA',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionAStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'optionA',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionAEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'optionA',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionAContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'optionA',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionAMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'optionA',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionAIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'optionA',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      optionAIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'optionA',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionBEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'optionB',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionBGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'optionB',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionBLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'optionB',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionBBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'optionB',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionBStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'optionB',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionBEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'optionB',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionBContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'optionB',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionBMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'optionB',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionBIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'optionB',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      optionBIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'optionB',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionCEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'optionC',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionCGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'optionC',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionCLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'optionC',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionCBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'optionC',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionCStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'optionC',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionCEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'optionC',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionCContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'optionC',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionCMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'optionC',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionCIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'optionC',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      optionCIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'optionC',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'optionD',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionDGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'optionD',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionDLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'optionD',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionDBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'optionD',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'optionD',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'optionD',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionDContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'optionD',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionDMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'optionD',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> optionDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'optionD',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      optionDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'optionD',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'question',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'question',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      questionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'question',
        value: '',
      ));
    });
  }
}

extension FlashCardQueryObject
    on QueryBuilder<FlashCard, FlashCard, QFilterCondition> {}

extension FlashCardQueryLinks
    on QueryBuilder<FlashCard, FlashCard, QFilterCondition> {}

extension FlashCardQuerySortBy on QueryBuilder<FlashCard, FlashCard, QSortBy> {
  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByCorrectAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswer', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByCorrectAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswer', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByDeckOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckOwnerId', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByDeckOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckOwnerId', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByExplanation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explanation', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByExplanationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explanation', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByOptionA() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionA', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByOptionADesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionA', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByOptionB() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionB', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByOptionBDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionB', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByOptionC() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionC', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByOptionCDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionC', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByOptionD() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionD', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByOptionDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionD', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }
}

extension FlashCardQuerySortThenBy
    on QueryBuilder<FlashCard, FlashCard, QSortThenBy> {
  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByCorrectAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswer', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByCorrectAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswer', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByDeckOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckOwnerId', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByDeckOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckOwnerId', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByExplanation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explanation', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByExplanationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explanation', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByOptionA() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionA', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByOptionADesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionA', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByOptionB() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionB', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByOptionBDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionB', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByOptionC() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionC', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByOptionCDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionC', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByOptionD() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionD', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByOptionDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'optionD', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }
}

extension FlashCardQueryWhereDistinct
    on QueryBuilder<FlashCard, FlashCard, QDistinct> {
  QueryBuilder<FlashCard, FlashCard, QDistinct> distinctByCorrectAnswer(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'correctAnswer',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QDistinct> distinctByDeckOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deckOwnerId');
    });
  }

  QueryBuilder<FlashCard, FlashCard, QDistinct> distinctByExplanation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explanation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QDistinct> distinctByOptionA(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'optionA', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QDistinct> distinctByOptionB(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'optionB', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QDistinct> distinctByOptionC(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'optionC', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QDistinct> distinctByOptionD(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'optionD', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QDistinct> distinctByQuestion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'question', caseSensitive: caseSensitive);
    });
  }
}

extension FlashCardQueryProperty
    on QueryBuilder<FlashCard, FlashCard, QQueryProperty> {
  QueryBuilder<FlashCard, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FlashCard, Answer, QQueryOperations> correctAnswerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'correctAnswer');
    });
  }

  QueryBuilder<FlashCard, int, QQueryOperations> deckOwnerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deckOwnerId');
    });
  }

  QueryBuilder<FlashCard, String?, QQueryOperations> explanationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explanation');
    });
  }

  QueryBuilder<FlashCard, String, QQueryOperations> optionAProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'optionA');
    });
  }

  QueryBuilder<FlashCard, String, QQueryOperations> optionBProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'optionB');
    });
  }

  QueryBuilder<FlashCard, String, QQueryOperations> optionCProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'optionC');
    });
  }

  QueryBuilder<FlashCard, String, QQueryOperations> optionDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'optionD');
    });
  }

  QueryBuilder<FlashCard, String, QQueryOperations> questionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'question');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStudySessionCollection on Isar {
  IsarCollection<StudySession> get studySessions => this.collection();
}

const StudySessionSchema = CollectionSchema(
  name: r'StudySession',
  id: 5950026954574551040,
  properties: {
    r'deckName': PropertySchema(
      id: 0,
      name: r'deckName',
      type: IsarType.string,
    ),
    r'scorePercentage': PropertySchema(
      id: 1,
      name: r'scorePercentage',
      type: IsarType.long,
    ),
    r'sessionDate': PropertySchema(
      id: 2,
      name: r'sessionDate',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _studySessionEstimateSize,
  serialize: _studySessionSerialize,
  deserialize: _studySessionDeserialize,
  deserializeProp: _studySessionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _studySessionGetId,
  getLinks: _studySessionGetLinks,
  attach: _studySessionAttach,
  version: '3.1.0+1',
);

int _studySessionEstimateSize(
  StudySession object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.deckName.length * 3;
  return bytesCount;
}

void _studySessionSerialize(
  StudySession object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.deckName);
  writer.writeLong(offsets[1], object.scorePercentage);
  writer.writeDateTime(offsets[2], object.sessionDate);
}

StudySession _studySessionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StudySession();
  object.deckName = reader.readString(offsets[0]);
  object.id = id;
  object.scorePercentage = reader.readLong(offsets[1]);
  object.sessionDate = reader.readDateTime(offsets[2]);
  return object;
}

P _studySessionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _studySessionGetId(StudySession object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _studySessionGetLinks(StudySession object) {
  return [];
}

void _studySessionAttach(
    IsarCollection<dynamic> col, Id id, StudySession object) {
  object.id = id;
}

extension StudySessionQueryWhereSort
    on QueryBuilder<StudySession, StudySession, QWhere> {
  QueryBuilder<StudySession, StudySession, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StudySessionQueryWhere
    on QueryBuilder<StudySession, StudySession, QWhereClause> {
  QueryBuilder<StudySession, StudySession, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StudySessionQueryFilter
    on QueryBuilder<StudySession, StudySession, QFilterCondition> {
  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      deckNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      deckNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      deckNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      deckNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deckName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      deckNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      deckNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      deckNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deckName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      deckNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deckName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      deckNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deckName',
        value: '',
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      deckNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deckName',
        value: '',
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      scorePercentageEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scorePercentage',
        value: value,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      scorePercentageGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scorePercentage',
        value: value,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      scorePercentageLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scorePercentage',
        value: value,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      scorePercentageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scorePercentage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      sessionDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      sessionDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sessionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      sessionDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sessionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterFilterCondition>
      sessionDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sessionDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StudySessionQueryObject
    on QueryBuilder<StudySession, StudySession, QFilterCondition> {}

extension StudySessionQueryLinks
    on QueryBuilder<StudySession, StudySession, QFilterCondition> {}

extension StudySessionQuerySortBy
    on QueryBuilder<StudySession, StudySession, QSortBy> {
  QueryBuilder<StudySession, StudySession, QAfterSortBy> sortByDeckName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckName', Sort.asc);
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterSortBy> sortByDeckNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckName', Sort.desc);
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterSortBy>
      sortByScorePercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scorePercentage', Sort.asc);
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterSortBy>
      sortByScorePercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scorePercentage', Sort.desc);
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterSortBy> sortBySessionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionDate', Sort.asc);
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterSortBy>
      sortBySessionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionDate', Sort.desc);
    });
  }
}

extension StudySessionQuerySortThenBy
    on QueryBuilder<StudySession, StudySession, QSortThenBy> {
  QueryBuilder<StudySession, StudySession, QAfterSortBy> thenByDeckName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckName', Sort.asc);
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterSortBy> thenByDeckNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckName', Sort.desc);
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterSortBy>
      thenByScorePercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scorePercentage', Sort.asc);
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterSortBy>
      thenByScorePercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scorePercentage', Sort.desc);
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterSortBy> thenBySessionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionDate', Sort.asc);
    });
  }

  QueryBuilder<StudySession, StudySession, QAfterSortBy>
      thenBySessionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionDate', Sort.desc);
    });
  }
}

extension StudySessionQueryWhereDistinct
    on QueryBuilder<StudySession, StudySession, QDistinct> {
  QueryBuilder<StudySession, StudySession, QDistinct> distinctByDeckName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deckName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StudySession, StudySession, QDistinct>
      distinctByScorePercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scorePercentage');
    });
  }

  QueryBuilder<StudySession, StudySession, QDistinct> distinctBySessionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sessionDate');
    });
  }
}

extension StudySessionQueryProperty
    on QueryBuilder<StudySession, StudySession, QQueryProperty> {
  QueryBuilder<StudySession, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StudySession, String, QQueryOperations> deckNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deckName');
    });
  }

  QueryBuilder<StudySession, int, QQueryOperations> scorePercentageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scorePercentage');
    });
  }

  QueryBuilder<StudySession, DateTime, QQueryOperations> sessionDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sessionDate');
    });
  }
}
