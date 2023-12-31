abstract class NotesStates {}

class NotesInitState extends NotesStates{}
class AddToNotesSuccess extends NotesStates{
  
}
class ErrorAddToNotes extends NotesStates{}
class GetNotes extends NotesStates{}
class ErrorGetNotes extends NotesStates{}
class DeleteNotes extends NotesStates{}
class ErrorDeleteNotes extends NotesStates{}
class DatabaseCreatedState extends NotesStates {}

class DatabaseGetState extends NotesStates {}

class DatabaseGetLoadingState extends NotesStates {}

class DatabaseInsertedState extends NotesStates {}
class DatabaseUpdateState extends NotesStates {}

class DatabaseDeleteState extends NotesStates {}