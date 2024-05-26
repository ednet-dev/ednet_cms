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
      - sequence: 2
        category: attribute
        name: description
        type: String
        essential: false
        sensitive: false
      - sequence: 3
        category: attribute
        name: startDate
        type: DateTime
        essential: true
        sensitive: false
      - sequence: 4
        category: attribute
        name: endDate
        type: DateTime
        essential: false
        sensitive: false
      - sequence: 5
        category: attribute
        name: budget
        type: double
        essential: false
        sensitive: false

  - name: Task
    entry: true
    attributes:
      - sequence: 1
        category: attribute
        name: title
        type: String
        essential: true
        sensitive: false
      - sequence: 2
        category: attribute
        name: dueDate
        type: DateTime
        essential: true
        sensitive: false
      - sequence: 3
        category: attribute
        name: status
        type: String
        essential: true
        sensitive: false
      - sequence: 4
        category: attribute
        name: priority
        type: String
        essential: false
        sensitive: false

  - name: Milestone
    entry: true
    attributes:
      - sequence: 1
        category: attribute
        name: name
        type: String
        essential: true
        sensitive: false
      - sequence: 2
        category: attribute
        name: date
        type: DateTime
        essential: true
        sensitive: false

  - name: Resource
    entry: true
    attributes:
      - sequence: 1
        category: attribute
        name: name
        type: String
        essential: true
        sensitive: false
      - sequence: 2
        category: attribute
        name: type
        type: String
        essential: true
        sensitive: false
      - sequence: 3
        category: attribute
        name: cost
        type: double
        essential: false
        sensitive: false

  - name: Role
    entry: true
    attributes:
      - sequence: 1
        category: attribute
        name: title
        type: String
        essential: true
        sensitive: false
      - sequence: 2
        category: attribute
        name: responsibility
        type: String
        essential: true
        sensitive: false

  - name: Team
    entry: true
    attributes:
      - sequence: 1
        category: attribute
        name: name
        type: String
        essential: true
        sensitive: false

  - name: Skill
    entry: true
    attributes:
      - sequence: 1
        category: attribute
        name: name
        type: String
        essential: true
        sensitive: false
      - sequence: 2
        category: attribute
        name: level
        type: String
        essential: false
        sensitive: false

  - name: Time
    entry: true
    attributes:
      - sequence: 1
        category: attribute
        name: hours
        type: int
        essential: true
        sensitive: false

  - name: Budget
    entry: true
    attributes:
      - sequence: 1
        category: attribute
        name: amount
        type: double
        essential: true
        sensitive: false
      - sequence: 2
        category: attribute
        name: currency
        type: String
        essential: true
        sensitive: false

  - name: Initiative
    entry: true
    attributes:
      - sequence: 1
        category: attribute
        name: name
        type: String
        essential: true
        sensitive: false

relations:
  - from: Project
    to: Task
    fromToName: tasks
    fromToMin: '0'
    fromToMax: 'N'
    toFromName: project
    toFromMin: '1'
    toFromMax: '1'
    internal: false
    category: 'association'

  - from: Project
    to: Milestone
    fromToName: milestones
    fromToMin: '0'
    fromToMax: 'N'
    toFromName: project
    toFromMin: '1'
    toFromMax: '1'
    internal: false
    category: 'association'

  - from: Task
    to: Resource
    fromToName: resources
    fromToMin: '0'
    fromToMax: 'N'
    toFromName: task
    toFromMin: '1'
    toFromMax: '1'
    internal: false
    category: 'association'

  - from: Team
    to: Role
    fromToName: roles
    fromToMin: '0'
    fromToMax: 'N'
    toFromName: team
    toFromMin: '1'
    toFromMax: '1'
    internal: false
    category: 'association'

  - from: Resource
    to: Skill
    fromToName: skills
    fromToMin: '0'
    fromToMax: 'N'
    toFromName: resource
    toFromMin: '1'
    toFromMax: '1'
    internal: false
    category: 'association'

  - from: Project
    to: Team
    fromToName: teams
    fromToMin: '0'
    fromToMax: 'N'
    toFromName: project
    toFromMin: '1'
    toFromMax: '1'
    internal: false
    category: 'association'

  - from: Project
    to: Budget
    fromToName: budgets
    fromToMin: '0'
    fromToMax: 'N'
    toFromName: project
    toFromMin: '1'
    toFromMax: '1'
    internal: false
    category: 'association'

  - from: Project
    to: Initiative
    fromToName: initiatives
    fromToMin: '0'
    fromToMax: 'N'
    toFromName: project
    toFromMin: '1'
    toFromMax: '1'
    internal: false
    category: 'association'

  - from: Project
    to: Time
    fromToName: times
    fromToMin: '0'
    fromToMax: 'N'
    toFromName: project
    toFromMin: '1'
    toFromMax: '1'
    internal: false
    category: 'association'


''';
  