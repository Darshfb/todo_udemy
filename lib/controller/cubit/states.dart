abstract class TodoStates {}

class InitialTodoState extends TodoStates {}

class CreateTodoDatabaseState extends TodoStates {}

class SuccessInsertToDatabaseState extends TodoStates {}

class SuccessGettingDataFromDatabaseState extends TodoStates {}

class LoadingGetDataFromDatabaseState extends TodoStates {}

class DeletingDataFromDatabaseState extends TodoStates {}

class SuccessUpdatingDataFromDatabaseState extends TodoStates {}

class ChangeLanguageToEnglishState extends TodoStates {}

class ChangeLanguageToArabicState extends TodoStates {}
