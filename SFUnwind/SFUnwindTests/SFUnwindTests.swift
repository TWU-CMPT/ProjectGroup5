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
    // Input: None
    // Output: None
    // No dependencies
    override func setUp() {
        super.setUp()
        
        let theStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main) // Create a storyboard object to use for our tests
        
        theSFUnwindPageViewController = theStoryboard.instantiateInitialViewController() as! SFUnwindPageViewController? // Create a SFUnwindPageViewController object for our tests
    }
    // Input: None
    // Output: None
    // Dependency: setUp() has run
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Test the viewDidLoad() function has assigned the correct member variables
    // Input: None
    // Output: None
    // Dependency: setUp() has run
    func testViewDidLoad(){
        let _ = theSFUnwindPageViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
            XCTAssert(theSFUnwindPageViewController?.dataSource as? SFUnwindPageViewController == theSFUnwindPageViewController)
        
        XCTAssert(theSFUnwindPageViewController?.delegate as? SFUnwindPageViewController == theSFUnwindPageViewController)
    
    }
    
    // Test the page turning counter: Should always return 4
    // Input: None
    // Output: None
    // Dependency: setUp() has run
    func testPresentationCount(){
        
        let _ = theSFUnwindPageViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        
        let result = theSFUnwindPageViewController!.presentationCount(for: theSFUnwindPageViewController!)
        XCTAssert(result == 4)
    }
    
    // Test the page turning counter display: Should return [0, 4]
    // Input: None
    // Output: None
    // Dependency: setUp() has run
    func testPresentationIndex(){
        let _ = theSFUnwindPageViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        
        let result = theSFUnwindPageViewController!.presentationIndex(for: theSFUnwindPageViewController!)

        XCTAssert(result >= 0 && result < 4)
    }
    
}
