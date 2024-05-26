part of ednet_one; 
 
// lib/gen/ednet/one/skills.dart 
 
abstract class SkillGen extends Entity<Skill> { 
 
  SkillGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Skill newEntity() => Skill(concept); 
  Skills newEntities() => Skills(concept); 
  
} 
 
abstract class SkillsGen extends Entities<Skill> { 
 
  SkillsGen(Concept concept) { 
    this.concept = concept; 
  } 
 
  Skills newEntities() => Skills(concept); 
  Skill newEntity() => Skill(concept); 
  
} 
 
