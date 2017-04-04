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
            theSquareBreathingViewController?.reStartButtonText.setTitle("Stop", for: .normal)
        // Here we test valid and invalid data for this function.
        XCTAssert(255 == theSquareBreathingViewController?.saveMinutesTimer(totalTimerMinute: 255))
        XCTAssert(-200 == theSquareBreathingViewController?.saveMinutesTimer(totalTimerMinute: -200))
        XCTAssert(0 == theSquareBreathingViewController?.saveMinutesTimer(totalTimerMinute: 0))
    }
    
    func testLoadSecondsTimer(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        // Here we test valid and invalid data for this function.
        theSquareBreathingViewController?.reStartButtonText.setTitle("Stop", for: .normal)
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
        
        theSquareBreathingViewController?.reStartButtonText.setTitle("Stop", for: .normal)
        
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
            theSquareBreathingViewController?.reStartButtonText.setTitle("Stop", for: .normal)
        let previousSessionTimeMinutes = theSquareBreathingViewController?.sessionTimeMinute
        
        let expectedSessionTimeMinutes = previousSessionTimeMinutes!-1
        for _ in 1...60 {           //Pass a minute
        theSquareBreathingViewController?.timeManager()
        }
        let resultedSessionTimeMinutes = theSquareBreathingViewController?.sessionTimeMinute
        
        XCTAssertEqual(expectedSessionTimeMinutes, resultedSessionTimeMinutes)
        
    }
    
    //Tests if after page is swiped does code in SquareBreathingViewController run
    //Also checks if timer stops
    func testViewDidDisappear(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        theSquareBreathingViewController?.sesssionTrackerActive = true
        theSquareBreathingViewController?.viewDidDisappear(true)
        
        XCTAssertTrue((theSquareBreathingViewController?.sesssionTrackerActive)!)
        
        let previousSessionTimeSeconds = theSquareBreathingViewController?.sessionTimeSeconds
        theSquareBreathingViewController?.reStartButtonText.setTitle("Stop", for: .normal)
        theSquareBreathingViewController?.timeManager()
        XCTAssertNotEqual(previousSessionTimeSeconds, theSquareBreathingViewController?.sessionTimeSeconds)
        
    }
    //Tests if squareOrderManager() returns desired UIImageView
    //Also tests if switch functions correctly
    func testSquareOrderManager(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        var orderNumber = 0
        XCTAssertEqual(theSquareBreathingViewController?.circleTRight, theSquareBreathingViewController?.squareOrderManager(currentCircle: orderNumber))
        orderNumber += 1
        XCTAssertEqual(theSquareBreathingViewController?.circleTLeft, theSquareBreathingViewController?.squareOrderManager(currentCircle: orderNumber))
        orderNumber += 1
        XCTAssertEqual(theSquareBreathingViewController?.circleBLeft, theSquareBreathingViewController?.squareOrderManager(currentCircle: orderNumber))
        orderNumber += 1
        XCTAssertEqual(theSquareBreathingViewController?.circleBRight, theSquareBreathingViewController?.squareOrderManager(currentCircle: orderNumber))
        orderNumber += 1
        XCTAssertEqual(theSquareBreathingViewController?.circleTRight, theSquareBreathingViewController?.squareOrderManager(currentCircle: orderNumber))
    }
    
    //Tests if innerOrderManager() returns desired UIImageView
    //Also tests if switch functions correctly
    func testInnerOrderManager(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        var orderNumber = 0
        XCTAssertEqual(theSquareBreathingViewController?.topRInner, theSquareBreathingViewController?.innerOrderManager(currentCircle: orderNumber))
        orderNumber += 1
        XCTAssertEqual(theSquareBreathingViewController?.topLInner, theSquareBreathingViewController?.innerOrderManager(currentCircle: orderNumber))
        orderNumber += 1
        XCTAssertEqual(theSquareBreathingViewController?.botLInner, theSquareBreathingViewController?.innerOrderManager(currentCircle: orderNumber))
        orderNumber += 1
        XCTAssertEqual(theSquareBreathingViewController?.botRInner, theSquareBreathingViewController?.innerOrderManager(currentCircle: orderNumber))
        orderNumber += 1
        XCTAssertEqual(theSquareBreathingViewController?.topRInner, theSquareBreathingViewController?.innerOrderManager(currentCircle: orderNumber))
    }
    
    
    
    //Tests button functionality when view appears
    func testViewDidAppear(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        theSquareBreathingViewController?.sesssionTrackerActive = true
        theSquareBreathingViewController?.viewDidAppear(true)
        XCTAssertFalse((theSquareBreathingViewController?.sesssionTrackerActive)!)
        
    }
    
    //Tests if array size doesnt exceeds 10
    func testSaveRecentSessionTracker(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        
        var latestSessions = UserDefaults.standard.value(forKey: "previousSessions") as! [Double]

        theSquareBreathingViewController?.saveRecentSesionTracker()
        latestSessions = UserDefaults.standard.value(forKey: "previousSessions") as! [Double]
        

        XCTAssert(latestSessions.count >= 10)

    }
    
    
    
    
    //Test if start button is initialized
    func testReStartButtonInitialized(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        XCTAssertNotNil(theSquareBreathingViewController?.restartButton(sender: AnyClass.self))
    }
    
    
    func testScaleAnimationManager(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        // Here we test valid and invalid data for this function.
        theSquareBreathingViewController?.reStartButtonText.setTitle("No/Stop", for: .normal)
        theSquareBreathingViewController?.scaleAnimationManager()
        XCTAssertNil(theSquareBreathingViewController?.animationTimer)
        XCTAssertNil(theSquareBreathingViewController?.sessionTracker)
    
    }
    

}




