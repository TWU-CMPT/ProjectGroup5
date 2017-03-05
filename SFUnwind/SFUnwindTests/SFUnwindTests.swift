//
// SFUnwindTests.swift - Tests for the SFUnwindPageViewController.swift file
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: All
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import XCTest
@testable import SFUnwind

class SFUnwindTests: XCTestCase {
    
    var theSFUnwindPageViewController: SFUnwindPageViewController? // Add an instance of the panic alert view controller object to this test class
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    override func setUp() {
        super.setUp()
        
        let theStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main) // Create a storyboard object to use for our tests
        
        theSFUnwindPageViewController = theStoryboard.instantiateInitialViewController() as! SFUnwindPageViewController? // Create a SFUnwindPageViewController object for our tests
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Test the page turning counter: Should always return 4
    func testPresentationCount(){
        
        let _ = theSFUnwindPageViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        
        let result = theSFUnwindPageViewController!.presentationCount(for: theSFUnwindPageViewController!)
        XCTAssert(result == 4)
    }
    
    // Test the page turning counter display: Should return [0, 4]
    func testPresentationIndex(){
        let _ = theSFUnwindPageViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        
        let result = theSFUnwindPageViewController!.presentationIndex(for: theSFUnwindPageViewController!)

        XCTAssert(result >= 0 && result < 4)
    }
    
}
