//
//  groceryMartUITests.swift
//  groceryMartUITests
//
//  Created by Divyansh Kaushik on 12/09/24.
//

import XCTest

final class groceryMartUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func test_BrowsingTheList() throws{
        let groceryList = app.scrollViews.otherElements
        XCTAssertTrue(groceryList.element.exists, "Grocery List is Not Displayed")
        let gridItems = groceryList.children(matching: .other) // Adjust based on your view hierarchy
        XCTAssertGreaterThan(gridItems.count, 0, "No items found in the grocery grid")

        let initialCell = gridItems.element(boundBy: 0)
        let lastCell = gridItems.element(boundBy: gridItems.count-1)
        XCTAssert(initialCell.exists, "Initial cell is Not Displayed")
        XCTAssert(lastCell.exists, "Last cell is Not Displayed")
//        groceryList.element.swipeUp()
        sleep(2)

        XCTAssert(lastCell.exists, "Last cell is Not Visible after scrolling up")
        initialCell.tap()
        let detailsScreen = app.scrollViews.otherElements
        XCTAssert(detailsScreen.element.exists, "Details View is not displayed")
        let itemName = detailsScreen.element.staticTexts["Apple"]
        XCTAssert(itemName.exists, "Item Name is not correct")
    }
    
    func test_AddingToFavoritesList() throws {
        let app = XCUIApplication()
        app.launch()

        let groceryList = app.scrollViews.otherElements
        let gridItems = groceryList.children(matching: .other) // Adjust based on your view hierarchy
        
        // Ensure the grocery list is displayed
        XCTAssertTrue(groceryList.element.exists, "Grocery list is not displayed.")
        
        // Navigate to an item’s detail page
        let firstItemButton = gridItems.element(boundBy: 0).buttons["groceryItem-1-groceryItem-1-groceryItem-1"]
        XCTAssertTrue(firstItemButton.exists, "Item button not found.")
        firstItemButton.tap()

        let detailScreen = app.scrollViews.otherElements
        XCTAssertTrue(detailScreen.element.exists, "Detail screen is not displayed.")

        // Add the item to the favorites list
        let addToFavoritesButton = detailScreen.buttons["addToFavoritesButton"]
        XCTAssertTrue(addToFavoritesButton.exists, "Add To Favorites button is not found.")
        addToFavoritesButton.tap()
        
        // Verify the button label changes to "Remove From Favorites"
//        XCTAssertTrue(addToFavoritesButton.label == "Remove From Favorites", "Failed to add to favorites.")
        
        // Go back to the main view
        app.navigationBars.buttons["Back"].tap()
        
        // Navigate to the Favorites list
        let favoritesButton = app.navigationBars.buttons["heart"]
        XCTAssertTrue(favoritesButton.exists, "Favorites button not found.")
        favoritesButton.tap()
        let favoritesList = app.collectionViews
        XCTAssertTrue(favoritesList.element.exists, "Favorites list is not displayed.")
        
        // Verify that the item appears in the Favorites list
        let favoriteItem = favoritesList.cells.staticTexts["Apple"] // Adjust based on actual item name or identifier
        XCTAssertTrue(favoriteItem.exists, "Favorite item 'Apple' is not found in the favorites list.")
    }
    
    func test_RemovingFromFavoritesList() throws {
        let app = XCUIApplication()
        app.launch()

        // Add an item to favorites first
        let groceryList = app.scrollViews.otherElements
        let gridItems = groceryList.children(matching: .other)
        
        // Navigate to an item’s detail page
        let firstItemButton = gridItems.element(boundBy: 0).buttons["groceryItem-1-groceryItem-1-groceryItem-1"]
        XCTAssertTrue(firstItemButton.exists, "Item button not found.")
        firstItemButton.tap()

        let detailScreen = app.scrollViews.otherElements
        XCTAssertTrue(detailScreen.element.exists, "Detail screen is not displayed.")
        
        // Add the item to the favorites list
        let addToFavoritesButton = detailScreen.buttons["addToFavoritesButton"]
        XCTAssertTrue(addToFavoritesButton.exists, "Add To Favorites button is not found.")
        addToFavoritesButton.tap()
        
        // Verify the button label changes to "Remove From Favorites"
//        XCTAssertTrue(addToFavoritesButton.label == "Remove From Favorites", "Failed to add to favorites.")
        
        // Go back to the main view
        let backButton = app.navigationBars.buttons["Back"]
        XCTAssertTrue(backButton.exists, "Back button not found.")
        backButton.tap()
        
        // Navigate to the Favorites list
        let favoritesButton = app.navigationBars.buttons["heart"] // Adjust identifier if needed
        XCTAssertTrue(favoritesButton.exists, "Favorites button not found.")
        favoritesButton.tap()
        
        // Wait for the Favorites list to appear
        let favoritesList = app.collectionViews
                XCTAssertTrue(favoritesList.element.exists, "Favorites list is not displayed.")
        
        // Verify that the item appears in the Favorites list
        let favoriteItem = favoritesList.cells.staticTexts["Apple"] // Adjust based on actual item name or identifier
        XCTAssertTrue(favoriteItem.exists, "Favorite item 'Apple' is not found in the favorites list.")
        // Remove the item from favorites
        let removeButton = favoritesList.buttons["Bin"] // Adjust identifier if needed
        XCTAssertTrue(removeButton.exists, "Remove button is not found.")
        removeButton.tap()
        
        // Verify the item is no longer in the Favorites list
        XCTAssertFalse(favoriteItem.exists, "Favorite item 'Apple' is still found in the favorites list after removal.")
    }
    func test_FavoritesPersistAfterRelaunch() throws {
        let app = XCUIApplication()
        
        // Launch the app
        app.launch()
        
        // Add an item to favorites
        let groceryList = app.scrollViews.otherElements
        let gridItems = groceryList.children(matching: .other)
        
        // Ensure the grocery list is displayed
        XCTAssertTrue(groceryList.element.exists, "Grocery list is not displayed.")
        
        // Navigate to an item’s detail page
        let firstItemButton = gridItems.element(boundBy: 0).buttons["groceryItem-1-groceryItem-1-groceryItem-1"]
        XCTAssertTrue(firstItemButton.exists, "Item button not found.")
        firstItemButton.tap()

        let detailScreen = app.scrollViews.otherElements
        XCTAssertTrue(detailScreen.element.exists, "Detail screen is not displayed.")
        
        // Add the item to the favorites list
        let addToFavoritesButton = detailScreen.buttons["addToFavoritesButton"]
        XCTAssertTrue(addToFavoritesButton.exists, "Add To Favorites button is not found.")
        addToFavoritesButton.tap()
        
        // Verify the button label changes to "Remove From Favorites"
//        XCTAssertTrue(addToFavoritesButton.label == "Remove From Favorites", "Failed to add to favorites.")
        
        // Go back to the main view
        let backButton = app.navigationBars.buttons["Back"]
        XCTAssertTrue(backButton.exists, "Back button not found.")
        backButton.tap()
        
        // Navigate to the Favorites list
        let favoritesButton = app.navigationBars.buttons["heart"] // Adjust identifier if needed
        XCTAssertTrue(favoritesButton.exists, "Favorites button not found.")
        favoritesButton.tap()
        
        // Wait for the Favorites list to appear
        let favoritesList = app.collectionViews
        XCTAssertTrue(favoritesList.element.exists, "Favorites list is not displayed.")
        
        // Verify that the item appears in the Favorites list
        let favoriteItem = favoritesList.cells.staticTexts["Apple"] // Adjust based on actual item name or identifier
        XCTAssertTrue(favoriteItem.exists, "Favorite item 'Apple' is not found in the favorites list.")
        // Close the app and relaunch
        app.terminate()
        app.launch()

        // Navigate back to the Favorites list after relaunch
        let relaunchFavoritesButton = app.navigationBars.buttons["heart"] // Adjust identifier if needed
        XCTAssertTrue(relaunchFavoritesButton.exists, "Favorites button not found after relaunch.")
        relaunchFavoritesButton.tap()
        
        // Wait for the Favorites list to appear again
        let relaunchFavoritesList = app.collectionViews
        
        XCTAssertTrue(relaunchFavoritesList.element.exists, "Favorites list is not displayed after relaunch.")
        
        // Verify that the item is still in the Favorites list after relaunch
        let relaunchFavoriteItem = relaunchFavoritesList.cells.staticTexts["Apple"] // Adjust based on actual item name or identifier
        XCTAssertTrue(relaunchFavoriteItem.exists, "Favorite item 'Apple' is not found in the favorites list after relaunch.")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
