part of ednet_one; 
 
// lib/gen/ednet/one/games.dart 
 
abstract class GameGen extends Entity<Game> { 
 
  GameGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Game newEntity() => Game(concept); 
  Games newEntities() => Games(concept); 
  
} 
 
abstract class GamesGen extends Entities<Game> { 
 
  GamesGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Games newEntities() => Games(concept); 
  Game newEntity() => Game(concept); 
  
} 
 
