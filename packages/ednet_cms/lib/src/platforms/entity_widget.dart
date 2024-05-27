part of ednet_cms;

// Widget for String attribute
class StringAttributeWidget extends StatelessWidget {
  final String label;
  final String value;
  final Function(String) onChanged;

  StringAttributeWidget({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      controller: TextEditingController(text: value),
      onChanged: onChanged,
    );
  }
}

// Widget for int attribute
class IntAttributeWidget extends StatelessWidget {
  final String label;
  final int value;
  final Function(int) onChanged;

  IntAttributeWidget({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      controller: TextEditingController(text: value.toString()),
      keyboardType: TextInputType.number,
      onChanged: (text) => onChanged(int.tryParse(text) ?? 0),
    );
  }
}

// Widget for double attribute
class DoubleAttributeWidget extends StatelessWidget {
  final String label;
  final double value;
  final Function(double) onChanged;

  DoubleAttributeWidget({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      controller: TextEditingController(text: value.toString()),
      keyboardType: TextInputType.number,
      onChanged: (text) => onChanged(double.tryParse(text) ?? 0.0),
    );
  }
}

// Widget for bool attribute
class BoolAttributeWidget extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool) onChanged;

  BoolAttributeWidget({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

// Widget for DateTime attribute
class DateTimeAttributeWidget extends StatelessWidget {
  final String label;
  final DateTime value;
  final Function(DateTime) onChanged;

  DateTimeAttributeWidget({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        TextButton(
          onPressed: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: value,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null && picked != value) onChanged(picked);
          },
          child: Text(value.toLocal().toString().split(' ')[0]),
        ),
      ],
    );
  }
}

String getTitle(Entity<dynamic> entity) {
  var name = entity.getStringFromAttribute('name');
  var title = entity.getStringFromAttribute('title');
  return name != null ? name : title ?? 'Unnamed Entity';
}

class EntityDetailScreen extends StatelessWidget {
  final Entity entity;

  EntityDetailScreen({required this.entity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entity.getStringFromAttribute('name') ?? 'Entity Detail'),
      ),
      body: EntityWidget(entity: entity),
    );
  }
}

class EntityWidget extends StatelessWidget {
  final Entity entity;
  final void Function(Entity entity)? onEntitySelected;

  EntityWidget({required this.entity, this.onEntitySelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ...entity.concept.attributes.map((attribute) {
            var value = entity.getAttribute(attribute.code);
            return _buildAttributeWidget(attribute as Attribute, value);
          }).toList(),
          ...entity.concept.parents.map((parent) {
            var parentEntity = entity.getParent(parent.code) as Entity;
            return ListTile(
              title: Text('${getTitle(parentEntity)}'),
              onTap: () {
                if (onEntitySelected != null) {
                  onEntitySelected!(parentEntity);
                }
              },
            );
          }).toList(),
          ...entity.concept.children.map((child) {
            var childEntities = entity.getChild(child.code) as Entities?;
            return childEntities != null
                ? ExpansionTile(
                    title: Text('${child.codeFirstLetterUpper}',
                        style: Theme.of(context).textTheme.labelLarge),
                    children: childEntities.map((childEntity) {
                      return ListTile(
                        title: Text(getTitle(childEntity),
                            style: Theme.of(context).textTheme.labelMedium),
                        onTap: () {
                          if (onEntitySelected != null) {
                            onEntitySelected!(childEntity as Entity);
                          }
                        },
                      );
                    }).toList(),
                  )
                : Container();
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAttributeWidget(Attribute attribute, dynamic value) {
    switch (attribute.type?.code) {
      case 'String':
        return StringAttributeWidget(
          label: attribute.code,
          value: value as String,
          onChanged: (newValue) {
            entity.setAttribute(attribute.code, newValue);
          },
        );
      case 'int':
        return IntAttributeWidget(
          label: attribute.code,
          value: value as int,
          onChanged: (newValue) {
            entity.setAttribute(attribute.code, newValue);
          },
        );
      case 'double':
        return DoubleAttributeWidget(
          label: attribute.code,
          value: value as double,
          onChanged: (newValue) {
            entity.setAttribute(attribute.code, newValue);
          },
        );
      case 'bool':
        return BoolAttributeWidget(
          label: attribute.code,
          value: value as bool,
          onChanged: (newValue) {
            entity.setAttribute(attribute.code, newValue);
          },
        );
      case 'DateTime':
        return DateTimeAttributeWidget(
          label: attribute.code,
          value: value as DateTime,
          onChanged: (newValue) {
            entity.setAttribute(attribute.code, newValue);
          },
        );
      default:
        return Container();
    }
  }
}

// Widget for Entities, updated to navigate models and domains
class EntitiesWidget extends StatelessWidget {
  final Entities entities;
  final void Function(Entity entity)? onEntitySelected;
  final Domain domain;
  final Model model;

  EntitiesWidget({
    required this.entities,
    this.onEntitySelected,
    required this.domain,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Back to Models'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: entities.length,
          itemBuilder: (context, index) {
            var entity = entities.elementAt(index);
            return ListTile(
              title: Text(getTitle(entity)),
              onTap: () {
                if (onEntitySelected != null) {
                  onEntitySelected!(entity as Entity);
                }
              },
            );
          },
        ),
      ],
    );
  }
}
