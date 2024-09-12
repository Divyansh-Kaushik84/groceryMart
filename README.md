Brief Descriptions of Each XCUITest Case

testExample
Description: A placeholder test case that launches the app but does not perform any specific test actions. It is meant to demonstrate the basic setup for an XCUITest case.


test_BrowsingTheList

Description: Tests the ability to browse through the grocery list.
Steps:
Verify the grocery list is displayed.
Check that items are present in the grid.
Tap on the first item and ensure the details view is displayed.
Verify the item name on the details view is correct.


test_AddingToFavoritesList

Description: Tests the functionality of adding an item to the favorites list.
Steps:
Ensure the grocery list is displayed.
Tap on the first item to navigate to its detail view.
Verify the presence of the "Add To Favorites" button and tap it.
Navigate back to the main view and tap the heart icon to access the favorites list.
Verify the favorites list is displayed and check if the added item appears in the list.


test_RemovingFromFavoritesList

Description: Tests the functionality of removing an item from the favorites list.
Steps:
Add an item to the favorites list (similar steps as in test_AddingToFavoritesList).
Navigate to the favorites list and verify the item is present.
Tap the remove button to remove the item from the list.
Verify the item is no longer present in the favorites list.


test_FavoritesPersistAfterRelaunch

Description: Tests that the favorites list persists after the app is relaunched.
Steps:
Add an item to the favorites list (similar steps as in test_AddingToFavoritesList).
Close and relaunch the app.
Navigate to the favorites list again and verify the item is still present after relaunch.
testLaunchPerformance
Description: Measures the performance of the app launch process.
Steps:
The test measures how long it takes for the app to launch.
This performance metric helps in assessing app startup time and overall performance efficiency.
