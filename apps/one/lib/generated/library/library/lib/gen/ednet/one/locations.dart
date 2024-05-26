part of ednet_one; 
 
// lib/gen/ednet/one/locations.dart 
 
abstract class LocationGen extends Entity<Location> { 
 
  LocationGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Location newEntity() => Location(concept); 
  Locations newEntities() => Locations(concept); 
  
} 
 
abstract class LocationsGen extends Entities<Location> { 
 
  LocationsGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Locations newEntities() => Locations(concept); 
  Location newEntity() => Location(concept); 
  
} 
 
