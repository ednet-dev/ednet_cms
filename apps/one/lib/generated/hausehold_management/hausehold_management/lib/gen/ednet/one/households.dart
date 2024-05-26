part of ednet_one; 
 
// lib/gen/ednet/one/households.dart 
 
abstract class HouseholdGen extends Entity<Household> { 
 
  HouseholdGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Household newEntity() => Household(concept); 
  Households newEntities() => Households(concept); 
  
} 
 
abstract class HouseholdsGen extends Entities<Household> { 
 
  HouseholdsGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Households newEntities() => Households(concept); 
  Household newEntity() => Household(concept); 
  
} 
 
