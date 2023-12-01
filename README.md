elevator test task 


device_preview: ^1.1.0


Libraries:
- go_router - declarative routing 
- ionicons - icons images pack
- provide - state manager
- drift - SQLite library
- pigeon - communication between Flutter and Native 

-----------------------------------------------------
This is the simple elevator test. 
Unfortunately some features ( implementing portrait mode and background notification 
aren't implemented on iOS platform)

Layout:
Portrait mode only with responsive design almost according to Figma design


1. First screen
 Show after startup with logo image. Back button press with toast Implemented.
2. Second screen
 Load data ( house names and floors counter) from SQLite database 
 Show SLiver app bar with "Add house" button and sliver list with clickable items
 If "Add house" is pressed the dialog is shown. Some background blur is implemented
 
3. "Add house" Dialog
 Cross button - to exit from dialog
 Add button - to insert data to SQLite database and sliver list
 Name input field - max length is 16 symbols
 Floors count input field - max length is 3 symbols
 Check input for correct input (error message not implemented)
 Provider is used to pass data entered in dialog to the second screen. 
 ('Cause dialog is descendant of MyApp)

4. Third screen
Show sliver list. The number of elements is equal to the floors count. 
The first floor is selected by green color
After entering to the third screen the background notification mechanism is invoked
If element is tapped it's selected by yellow color.It means that is "move to" position
Elevator starts. And every 3 second green item moves towards to yellow item.


Not implemented:
1. App icon and splash screen
2. Localization
3. Service locator or DI container
4. Architecture concepts

-------------------------------------------------------
