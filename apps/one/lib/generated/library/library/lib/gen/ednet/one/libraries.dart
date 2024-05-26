part of ednet_one; 
 
// lib/gen/ednet/one/libraries.dart 
 
abstract class LibraryGen extends Entity<Library> { 
 
  LibraryGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Library newEntity() => Library(concept); 
  Libraries newEntities() => Libraries(concept); 
  
} 
 
abstract class LibrariesGen extends Entities<Library> { 
 
  LibrariesGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Libraries newEntities() => Libraries(concept); 
  Library newEntity() => Library(concept); 
  
} 
 
