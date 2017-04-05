//
// PositiveAffirmationViewControllerTests.swift - Tests for the View Controller for the Positive Affirmation feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: Joseph Zhou
// Contributing Programmers: David Magaril
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import XCTest
@testable import SFUnwind

class PositiveAffirmationViewControllerTests: XCTestCase {
    
    // Sets up environment
    // Input: Sender
    // Output: None
    // No dependencies
    override func setUp() {
        super.setUp()
        
        let theStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main) // Create a storyboard object to use for our tests
        
        theSFUnwindViewViewController = theStoryBoard.instantiateInitialViewController() as! SFUnwindPageViewController?    // Create a SFUnwindPageViewController object for our tests.
        
        thePositiveAffirmationVIdeController = theSFUnwindViewViewController?.theViewControllers[2] as! PositiveAffirmationViewController?  // Create a PositiveAffirmationViewController object for our tests
    }
    
    // For deconstruction
    // Input: Sender
    // Output: None
    // No dependencies
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    var theSFUnwindViewViewController: SFUnwindPageViewController?  // Add an instance of the positive affirmation view controller object to this test class
    
    var thePositiveAffirmationVIdeController: PositiveAffirmationViewController?    // Add an instance of the positive affirmation view controller object to this test class
    
    //test the viewDidLoad function
    // Input: Sender
    // Output: None
    // No dependencies
    func testViewDidLoad(){
        let _ = thePositiveAffirmationVIdeController?.view
        // We can tell that our viewDidLoad function has been called as our buttons are no longer nil:
        var result = (thePositiveAffirmationVIdeController?.data != nil)
        XCTAssert(result)
        
        // Test initiale of variables
        //---
        XCTAssert(thePositiveAffirmationVIdeController?.currentIndex == 0)
        XCTAssert(thePositiveAffirmationVIdeController?.notificationButton.layer.cornerRadius == 13)
        XCTAssert(thePositiveAffirmationVIdeController?.createMantraButton.layer.cornerRadius == 13)
        XCTAssert(thePositiveAffirmationVIdeController?.deleteMantraButton.layer.cornerRadius == 13)
        XCTAssert(thePositiveAffirmationVIdeController?.previousButton.layer.cornerRadius == 13)
        XCTAssert(thePositiveAffirmationVIdeController?.nextButton.layer.cornerRadius == 13)
        //---
        
        //Test if file exists
        XCTAssert(FileManager.default.fileExists(atPath: (thePositiveAffirmationVIdeController?.pathToAff)!))
        // Check index is not nil
        result = (thePositiveAffirmationVIdeController?.index != nil)
        XCTAssert(result)
    }
    
    // Test the previous button
    // Input: Sender
    // Output: None
    // No dependencies
    func testPrevious(){
        // Start the view of the page.
        let _ = thePositiveAffirmationVIdeController?.view
        let testButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        XCTAssert(((thePositiveAffirmationVIdeController?.Previous(testButton)) != nil))    //test the button works or not
    }
    
    // Test the next button
    // Input: Sender
    // Output: None
    // No dependencies
    func testNext(){
        // Start the view of the page.
        let _ = thePositiveAffirmationVIdeController?.view
        let testButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        XCTAssert(((thePositiveAffirmationVIdeController?.Next(testButton)) != nil))    //test the button works or not
    }
    
    // Test the notifications UI
    // Input: Sender
    // Output: None
    // No dependencies
    func testNotifications(){
        // Start the view of the page.
        let _ = thePositiveAffirmationVIdeController?.view
        let testButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        XCTAssert(((thePositiveAffirmationVIdeController?.scheduleNotification(testButton)) != nil))    //test the button works or not
    }
    
    // Test the create mantra feature
    // Input: Sender
    // Output: None
    // No dependencies
    func testCreateMantra(){
        // Start the view of the page.
        let _ = thePositiveAffirmationVIdeController?.view
        let testButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        XCTAssert(((thePositiveAffirmationVIdeController?.Create(testButton)) != nil))  //test the button works or not
    }
    
    // Test the delete mantra feature
    // Input: Sender
    // Output: None
    // No dependencies
    func testDeleteMantra(){
        // Start the view of the page.
        let _ = thePositiveAffirmationVIdeController?.view
        let testButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        XCTAssert(((thePositiveAffirmationVIdeController?.DeleteAlert(testButton)) != nil))  //test the button works or not
    }
    
    // Tests the pickerViewTitle()
    // Input: Sender
    // Output: None
    // No dependencies
    func testPickerViewTitle(){
        let pickerview = UIPickerView()
        let titleForRow = 0
        let forComponent = 0
        _ = thePositiveAffirmationVIdeController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        let textTime = thePositiveAffirmationVIdeController?.pickerView(pickerview, titleForRow: titleForRow, forComponent: forComponent)// Call the initializer function
        XCTAssert(textTime == "")
    }
    // Tests the pickerViewDidSelect()
    // Input: Sender
    // Output: None
    // No dependencies
    func testPickerViewDidSelect(){
        var didSelectRow = 1
        var inComponent = 0
        _ = thePositiveAffirmationVIdeController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        thePositiveAffirmationVIdeController?.pickerView((thePositiveAffirmationVIdeController?.dataDrop)!, didSelectRow: didSelectRow, inComponent: inComponent)// Call the initializer function
        thePositiveAffirmationVIdeController?.textTime.text = "Weekly"
        thePositiveAffirmationVIdeController?.pickerView((thePositiveAffirmationVIdeController?.dataDrop)!, didSelectRow: didSelectRow, inComponent: inComponent)
        XCTAssert(thePositiveAffirmationVIdeController?.weekday.isHidden == false)
        XCTAssert(thePositiveAffirmationVIdeController?.hour.isHidden == false)
        XCTAssert(thePositiveAffirmationVIdeController?.minute.isHidden == false)
        XCTAssert(thePositiveAffirmationVIdeController?.atLabelText.isHidden == false)
        XCTAssert(thePositiveAffirmationVIdeController?.sepLabel.isHidden == false)
        didSelectRow = 2
        inComponent = 0
        thePositiveAffirmationVIdeController?.textTime.text = "Daily"
        thePositiveAffirmationVIdeController?.pickerView((thePositiveAffirmationVIdeController?.dataDrop)!, didSelectRow: didSelectRow, inComponent: inComponent)// Call the initializer function
        XCTAssert(thePositiveAffirmationVIdeController?.weekday.isHidden == true)
        XCTAssert(thePositiveAffirmationVIdeController?.hour.isHidden == false)
        XCTAssert(thePositiveAffirmationVIdeController?.minute.isHidden == false)
        XCTAssert(thePositiveAffirmationVIdeController?.atLabelText.isHidden == true)
        XCTAssert(thePositiveAffirmationVIdeController?.sepLabel.isHidden == false)
        thePositiveAffirmationVIdeController?.textTime.text = "Hourly"
        didSelectRow = 3
        inComponent = 0
        thePositiveAffirmationVIdeController?.pickerView((thePositiveAffirmationVIdeController?.dataDrop)!, didSelectRow: didSelectRow, inComponent: inComponent)// Call the initializer function
        XCTAssert(thePositiveAffirmationVIdeController?.weekday.isHidden == true)
        XCTAssert(thePositiveAffirmationVIdeController?.hour.isHidden == true)
        XCTAssert(thePositiveAffirmationVIdeController?.minute.isHidden == false)
        XCTAssert(thePositiveAffirmationVIdeController?.atLabelText.isHidden == true)
        XCTAssert(thePositiveAffirmationVIdeController?.sepLabel.isHidden == true)
    }
    // Tests textFieldDidBeginEditing()
    // Input: Sender
    // Output: None
    // No dependencies
    func testTextFieldDidBeginEditing(){
        let txtField = UITextField()
        _ = thePositiveAffirmationVIdeController?.view // Trigger the required view methods. Required to prevent erroneous nil returns
        thePositiveAffirmationVIdeController?.textFieldDidBeginEditing(txtField)
        XCTAssert(txtField.isEnabled == true)
        
    }

}
