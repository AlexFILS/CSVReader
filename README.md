# CSVReader
Assignment

# TOOLS:

- Xcode Version 14.0.1 
- Target API: 16.0
- Swift version: 5


# Description
  The application can be used to read the "Issues.csv" provided for this assignment. 
  As-is, the CSV reader can open and view only the contents of this CSV. To demonstrate the capabilities of my implementation, I have added a 2nd CSV reader
called "BattingReader'. This reader is capabel of opening and displaying the contents of the "Batting.csv" which I included in this repo.
  In order to make the app capable of reading and showing the "Batting.csv" file, the correct reader needs to be injected in the view model of the main screen.
  Any CSV reader can be created and injected in the view model, as follows:
  1. Create the CSV reader class and implement CSVReaderType.
  2. Create your parsing methods (the way your reader views the raw data and transforms it into Swift objects)
  3. Inject the reader in the view model (from the MainCoordinator)
  Additionally: 
  4. Create your own implementation of how the data will be displayed in the table view, inject it in the CSvDataViewModel.
  
  
