import 'package:ednet_core/ednet_core.dart';
import 'package:test/test.dart';

void main() {
  group('Policy Tests', () {
    final Domain domain = Domain();
    late Model model;
    late PolicyRegistry registry;
    late PolicyEvaluator evaluator;
    late Entity testEntity;
    late Concept testConcept;
    late Concept parentConcept;
    late Concept childConcept;

    setUp(() {
      registry = PolicyRegistry();
      evaluator = PolicyEvaluator(registry);
      model = Model(domain, 'Test');

      // Create concepts and their attributes
      parentConcept = Concept(model, 'ParentConcept');
      parentConcept.attributes.add(Attribute(parentConcept, 'parentType')
        ..type = AttributeType(Domain('Test'), 'String'));

      testConcept = Concept(model, 'TestConcept');
      testConcept.attributes.add(Attribute(testConcept, 'age')
        ..type = AttributeType(Domain('Test'), 'int'));

      childConcept = Concept(model, 'ChildConcept');
      childConcept.attributes.add(Attribute(childConcept, 'childAttr')
        ..type = AttributeType(Domain('Test'), 'String'));

      // Set parent and child relationships
      testConcept.parents.add(Parent(testConcept, parentConcept, 'parentType'));
      testConcept.children.add(Child(testConcept, childConcept, 'children'));

      // Create the test entity
      testEntity = Entity<Concept>()..concept = testConcept;
    });

    test('Basic Policy Evaluation', () {
      var policy = Policy(
          'AgePolicy',
          'Age must be greater than or equal to 18',
          (Entity e) => (e.getAttribute('age') as int? ?? 0) >= 18);
      registry.registerPolicy('agePolicy', policy);

      testEntity.setAttribute('age', 20);
      var result = evaluator.evaluate(testEntity);
      expect(result.success, isTrue);

      testEntity.setAttribute('age', 15);
      result = evaluator.evaluate(testEntity);
      expect(result.success, isFalse);
      expect(result.violations.length, 1);
      expect(result.violations[0].policyKey, 'agePolicy');
    });

    test('Multiple Policy Evaluation', () {
      registry.registerPolicy(
          'agePolicy',
          Policy('AgePolicy', 'Age must be greater than or equal to 18',
              (Entity e) => (e.getAttribute('age') as int? ?? 0) >= 18));

      registry.registerPolicy(
          'evenAgePolicy',
          Policy('EvenAgePolicy', 'Age must be an even number',
              (Entity e) => ((e.getAttribute('age') as int? ?? 0) % 2) == 0));

      testEntity.setAttribute('age', 20);
      var result = evaluator.evaluate(testEntity);
      expect(result.success, isTrue);

      testEntity.setAttribute('age', 19);
      result = evaluator.evaluate(testEntity);
      expect(result.success, isFalse);
      expect(result.violations.length, 1);
      expect(result.violations[0].policyKey, 'evenAgePolicy');

      testEntity.setAttribute('age', 17);
      result = evaluator.evaluate(testEntity);
      expect(result.success, isFalse);
      expect(result.violations.length, 2);
    });

    test('Policy Evaluation in Entity', () {
      registry.registerPolicy(
          'agePolicy',
          Policy('AgePolicy', 'Age must be greater than or equal to 18',
              (Entity e) => (e.getAttribute('age') as int? ?? 0) >= 18));

      testEntity = Entity<Concept>()
        ..policyEvaluator = evaluator
        ..concept = testEntity.concept;

      expect(() => testEntity.setAttribute('age', 15),
          throwsA(isA<PolicyViolationException>()));

      testEntity.setAttribute('age', 20);
      expect(testEntity.getAttribute('age'), 20);
    });

    test('AttributePolicy Evaluation', () {
      var agePolicy = AttributePolicy(
          name: 'Age Policy',
          description: 'Age must be between 18 and 100',
          attributeName: 'age',
          validator: AttributeValidators.isBetween(18, 100));
      registry.registerPolicy('agePolicy', agePolicy);

      testEntity.setAttribute('age', 25);
      var result = evaluator.evaluate(testEntity);
      expect(result.success, isTrue);

      testEntity.setAttribute('age', 15);
      result = evaluator.evaluate(testEntity);
      expect(result.success, isFalse);
      expect(result.violations.length, 1);
      expect(result.violations[0].policyKey, 'agePolicy');

      testEntity.setAttribute('age', 105);
      result = evaluator.evaluate(testEntity);
      expect(result.success, isFalse);
      expect(result.violations.length, 1);
      expect(result.violations[0].policyKey, 'agePolicy');
    });

    test('Extended Attribute Validators - hasParentType', () {
      var parentTypePolicy = AttributePolicy(
          name: 'Parent Type Validator',
          description: 'Ensures the entity has a parent with a specific type',
          attributeName: 'parentType',
          validator: (dynamic value) => AttributeValidators.hasParentType(
              'ParentConcept')(value as Entity));

      registry.registerPolicy('parentTypePolicy', parentTypePolicy);

      var parentEntity = Entity<Concept>()..concept = parentConcept;
      parentEntity.setAttribute('parentType', 'value');
      testEntity.setParent('parentType', parentEntity);

      var result = evaluator.evaluate(testEntity);
      expect(result.success, isTrue);

      parentEntity.setAttribute('parentType', null);
      result = evaluator.evaluate(testEntity);
      expect(result.success, isFalse);
      expect(result.violations.length, 1);
      expect(result.violations[0].policyKey, 'parentTypePolicy');
    });

    test('Extended Attribute Validators - hasChildWithAttribute', () {
      var childAttributePolicy = AttributePolicy(
          name: 'Child Attribute Validator',
          description:
              'Ensures the entity has a child with a specific attribute',
          attributeName: 'childAttribute',
          validator: (dynamic value) =>
              AttributeValidators.hasChildWithAttribute('childAttr')(
                  value as Entity));

      registry.registerPolicy('childAttributePolicy', childAttributePolicy);

      var childEntity = Entity<Concept>()..concept = childConcept;
      childEntity.setAttribute('childAttr', 'value');
      testEntity.setChild('children', childEntity);

      var result = evaluator.evaluate(testEntity);
      expect(result.success, isTrue);

      childEntity.setAttribute('childAttr', null);
      result = evaluator.evaluate(testEntity);
      expect(result.success, isFalse);
      expect(result.violations.length, 1);
      expect(result.violations[0].policyKey, 'childAttributePolicy');
    });

    test('Extended Attribute Validators - compositeValidator', () {
      var complexPolicy = AttributePolicy(
        name: 'Complex Validator',
        description: 'Combines multiple validation rules',
        attributeName: 'complexRule',
        validator: (dynamic value) => AttributeValidators.compositeValidator([
          (dynamic v) => AttributeValidators.isTypeWithProperty(Concept, 'age')(
              v as Entity),
          (dynamic v) => AttributeValidators.hasParentWithAttribute(
              'parentAttr')(v as Entity)
        ])(value as Entity),
      );

      registry.registerPolicy('complexPolicy', complexPolicy);

      var parentEntity = Entity<Concept>()..concept = parentConcept;
      parentEntity.setAttribute('parentAttr', 'value');
      testEntity.setParent('parent', parentEntity);
      testEntity.setAttribute('age', 25);

      var result = evaluator.evaluate(testEntity);
      expect(result.success, isTrue);

      parentEntity.setAttribute('parentAttr', null);
      result = evaluator.evaluate(testEntity);
      expect(result.success, isFalse);
      expect(result.violations.length, 1);
      expect(result.violations[0].policyKey, 'complexPolicy');
    });
  });
}
