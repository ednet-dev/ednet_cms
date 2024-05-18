// test/focus/project/focus_project_task_test.dart

import 'package:test/test.dart';
import 'package:ednet_core/ednet_core.dart';
import 'package:focus_project/focus_project.dart';

void testFocusProjectTasks(
    FocusDomain focusDomain, ProjectModel projectModel, Tasks tasks) {
  DomainSession session;
  group('Testing Focus.Project.Task', () {
    session = focusDomain.newSession();
    setUp(() {
      projectModel.init();
    });
    tearDown(() {
      projectModel.clear();
    });

    test('Not empty model', () {
      expect(projectModel.isEmpty, isFalse);
      expect(tasks.isEmpty, isFalse);
    });

    test('Empty model', () {
      projectModel.clear();
      expect(projectModel.isEmpty, isTrue);
      expect(tasks.isEmpty, isTrue);
      expect(tasks.exceptions.isEmpty, isTrue);
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
      final json = projectModel.fromEntryToJson('Task');
      expect(json, isNotNull);

      print(json);
      //projectModel.displayEntryJson("Task");
      //projectModel.displayJson();
      //projectModel.display();
    });

    test('From JSON to model entry', () {
      final json = projectModel.fromEntryToJson('Task');
      tasks.clear();
      expect(tasks.isEmpty, isTrue);
      projectModel.fromJsonToEntry(json);
      expect(tasks.isEmpty, isFalse);

      tasks.display(title: 'From JSON to model entry');
    });

    test('Add task required error', () {
      // no required attribute that is not id
    });

    test('Add task unique error', () {
      // no id attribute
    });

    test('Not found task by oid', () {
      final ednetOid = Oid.ts(1345648254063);
      final task = tasks.singleWhereOid(ednetOid);
      expect(task, isNull);
    });

    test('Find task by oid', () {
      final randomTask = projectModel.tasks.random();
      final task = tasks.singleWhereOid(randomTask.oid);
      expect(task, isNotNull);
      expect(task, equals(randomTask));
    });

    test('Find task by attribute id', () {
      // no id attribute
    });

    test('Find task by required attribute', () {
      // no required attribute that is not id
    });

    test('Find task by attribute', () {
      // no attribute that is not required
    });

    test('Select tasks by attribute', () {
      // no attribute that is not required
    });

    test('Select tasks by required attribute', () {
      // no required attribute that is not id
    });

    test('Select tasks by attribute, then add', () {
      // no attribute that is not id
    });

    test('Select tasks by attribute, then remove', () {
      // no attribute that is not id
    });

    test('Sort tasks', () {
      // no id attribute
      // add compareTo method in the specific Task class
      /* 
      tasks.sort(); 
 
      //tasks.display(title: "Sort tasks"); 
      */
    });

    test('Order tasks', () {
      // no id attribute
      // add compareTo method in the specific Task class
      /* 
      var orderedTasks = tasks.order(); 
      expect(orderedTasks.isEmpty, isFalse); 
      expect(orderedTasks.length, equals(tasks.length)); 
      expect(orderedTasks.source?.isEmpty, isFalse); 
      expect(orderedTasks.source?.length, equals(tasks.length)); 
      expect(orderedTasks, isNot(same(tasks))); 
 
      //orderedTasks.display(title: "Order tasks"); 
      */
    });

    test('Copy tasks', () {
      final copiedTasks = tasks.copy();
      expect(copiedTasks.isEmpty, isFalse);
      expect(copiedTasks.length, equals(tasks.length));
      expect(copiedTasks, isNot(same(tasks)));
      copiedTasks
          .forEach((e) => expect(e, equals(tasks.singleWhereOid(e.oid))));

      //copiedTasks.display(title: "Copy tasks");
    });

    test('True for every task', () {
      // no required attribute that is not id
    });

    test('Random task', () {
      final task1 = projectModel.tasks.random();
      expect(task1, isNotNull);
      final task2 = projectModel.tasks.random();
      expect(task2, isNotNull);

      //task1.display(prefix: "random1");
      //task2.display(prefix: "random2");
    });

    test('Update task id with try', () {
      // no id attribute
    });

    test('Update task id without try', () {
      // no id attribute
    });

    test('Update task id with success', () {
      // no id attribute
    });

    test('Update task non id attribute with failure', () {
      // no attribute that is not id
    });

    test('Copy Equality', () {
      final randomTask = projectModel.tasks.random();
      randomTask.display(prefix: 'before copy: ');
      final randomTaskCopy = randomTask.copy();
      randomTaskCopy.display(prefix: 'after copy: ');
      expect(randomTask, equals(randomTaskCopy));
      expect(randomTask.oid, equals(randomTaskCopy.oid));
      expect(randomTask.code, equals(randomTaskCopy.code));
    });

    test('task action undo and redo', () {
      var taskCount = tasks.length;
      final task = Task(tasks.concept);
      tasks.add(task);
      expect(tasks.length, equals(++taskCount));
      tasks.remove(task);
      expect(tasks.length, equals(--taskCount));

      final action = AddCommand(session, tasks, task);
      action.doIt();
      expect(tasks.length, equals(++taskCount));

      action.undo();
      expect(tasks.length, equals(--taskCount));

      action.redo();
      expect(tasks.length, equals(++taskCount));
    });

    test('task session undo and redo', () {
      var taskCount = tasks.length;
      final task = Task(tasks.concept);
      tasks.add(task);
      expect(tasks.length, equals(++taskCount));
      tasks.remove(task);
      expect(tasks.length, equals(--taskCount));

      final action = AddCommand(session, tasks, task);
      action.doIt();
      expect(tasks.length, equals(++taskCount));

      session.past.undo();
      expect(tasks.length, equals(--taskCount));

      session.past.redo();
      expect(tasks.length, equals(++taskCount));
    });

    test('Task update undo and redo', () {
      // no attribute that is not id
    });

    test('Task action with multiple undos and redos', () {
      var taskCount = tasks.length;
      final task1 = projectModel.tasks.random();

      final action1 = RemoveCommand(session, tasks, task1);
      action1.doIt();
      expect(tasks.length, equals(--taskCount));

      final task2 = projectModel.tasks.random();

      final action2 = RemoveCommand(session, tasks, task2);
      action2.doIt();
      expect(tasks.length, equals(--taskCount));

      //session.past.display();

      session.past.undo();
      expect(tasks.length, equals(++taskCount));

      session.past.undo();
      expect(tasks.length, equals(++taskCount));

      //session.past.display();

      session.past.redo();
      expect(tasks.length, equals(--taskCount));

      session.past.redo();
      expect(tasks.length, equals(--taskCount));

      //session.past.display();
    });

    test('Transaction undo and redo', () {
      var taskCount = tasks.length;
      final task1 = projectModel.tasks.random();
      var task2 = projectModel.tasks.random();
      while (task1 == task2) {
        task2 = projectModel.tasks.random();
      }
      final action1 = RemoveCommand(session, tasks, task1);
      final action2 = RemoveCommand(session, tasks, task2);

      final transaction = Transaction('two removes on tasks', session);
      transaction.add(action1);
      transaction.add(action2);
      transaction.doIt();
      taskCount = taskCount - 2;
      expect(tasks.length, equals(taskCount));

      tasks.display(title: 'Transaction Done');

      session.past.undo();
      taskCount = taskCount + 2;
      expect(tasks.length, equals(taskCount));

      tasks.display(title: 'Transaction Undone');

      session.past.redo();
      taskCount = taskCount - 2;
      expect(tasks.length, equals(taskCount));

      tasks.display(title: 'Transaction Redone');
    });

    test('Transaction with one action error', () {
      final taskCount = tasks.length;
      final task1 = projectModel.tasks.random();
      final task2 = task1;
      final action1 = RemoveCommand(session, tasks, task1);
      final action2 = RemoveCommand(session, tasks, task2);

      final transaction = Transaction(
          'two removes on tasks, with an error on the second', session);
      transaction.add(action1);
      transaction.add(action2);
      final done = transaction.doIt();
      expect(done, isFalse);
      expect(tasks.length, equals(taskCount));

      //tasks.display(title:"Transaction with an error");
    });

    test('Reactions to task actions', () {
      var taskCount = tasks.length;

      final reaction = TaskReaction();
      expect(reaction, isNotNull);

      focusDomain.startCommandReaction(reaction);
      final task = Task(tasks.concept);
      tasks.add(task);
      expect(tasks.length, equals(++taskCount));
      tasks.remove(task);
      expect(tasks.length, equals(--taskCount));

      final session = focusDomain.newSession();
      final addCommand = AddCommand(session, tasks, task);
      addCommand.doIt();
      expect(tasks.length, equals(++taskCount));
      expect(reaction.reactedOnAdd, isTrue);

      // no attribute that is not id
    });
  });
}

class TaskReaction implements ICommandReaction {
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
  final tasks = projectModel.tasks;
  testFocusProjectTasks(focusDomain, projectModel, tasks);
}
