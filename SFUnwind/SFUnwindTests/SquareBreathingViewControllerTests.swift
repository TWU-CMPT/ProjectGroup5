//
// SquareBreathingControllerTests.swift - Tests for the View Controller for the "Square Breathing" feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: Berke Boz
// Contributing Programmers:
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import XCTest
@testable import SFUnwind




class SquareBreathingViewControllerTests: XCTestCase {
    
    var theSFUnwindPageViewController: SFUnwindPageViewController? // Add an instance of the SquareBreathing view controller object to this test class
    
    var theSquareBreathingViewController: SquareBreathingViewController? // Add an instance of the SquareBreathing view controller object to this test class
    
    override func setUp() {
        super.setUp()
        
        let theStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main) // Create a storyboard object to use for our tests
        
        theSFUnwindPageViewController = theStoryboard.instantiateInitialViewController() as! SFUnwindPageViewController? // Create a SFUnwindPageViewController object for our tests
        theSquareBreathingViewController = theSFUnwindPageViewController?.theViewControllers[0] as! SquareBreathingViewController? // Create a SquareBreathingViewController object for our tests
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // Tests:
    //*****************
    
    func testViewDidLoad(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        // Check if the values for totalTime were set.
        XCTAssert(theSquareBreathingViewController?.totalTimerSeconds != nil)
        XCTAssert(theSquareBreathingViewController?.totalTimerMinute != nil)
        
    }
    
    func testSaveSecondsTimer(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        // Here we test valid and invalid data for this function.
        XCTAssert(255 == theSquareBreathingViewController?.saveSecondsTimer(totalTimerSeconds: 255))
        XCTAssert(-200 == theSquareBreathingViewController?.saveSecondsTimer(totalTimerSeconds: -200))
        XCTAssert(0 == theSquareBreathingViewController?.saveSecondsTimer(totalTimerSeconds: 0))
    }
    
    func testSaveMinutesTimer(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        // Here we test valid and invalid data for this function.
        XCTAssert(255 == theSquareBreathingViewController?.saveMinutesTimer(totalTimerMinute: 255))
        XCTAssert(-200 == theSquareBreathingViewController?.saveMinutesTimer(totalTimerMinute: -200))
        XCTAssert(0 == theSquareBreathingViewController?.saveMinutesTimer(totalTimerMinute: 0))
    }
    
    func testLoadSecondsTimer(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        // Here we test valid and invalid data for this function.
        XCTAssert(255 == theSquareBreathingViewController?.saveSecondsTimer(totalTimerSeconds: 255))
        // Then we test if it's loaded correctly
        XCTAssert(255 == theSquareBreathingViewController?.loadSecondsTimer())
        XCTAssert(-200 == theSquareBreathingViewController?.saveSecondsTimer(totalTimerSeconds: -200))
        XCTAssert(-200 == theSquareBreathingViewController?.loadSecondsTimer())
        XCTAssert(0 == theSquareBreathingViewController?.saveSecondsTimer(totalTimerSeconds: 0))
        XCTAssert(0 == theSquareBreathingViewController?.loadSecondsTimer())
    }
    
    func testLoadMinutesTimer(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        // Here we test valid and invalid data for this function.
        XCTAssert(255 == theSquareBreathingViewController?.saveMinutesTimer(totalTimerMinute: 255))
        // Then we test if it's loaded correctly
        XCTAssert(255 == theSquareBreathingViewController?.loadMinutesTimer())
        XCTAssert(-200 == theSquareBreathingViewController?.saveMinutesTimer(totalTimerMinute: -200))
        XCTAssert(-200 == theSquareBreathingViewController?.loadMinutesTimer())
        XCTAssert(0 == theSquareBreathingViewController?.saveMinutesTimer(totalTimerMinute: 0))
        XCTAssert(0 == theSquareBreathingViewController?.loadMinutesTimer())
    }
    
    func testSessionSecondsTimeManager(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        let previousSessionTimeSeconds = theSquareBreathingViewController?.sessionTimeSeconds
        
        
        
        let expectedSessionTimeSeconds = previousSessionTimeSeconds!-1
        theSquareBreathingViewController?.timeManager()
        let resultedSessionTimeSeconds = theSquareBreathingViewController?.sessionTimeSeconds
        
        XCTAssertEqual(expectedSessionTimeSeconds, resultedSessionTimeSeconds)
        
        for _ in 1...60 {           //Pass a minute
            theSquareBreathingViewController?.timeManager()
        }
        
        var _ = theSquareBreathingViewController?.saveMinutesTimer(totalTimerMinute: 5)// Saved to a non-zero value for testing seconds
        
        XCTAssertEqual(resultedSessionTimeSeconds, theSquareBreathingViewController?.sessionTimeSeconds)    //Does seconds get back to 60 after 0
        
    }

    func testSessionMinutesTimeManager(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        let previousSessionTimeMinutes = theSquareBreathingViewController?.sessionTimeMinute
        
        let expectedSessionTimeMinutes = previousSessionTimeMinutes!-1
        for _ in 1...60 {           //Pass a minute
        theSquareBreathingViewController?.timeManager()
        }
        let resultedSessionTimeMinutes = theSquareBreathingViewController?.sessionTimeMinute
        
        XCTAssertEqual(expectedSessionTimeMinutes, resultedSessionTimeMinutes)
        
        
        
    }
    
    func testReStartButtonInitialized(){
    
        XCTAssertNotNil(theSquareBreathingViewController?.restartButton(sender: AnyClass.self))
    }
    

}




