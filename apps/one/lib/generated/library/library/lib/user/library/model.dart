 
part of user_library; 
 
// lib/user/library/model.dart 
 
class LibraryModel extends LibraryEntries { 
 
  LibraryModel(Model model) : super(model); 
 
  void fromJsonToLibraryEntry() { 
    fromJsonToEntry(userLibraryLibraryEntry); 
  } 
 
  void fromJsonToModel() { 
    fromJson(userLibraryModel); 
  } 
 
  void init() { 
    initLibraries(); 
  } 
 
  void initLibraries() { 
    var library1 = Library(libraries.concept); 
    libraries.add(library1); 
 
    var library2 = Library(libraries.concept); 
    libraries.add(library2); 
 
    var library3 = Library(libraries.concept); 
    libraries.add(library3); 
 
  } 
 
  // added after code gen - begin 
 
  // added after code gen - end 
 
} 
 