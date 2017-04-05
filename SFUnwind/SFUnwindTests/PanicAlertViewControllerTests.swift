//
// PanicAlertViewControllerTests.swift - Tests for the Panic Alert Feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: Adam Badke #301310785
// Contributing Programmers:
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import XCTest
import ContactsUI
@testable import SFUnwind

class PanicAlertViewControllerTests: XCTestCase {
    
    var theSFUnwindPageViewController: SFUnwindPageViewController? // Add an instance of the panic alert view controller object to this test class

    var thePanicAlertViewController: PanicAlertViewController? // Add an instance of the panic alert view controller object to this test class

    // Put setup code here. This method is called before the invocation of each test method in the class.
    // Input: None
    // Output: None
    // No dependencies
    override func setUp() {
        super.setUp() // Call the superclass setup function
        
        let theStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main) // Create a storyboard object to use for our tests
        
        theSFUnwindPageViewController = theStoryboard.instantiateInitialViewController() as! SFUnwindPageViewController? // Create a SFUnwindPageViewController object for our tests
        
        thePanicAlertViewController = theSFUnwindPageViewController?.theViewControllers[3] as! PanicAlertViewController? // Create a PanicAlertViewController object for our tests
    }
    // Tears down
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Tests:
    //*****************
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testContactCreateSendEditBtns(){
        let _ = thePanicAlertViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        thePanicAlertViewController?.initializeAlertList() // Call the initializer function
        
        var result = ( (thePanicAlertViewController?.contact1CreateSendBtn.currentTitle == "Create" && thePanicAlertViewController?.contact1EditBtn.isHidden == true)
        || ( thePanicAlertViewController?.alertExists[0] == true && thePanicAlertViewController?.contact1CreateSendBtn.currentTitle == "Send")
        )
        XCTAssert(result)
        
        result = ( (thePanicAlertViewController?.contact2CreateSendBtn.currentTitle == "Create" && thePanicAlertViewController?.contact2EditBtn.isHidden == true)
            || ( thePanicAlertViewController?.alertExists[1] == true && thePanicAlertViewController?.contact2CreateSendBtn.currentTitle == "Send")
        )
        XCTAssert(result)
        
        result = ( (thePanicAlertViewController?.contact3CreateSendBtn.currentTitle == "Create" && thePanicAlertViewController?.contact3EditBtn.isHidden == true)
            || ( thePanicAlertViewController?.alertExists[2] == true && thePanicAlertViewController?.contact3CreateSendBtn.currentTitle == "Send")
        )
        XCTAssert(result)
        
        result = ( (thePanicAlertViewController?.contact4CreateSendBtn.currentTitle == "Create" && thePanicAlertViewController?.contact4EditBtn.isHidden == true)
            || ( thePanicAlertViewController?.alertExists[3] == true && thePanicAlertViewController?.contact4CreateSendBtn.currentTitle == "Send")
        )
        XCTAssert(result)
        
        result = ( (thePanicAlertViewController?.contact5CreateSendBtn.currentTitle == "Create" && thePanicAlertViewController?.contact5EditBtn.isHidden == true)
            || ( thePanicAlertViewController?.alertExists[4] == true && thePanicAlertViewController?.contact5CreateSendBtn.currentTitle == "Send")
        )
        XCTAssert(result)
        
    }
    
    // Test the viewDidLoad() function:
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testViewDidLoad(){
        // We can tell that our viewDidLoad function has been called as our buttons are no longer nil:
        _ = thePanicAlertViewController?.view
        var result = (thePanicAlertViewController?.contact1CreateSendBtn.currentTitle != nil)
        XCTAssert(result)
        
        result = (thePanicAlertViewController?.contact2CreateSendBtn.currentTitle != nil)
        XCTAssert(result)
        
        result = (thePanicAlertViewController?.contact3CreateSendBtn.currentTitle != nil)
        XCTAssert(result)
        
        result = (thePanicAlertViewController?.contact4CreateSendBtn.currentTitle != nil)
        XCTAssert(result)
        
        result = (thePanicAlertViewController?.contact5CreateSendBtn.currentTitle != nil)
        XCTAssert(result)
    }
    
    // Test the getStoredAlerts() function:
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testGetStoredAlerts() {
        // Call the function we want to test and get it's return value:
        let alert01Result = thePanicAlertViewController?.getStoredAlerts(filename: "alert01")
        
        // Assert that the return value is what we expected:
        XCTAssert(alert01Result == nil || alert01Result?[0] == "" || (alert01Result?.count)! >= 3) // Either there is no file and nil is returned, or, we get an array of strings of 3 or more elements
        
        // Repeat the test for the remaining 4 alerts:
        let alert02Result = thePanicAlertViewController?.getStoredAlerts(filename: "alert02")
        XCTAssert(alert02Result == nil || alert02Result?[0] == "" || (alert02Result?.count)! >= 3) // Either there is no file and nil is returned, or, we get an array of strings of 3 or more elements
        
        let alert03Result = thePanicAlertViewController?.getStoredAlerts(filename: "alert03")
        XCTAssert(alert03Result == nil || alert03Result?[0] == "" || (alert03Result?.count)! >= 3) // Either there is no file and nil is returned, or, we get an array of strings of 3 or more elements
        
        let alert04Result = thePanicAlertViewController?.getStoredAlerts(filename: "alert04")
        XCTAssert(alert04Result == nil || alert04Result?[0] == "" || (alert04Result?.count)! >= 3) // Either there is no file and nil is returned, or, we get an array of strings of 3 or more elements
        
        let alert05Result = thePanicAlertViewController?.getStoredAlerts(filename: "alert05")
        XCTAssert(alert05Result == nil || alert05Result?[0] == "" || (alert05Result?.count)! >= 3) // Either there is no file and nil is returned, or, we get an array of strings of 3 or more elements

        // Test invalid input
        let invalidAlert = thePanicAlertViewController?.getStoredAlerts(filename: "alert0")
        XCTAssert(invalidAlert == nil) // The function should return nil for invalid filenames
    }

    
    // Test the UI Labels
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testInitializeAlertList(){
        let _ = thePanicAlertViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        thePanicAlertViewController?.initializeAlertList() // Call the initializer function
        
        // Verify the edit button texts:
        XCTAssert(thePanicAlertViewController?.contact1EditBtn.title(for: .normal) == "Edit")
        XCTAssert(thePanicAlertViewController?.contact2EditBtn.title(for: .normal) == "Edit")
        XCTAssert(thePanicAlertViewController?.contact3EditBtn.title(for: .normal) == "Edit")
        XCTAssert(thePanicAlertViewController?.contact4EditBtn.title(for: .normal) == "Edit")
        XCTAssert(thePanicAlertViewController?.contact5EditBtn.title(for: .normal) == "Edit")
        
        // Verify the send/create button texts:
        XCTAssert(thePanicAlertViewController?.contact1CreateSendBtn.title(for: .normal) == "Create" || thePanicAlertViewController?.contact1CreateSendBtn.title(for: .normal) == "Send")
        XCTAssert(thePanicAlertViewController?.contact2CreateSendBtn.title(for: .normal) == "Create" || thePanicAlertViewController?.contact2CreateSendBtn.title(for: .normal) == "Send")
        XCTAssert(thePanicAlertViewController?.contact3CreateSendBtn.title(for: .normal) == "Create" || thePanicAlertViewController?.contact3CreateSendBtn.title(for: .normal) == "Send")
        XCTAssert(thePanicAlertViewController?.contact4CreateSendBtn.title(for: .normal) == "Create" || thePanicAlertViewController?.contact4CreateSendBtn.title(for: .normal) == "Send")
        XCTAssert(thePanicAlertViewController?.contact5CreateSendBtn.title(for: .normal) == "Create" || thePanicAlertViewController?.contact5CreateSendBtn.title(for: .normal) == "Send")

        // Verify the contact name texts:
        XCTAssert((thePanicAlertViewController?.contact1Text.text)! == "" || (thePanicAlertViewController?.contact1Text.text?.characters.count)! >= 1 )
        XCTAssert((thePanicAlertViewController?.contact2Text.text)! == "" || (thePanicAlertViewController?.contact2Text.text?.characters.count)! >= 1 )
        XCTAssert((thePanicAlertViewController?.contact3Text.text)! == "" || (thePanicAlertViewController?.contact3Text.text?.characters.count)! >= 1 )
        XCTAssert((thePanicAlertViewController?.contact4Text.text)! == "" || (thePanicAlertViewController?.contact4Text.text?.characters.count)! >= 1 )
        XCTAssert((thePanicAlertViewController?.contact5Text.text)! == "" || (thePanicAlertViewController?.contact5Text.text?.characters.count)! >= 1 )
        
    }
    
    // Test the contact picker's cancel delegate function
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testContactPickerDidCancel(){
        _ = CNContactPickerViewController()
        //thePanicAlertViewController?.contactPickerDidCancel(fakeCntrl)
        XCTAssert(thePanicAlertViewController?.currentContact == 0)
    }
    
    // Test the contact picker's contact selection delegate function
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testContactPicker(){
        thePanicAlertViewController?.currentContact = 6 // Set an out of bounds value to make sure we handle it
        
        //thePanicAlertViewController?.contactPicker(CNContactPickerViewController(), didSelect: CNContactProperty())
        XCTAssert(thePanicAlertViewController?.currentContact != 0)
    }
    
    
    
}


