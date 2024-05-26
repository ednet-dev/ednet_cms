 
part of household_finances; 
 
// lib/household/finances/model.dart 
 
class FinancesModel extends FinancesEntries { 
 
  FinancesModel(Model model) : super(model); 
 
  void fromJsonToFinanceEntry() { 
    fromJsonToEntry(householdFinancesFinanceEntry); 
  } 
 
  void fromJsonToModel() { 
    fromJson(householdFinancesModel); 
  } 
 
  void init() { 
    initFinances(); 
  } 
 
  void initFinances() { 
    var finance1 = Finance(finances.concept); 
    finance1.name = 'authority'; 
    finances.add(finance1); 
 
    var finance2 = Finance(finances.concept); 
    finance2.name = 'interest'; 
    finances.add(finance2); 
 
    var finance3 = Finance(finances.concept); 
    finance3.name = 'understanding'; 
    finances.add(finance3); 
 
  } 
 
  // added after code gen - begin 
 
  // added after code gen - end 
 
} 
 
