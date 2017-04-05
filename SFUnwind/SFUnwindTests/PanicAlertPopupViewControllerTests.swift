//
// PanicAlertPopupViewViewControllerTests.swift - Tests for the Panic Alert Feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: Adam Badke #301310785
// Contributing Programmers:
//
// Note: All files in this project conform to the coding standard included in the SFUnwind Quality Assurance Documentation

import XCTest
@testable import SFUnwind

class PanicAlertPopupViewControllerTests: XCTestCase {
    
    var theSFUnwindPageViewController: SFUnwindPageViewController? // Add an instance of the panic alert view controller object to this test class
    
    var thePanicAlertPopupViewController: PanicAlertPopupViewController? // Add an instance of the panic alert popup view controller object to this test class
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    override func setUp() {
        super.setUp() // Call the superclass setup function
        
        let theStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main) // Create a storyboard object to use for our tests
        
        theSFUnwindPageViewController = theStoryboard.instantiateInitialViewController() as! SFUnwindPageViewController? // Create a SFUnwindPageViewController object for our tests
    }
    
    // Tear down
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


    // Tests:
    //*****************
    
    
    // Test the viewDidLoad() function:
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testViewDidLoad(){
        
        let _ = thePanicAlertPopupViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns

        // Invoke the function:
        thePanicAlertPopupViewController?.viewDidLoad()
        
        // Ensure the default values are set:
        XCTAssert(thePanicAlertPopupViewController?.recievedAlert == nil )
        XCTAssert(thePanicAlertPopupViewController?.popupSelectContactBtn.titleLabel == nil )
        XCTAssert(thePanicAlertPopupViewController?.popupTextInput.text == nil )
        
        thePanicAlertPopupViewController?.recievedAlertIndex = 0
        thePanicAlertPopupViewController?.recievedAlert = ["a", "b", "c"]
        
    }
    

}
