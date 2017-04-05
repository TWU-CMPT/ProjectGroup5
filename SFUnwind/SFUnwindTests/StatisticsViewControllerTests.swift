//
// StatisticsViewControllerTests.swift - Tests for the Statistics Feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: Berke Boz
// Contributing Programmers:
//
// Note: All files in this project conform to the coding standard included in the SFUnwind Quality Assurance Documentation

import XCTest
@testable import SFUnwind


class StatisticsViewControllerTests: XCTestCase {
    
    var theSFUnwindPageViewController: SFUnwindPageViewController? // Add an instance of the theSFUnwindPageViewController view controller object to this test class
    
    var theStatisticsViewContoller: StatisticsViewController?   // Add an instance of the theStatisticsViewContoller object to this test class
    
    
    
    override func setUp() {
        super.setUp()
        let theStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main) // Create a storyboard object to use for our tests
        
        theSFUnwindPageViewController = theStoryboard.instantiateInitialViewController() as! SFUnwindPageViewController? // Create a SFUnwindPageViewController object for our tests
        
        
        
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
    
    // Tests restart of statistics
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testRestartAllButton(){
        let _ = theStatisticsViewContoller?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        // Check if the values for totalTime were set.
        theStatisticsViewContoller?.viewDidLoad()
        theStatisticsViewContoller?.restartAllButton(UIButton.self)
        
        print(theStatisticsViewContoller?.shortestSession ?? Double())
        XCTAssert(theStatisticsViewContoller?.shortestSession ?? Double() == 0.0)
        XCTAssert(theStatisticsViewContoller?.averageTime ?? Double() == 0.0)
        XCTAssert(theStatisticsViewContoller?.longestSession ?? Double() == 0.0)
        XCTAssert(theStatisticsViewContoller?.totalNumber ?? Int() == 0)
        

    }

    
    
    
}
