part of ednet_one; 
 
// lib/gen/ednet/one/seriess.dart 
 
abstract class SeriesGen extends Entity<Series> { 
 
  SeriesGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Series newEntity() => Series(concept); 
  Seriess newEntities() => Seriess(concept); 
  
} 
 
abstract class SeriessGen extends Entities<Series> { 
 
  SeriessGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Seriess newEntities() => Seriess(concept); 
  Series newEntity() => Series(concept); 
  
} 
 
