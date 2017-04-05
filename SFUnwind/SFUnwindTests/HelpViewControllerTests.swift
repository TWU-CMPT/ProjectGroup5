//
// HelpViewControllerTests.swift - Tests for the View Controller for the Help View
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: David Magaril
// Contributing Programmers:
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import XCTest
@testable import SFUnwind

class HelpViewControllerTests: XCTestCase {
    
    var theSFUnwindPageViewController: SFUnwindPageViewController? // Add an instance of the help view controller object to this test class.
    
    var theHelpViewController: HelpViewController? // Add an instance of the help view controller object to this test class.
    
    // Sets up environment
    // Input: None
    // Output: None
    // No dependencies
    override func setUp() {
        super.setUp()
        
        let theStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main) // Create a storyboard object to use for our tests.
        
        theSFUnwindPageViewController = theStoryboard.instantiateInitialViewController() as! SFUnwindPageViewController? // Create a SFUnwindPageViewController object for our tests.
    }
    
    //Destroys environment
    // Input: Sender
    // Output: None
    // Dependency: setUp() has ran
    override func tearDown() {
        super.tearDown()
    }
    
    // Tests:
    //*****************
    
    // Test the viewDidLoad function
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testViewDidLoad() {
        // Start the view of the page.
        let _ = theHelpViewController?.view
        // See if contents were valid
        XCTAssert(theHelpViewController?.UIScrollView.contentSize == nil)
        // Do the same with population
        theHelpViewController?.populateHelpText(screenNumber: 0)
        XCTAssert(theHelpViewController?.helpScreenText.text != "Default help screen text. If you're seeing this, chances are the HelpViewController.swift populateHelpText() function had a problem!")
        
    }
    
    // Test the population function
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testPopulateHelpText(){
        // Start the view of the page.
        let _ = theHelpViewController?.view
        // Selects text
        theHelpViewController?.populateHelpText(screenNumber: 0)
        XCTAssert(theHelpViewController?.helpString != "Default help screen text. If you're seeing this, chances are the HelpViewController.swift populateHelpText() function had a problem!")
    }
    
}

