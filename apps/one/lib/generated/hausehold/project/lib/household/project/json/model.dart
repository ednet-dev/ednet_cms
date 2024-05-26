part of household_project;

// http://www.json.org/
// http://jsonformatter.curiousconcept.com/

// lib/household/project/json/model.dart

var householdProjectModelJson = r'''
domain: 'household'
model: 'project'
concepts:
  - name: Project
    entry: true
    attributes:
      - sequence: 1
        category: attribute
        name: name
        type: String
        essential: true
        sensitive: false
  - name: Task
  - name: Milestone
  - name: Resource
  - name: Role
  - name: Team
  - name: Skill
  - name: Time
  - name: Budget
  - name: Initiative


''';
  