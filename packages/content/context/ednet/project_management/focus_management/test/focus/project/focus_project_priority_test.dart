// test/focus/project/focus_project_priority_test.dart

import 'package:test/test.dart';
import 'package:ednet_core/ednet_core.dart';
import 'package:focus_project/focus_project.dart';

void testFocusProjectPriorities(
    FocusDomain focusDomain, ProjectModel projectModel, Priorities priorities) {
  DomainSession session;
  group('Testing Focus.Project.Priority', () {
    session = focusDomain.newSession();
    setUp(() {
      projectModel.init();
    });
    tearDown(() {
      projectModel.clear();
    });

    test('Not empty model', () {
      expect(projectModel.isEmpty, isFalse);
      expect(priorities.isEmpty, isFalse);
    });

    test('Empty model', () {
      projectModel.clear();
      expect(projectModel.isEmpty, isTrue);
      expect(priorities.isEmpty, isTrue);
      expect(priorities.exceptions.isEmpty, isTrue);
    });

    test('From model to JSON', () {
      final json = projectModel.toJson();
      expect(json, isNotNull);

      print(json);
      //projectModel.displayJson();
      //projectModel.display();
    });

    test('From JSON to model', () {
      final json = projectModel.toJson();
      projectModel.clear();
      expect(projectModel.isEmpty, isTrue);
      projectModel.fromJson(json);
      expect(projectModel.isEmpty, isFalse);

      projectModel.display();
    });

    test('From model entry to JSON', () {
      final json = projectModel.fromEntryToJson('Priority');
      expect(json, isNotNull);

      print(json);
      //projectModel.displayEntryJson("Priority");
      //projectModel.displayJson();
      //projectModel.display();
    });

    test('From JSON to model entry', () {
      final json = projectModel.fromEntryToJson('Priority');
      priorities.clear();
      expect(priorities.isEmpty, isTrue);
      projectModel.fromJsonToEntry(json);
      expect(priorities.isEmpty, isFalse);

      priorities.display(title: 'From JSON to model entry');
    });

    test('Add priority required error', () {
      // no required attribute that is not id
    });

    test('Add priority unique error', () {
      // no id attribute
    });

    test('Not found priority by oid', () {
      final ednetOid = Oid.ts(1345648254063);
      final priority = priorities.singleWhereOid(ednetOid);
      expect(priority, isNull);
    });

    test('Find priority by oid', () {
      final randomPriority = projectModel.priorities.random();
      final priority = priorities.singleWhereOid(randomPriority.oid);
      expect(priority, isNotNull);
      expect(priority, equals(randomPriority));
    });

    test('Find priority by attribute id', () {
      // no id attribute
    });

    test('Find priority by required attribute', () {
      // no required attribute that is not id
    });

    test('Find priority by attribute', () {
      // no attribute that is not required
    });

    test('Select priorities by attribute', () {
      // no attribute that is not required
    });

    test('Select priorities by required attribute', () {
      // no required attribute that is not id
    });

    test('Select priorities by attribute, then add', () {
      // no attribute that is not id
    });

    test('Select priorities by attribute, then remove', () {
      // no attribute that is not id
    });

    test('Sort priorities', () {
      // no id attribute
      // add compareTo method in the specific Priority class
      /* 
      priorities.sort(); 
 
      //priorities.display(title: "Sort priorities"); 
      */
    });

    test('Order priorities', () {
      // no id attribute
      // add compareTo method in the specific Priority class
      /* 
      var orderedPriorities = priorities.order(); 
      expect(orderedPriorities.isEmpty, isFalse); 
      expect(orderedPriorities.length, equals(priorities.length)); 
      expect(orderedPriorities.source?.isEmpty, isFalse); 
      expect(orderedPriorities.source?.length, equals(priorities.length)); 
      expect(orderedPriorities, isNot(same(priorities))); 
 
      //orderedPriorities.display(title: "Order priorities"); 
      */
    });

    test('Copy priorities', () {
      final copiedPriorities = priorities.copy();
      expect(copiedPriorities.isEmpty, isFalse);
      expect(copiedPriorities.length, equals(priorities.length));
      expect(copiedPriorities, isNot(same(priorities)));
      copiedPriorities
          .forEach((e) => expect(e, equals(priorities.singleWhereOid(e.oid))));

      //copiedPriorities.display(title: "Copy priorities");
    });

    test('True for every priority', () {
      // no required attribute that is not id
    });

    test('Random priority', () {
      final priority1 = projectModel.priorities.random();
      expect(priority1, isNotNull);
      final priority2 = projectModel.priorities.random();
      expect(priority2, isNotNull);

      //priority1.display(prefix: "random1");
      //priority2.display(prefix: "random2");
    });

    test('Update priority id with try', () {
      // no id attribute
    });

    test('Update priority id without try', () {
      // no id attribute
    });

    test('Update priority id with success', () {
      // no id attribute
    });

    test('Update priority non id attribute with failure', () {
      // no attribute that is not id
    });

    test('Copy Equality', () {
      final randomPriority = projectModel.priorities.random();
      randomPriority.display(prefix: 'before copy: ');
      final randomPriorityCopy = randomPriority.copy();
      randomPriorityCopy.display(prefix: 'after copy: ');
      expect(randomPriority, equals(randomPriorityCopy));
      expect(randomPriority.oid, equals(randomPriorityCopy.oid));
      expect(randomPriority.code, equals(randomPriorityCopy.code));
    });

    test('priority action undo and redo', () {
      var priorityCount = priorities.length;
      final priority = Priority(priorities.concept);
      priorities.add(priority);
      expect(priorities.length, equals(++priorityCount));
      priorities.remove(priority);
      expect(priorities.length, equals(--priorityCount));

      final action = AddCommand(session, priorities, priority);
      action.doIt();
      expect(priorities.length, equals(++priorityCount));

      action.undo();
      expect(priorities.length, equals(--priorityCount));

      action.redo();
      expect(priorities.length, equals(++priorityCount));
    });

    test('priority session undo and redo', () {
      var priorityCount = priorities.length;
      final priority = Priority(priorities.concept);
      priorities.add(priority);
      expect(priorities.length, equals(++priorityCount));
      priorities.remove(priority);
      expect(priorities.length, equals(--priorityCount));

      final action = AddCommand(session, priorities, priority);
      action.doIt();
      expect(priorities.length, equals(++priorityCount));

      session.past.undo();
      expect(priorities.length, equals(--priorityCount));

      session.past.redo();
      expect(priorities.length, equals(++priorityCount));
    });

    test('Priority update undo and redo', () {
      // no attribute that is not id
    });

    test('Priority action with multiple undos and redos', () {
      var priorityCount = priorities.length;
      final priority1 = projectModel.priorities.random();

      final action1 = RemoveCommand(session, priorities, priority1);
      action1.doIt();
      expect(priorities.length, equals(--priorityCount));

      final priority2 = projectModel.priorities.random();

      final action2 = RemoveCommand(session, priorities, priority2);
      action2.doIt();
      expect(priorities.length, equals(--priorityCount));

      //session.past.display();

      session.past.undo();
      expect(priorities.length, equals(++priorityCount));

      session.past.undo();
      expect(priorities.length, equals(++priorityCount));

      //session.past.display();

      session.past.redo();
      expect(priorities.length, equals(--priorityCount));

      session.past.redo();
      expect(priorities.length, equals(--priorityCount));

      //session.past.display();
    });

    test('Transaction undo and redo', () {
      var priorityCount = priorities.length;
      final priority1 = projectModel.priorities.random();
      var priority2 = projectModel.priorities.random();
      while (priority1 == priority2) {
        priority2 = projectModel.priorities.random();
      }
      final action1 = RemoveCommand(session, priorities, priority1);
      final action2 = RemoveCommand(session, priorities, priority2);

      final transaction = Transaction('two removes on priorities', session);
      transaction.add(action1);
      transaction.add(action2);
      transaction.doIt();
      priorityCount = priorityCount - 2;
      expect(priorities.length, equals(priorityCount));

      priorities.display(title: 'Transaction Done');

      session.past.undo();
      priorityCount = priorityCount + 2;
      expect(priorities.length, equals(priorityCount));

      priorities.display(title: 'Transaction Undone');

      session.past.redo();
      priorityCount = priorityCount - 2;
      expect(priorities.length, equals(priorityCount));

      priorities.display(title: 'Transaction Redone');
    });

    test('Transaction with one action error', () {
      final priorityCount = priorities.length;
      final priority1 = projectModel.priorities.random();
      final priority2 = priority1;
      final action1 = RemoveCommand(session, priorities, priority1);
      final action2 = RemoveCommand(session, priorities, priority2);

      final transaction = Transaction(
          'two removes on priorities, with an error on the second', session);
      transaction.add(action1);
      transaction.add(action2);
      final done = transaction.doIt();
      expect(done, isFalse);
      expect(priorities.length, equals(priorityCount));

      //priorities.display(title:"Transaction with an error");
    });

    test('Reactions to priority actions', () {
      var priorityCount = priorities.length;

      final reaction = PriorityReaction();
      expect(reaction, isNotNull);

      focusDomain.startCommandReaction(reaction);
      final priority = Priority(priorities.concept);
      priorities.add(priority);
      expect(priorities.length, equals(++priorityCount));
      priorities.remove(priority);
      expect(priorities.length, equals(--priorityCount));

      final session = focusDomain.newSession();
      final addCommand = AddCommand(session, priorities, priority);
      addCommand.doIt();
      expect(priorities.length, equals(++priorityCount));
      expect(reaction.reactedOnAdd, isTrue);

      // no attribute that is not id
    });
  });
}

class PriorityReaction implements ICommandReaction {
  bool reactedOnAdd = false;
  bool reactedOnUpdate = false;

  @override
  void react(ICommand action) {
    if (action is IEntitiesCommand) {
      reactedOnAdd = true;
    } else if (action is IEntityCommand) {
      reactedOnUpdate = true;
    }
  }
}

void main() {
  final repository = Repository();
  final focusDomain = repository.getDomainModels('Focus') as FocusDomain;
  final projectModel =
      focusDomain.getModelEntries('Project') as ProjectModel;
  final priorities = projectModel.priorities;
  testFocusProjectPriorities(focusDomain, projectModel, priorities);
}
