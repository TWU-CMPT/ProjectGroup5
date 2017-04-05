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
    func testViewDidLoad(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        // Check if the values for totalTime were set.
        XCTAssert(theSquareBreathingViewController?.totalTimerSeconds != nil)
        XCTAssert(theSquareBreathingViewController?.totalTimerMinute != nil)
        
    }
    
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testSaveSecondsTimer(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        // Here we test valid and invalid data for this function.
        XCTAssert(255 == theSquareBreathingViewController?.saveSecondsTimer(totalTimerSeconds: 255))
        XCTAssert(-200 == theSquareBreathingViewController?.saveSecondsTimer(totalTimerSeconds: -200))
        XCTAssert(0 == theSquareBreathingViewController?.saveSecondsTimer(totalTimerSeconds: 0))
    }
    
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testSaveMinutesTimer(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
            theSquareBreathingViewController?.reStartButtonText.setTitle("Stop", for: .normal)
        // Here we test valid and invalid data for this function.
        XCTAssert(255 == theSquareBreathingViewController?.saveMinutesTimer(totalTimerMinute: 255))
        XCTAssert(-200 == theSquareBreathingViewController?.saveMinutesTimer(totalTimerMinute: -200))
        XCTAssert(0 == theSquareBreathingViewController?.saveMinutesTimer(totalTimerMinute: 0))
    }
    
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
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
    
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
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
    
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
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

    // Input: None
    // Output: None
    // Dependency: setUp() has ran
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
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
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
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
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
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
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
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testViewDidAppear(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        theSquareBreathingViewController?.sesssionTrackerActive = true
        theSquareBreathingViewController?.viewDidAppear(true)
        XCTAssertFalse((theSquareBreathingViewController?.sesssionTrackerActive)!)
        
    }
    
    //Tests if array size doesnt exceeds 10
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testSaveRecentSessionTracker(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        XCTAssert((theSquareBreathingViewController?.latestSessions.count)! < 10)

    }
    //Tests if average functionality works
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testSyncStatistics(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        // Here we test valid and invalid data for this function.
        theSquareBreathingViewController?.reStartButtonText.setTitle("Stop", for: .normal)
    
        let numberOfSessions = 5
        let average = 5
        UserDefaults.standard.set(numberOfSessions, forKey: "totalSessions")
        UserDefaults.standard.set(average, forKey: "averageSession")
        theSquareBreathingViewController?.sessionSecs = 35.0
        theSquareBreathingViewController?.loadStatistics()
        theSquareBreathingViewController?.syncStatistics()
        theSquareBreathingViewController?.saveStatistics()
        let newAverage = UserDefaults.standard.value(forKey: "averageSession") as! Double?
        XCTAssert(newAverage == 10.0)
        
        let oldMax = theSquareBreathingViewController?.maxSession
        theSquareBreathingViewController?.sessionSecs = oldMax!+1
        theSquareBreathingViewController?.syncStatistics()
        XCTAssert(oldMax != theSquareBreathingViewController?.maxSession)
        
        let oldMin = theSquareBreathingViewController?.minSession
        theSquareBreathingViewController?.sessionSecs = oldMin!-1
        theSquareBreathingViewController?.syncStatistics()
        XCTAssert(oldMax != theSquareBreathingViewController?.maxSession)
        
    }
    
    //Test if start button is initialized
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testReStartButtonInitialized(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        XCTAssertNotNil(theSquareBreathingViewController?.restartButton(sender: AnyClass.self))
    }
    
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testScaleAnimationManager(){
        let _ = theSquareBreathingViewController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        // Here we test valid and invalid data for this function.
        theSquareBreathingViewController?.reStartButtonText.setTitle("No/Stop", for: .normal)
        theSquareBreathingViewController?.scaleAnimationManager()
        XCTAssertNil(theSquareBreathingViewController?.animationTimer)
        XCTAssertNil(theSquareBreathingViewController?.sessionTracker)
    
    }
    

}




