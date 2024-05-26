part of ednet_one; 
 
// lib/gen/ednet/one/genres.dart 
 
abstract class GenreGen extends Entity<Genre> { 
 
  GenreGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Genre newEntity() => Genre(concept); 
  Genres newEntities() => Genres(concept); 
  
} 
 
abstract class GenresGen extends Entities<Genre> { 
 
  GenresGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Genres newEntities() => Genres(concept); 
  Genre newEntity() => Genre(concept); 
  
} 
 
