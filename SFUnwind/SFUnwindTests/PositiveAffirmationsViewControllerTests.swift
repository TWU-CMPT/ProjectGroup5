//
// PositiveAffirmationViewControllerTests.swift - Tests for the View Controller for the Positive Affirmation feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: Joseph Zhou
// Contributing Programmers:
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import XCTest
@testable import SFUnwind

class PositiveAffirmationViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let theStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main) // Create a storyboard object to use for our tests
        
        theSFUnwindViewViewController = theStoryBoard.instantiateInitialViewController() as! SFUnwindPageViewController?    // Create a SFUnwindPageViewController object for our tests.
        
        thePositiveAffirmationVIdeController = theSFUnwindViewViewController?.theViewControllers[2] as! PositiveAffirmationViewController?  // Create a PositiveAffirmationViewController object for our tests
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    var theSFUnwindViewViewController: SFUnwindPageViewController?  // Add an instance of the positive affirmation view controller object to this test class
    
    var thePositiveAffirmationVIdeController: PositiveAffirmationViewController?    // Add an instance of the positive affirmation view controller object to this test class
    
    //test
    //test the viewDidLoad function
    func testViewDidLoad(){
        // We can tell that our viewDidLoad function has been called as our buttons are no longer nil:
        var result = (thePositiveAffirmationVIdeController?.data != nil)
        XCTAssert(result)
        
        result = (thePositiveAffirmationVIdeController?.datePicker == nil)
        XCTAssert(result)
        
        result = (thePositiveAffirmationVIdeController?.fixed != nil)
        XCTAssert(result)
        
        result = (thePositiveAffirmationVIdeController?.index != nil)
        XCTAssert(result)
        
        result = (thePositiveAffirmationVIdeController?.Label == nil)
        XCTAssert(result)
    }
    
    // Test the previous button
    func testPrevious(){
        // Start the view of the page.
        let _ = thePositiveAffirmationVIdeController?.view
        let testButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        XCTAssert(((thePositiveAffirmationVIdeController?.Previous(testButton)) != nil))    //test the button works or not
    }
    
    // Test the next button
    func testNext(){
        // Start the view of the page.
        let _ = thePositiveAffirmationVIdeController?.view
        let testButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        XCTAssert(((thePositiveAffirmationVIdeController?.Next(testButton)) != nil))    //test the button works or not
    }
    
    // Test the notifications UI
    func testNotifications(){
        // Start the view of the page.
        let _ = thePositiveAffirmationVIdeController?.view
        let testButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        XCTAssert(((thePositiveAffirmationVIdeController?.scheduleNotification(testButton)) != nil))    //test the button works or not
    }
    
    // Test the create mantra feature
    func testCreateMantra(){
        // Start the view of the page.
        let _ = thePositiveAffirmationVIdeController?.view
        let testButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        XCTAssert(((thePositiveAffirmationVIdeController?.Create(testButton)) != nil))  //test the button works or not
    }
}

