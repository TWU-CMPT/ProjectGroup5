//
// GroundingExerciseViewControllerTests.swift - Tests for the View Controller for the Grounding Exercise Feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: David Magaril
// Contributing Programmers:
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import XCTest
@testable import SFUnwind

class GroundingFeatureViewControllerTests: XCTestCase {
    
    var theSFUnwindPageViewController: SFUnwindPageViewController? // Add an instance of the panic alert view controller object to this test class.
    
    var theGroundingExerciseViewController: GroundingFeatureViewController? // Add an instance of the panic alert view controller object to this test class.
    
    // Sets up environment
    // Input: None
    // Output: None
    // No dependencies
    override func setUp() {
        super.setUp()
        
        let theStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main) // Create a storyboard object to use for our tests.
        
        theSFUnwindPageViewController = theStoryboard.instantiateInitialViewController() as! SFUnwindPageViewController? // Create a SFUnwindPageViewController object for our tests.
        theGroundingExerciseViewController = theSFUnwindPageViewController?.theViewControllers[1] as! GroundingFeatureViewController? // Create a GroundingFeatureViewController object for our tests.
    }
    
    //Destroys environment
    // Input: Sender
    // Output: None
    // No dependencies
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
        // See if it's nil before loading page.
        XCTAssert(theGroundingExerciseViewController?.goalDisplay == nil)
        // Start the view of the page.
        let _ = theGroundingExerciseViewController?.view
        // Check if the text is now not nothing.
        XCTAssert(theGroundingExerciseViewController?.goalDisplay.text != nil)
        // Check if the main goal display is correct
        XCTAssert(theGroundingExerciseViewController?.goalDisplay.text == theGroundingExerciseViewController?.goalString[(theGroundingExerciseViewController?.goalIndex)!])
        // Check if corner radius is correct
        XCTAssert(theGroundingExerciseViewController?.captureButton.layer.cornerRadius == 20)
        // Check if buttons are correctly hidden and disabled after viewDidLoad
        XCTAssert(theGroundingExerciseViewController?.captureButton.isHidden == false)
        XCTAssert(theGroundingExerciseViewController?.captureButton.isEnabled == true)
        XCTAssert(theGroundingExerciseViewController?.resetButton.isHidden == true)
        XCTAssert(theGroundingExerciseViewController?.resetButton.isEnabled == false)
        XCTAssert(theGroundingExerciseViewController?.goalDisplay.isHidden == false)
        XCTAssert(theGroundingExerciseViewController?.helpButton.isHidden == false)
        XCTAssert(theGroundingExerciseViewController?.helpButton.isEnabled == true)
    }
    
    // Test the viewDidAppear function
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testViewDidAppear(){
        // Start the view of the page.
        let _ = theGroundingExerciseViewController?.view
        // Trigger the viewDidAppear()
        let _ = theGroundingExerciseViewController?.view
        // Check if buttons are correctly hidden and disabled viewDidAppear.
        XCTAssert(theGroundingExerciseViewController?.captureButton.isHidden == false)
        XCTAssert(theGroundingExerciseViewController?.captureButton.isEnabled == true)
        XCTAssert(theGroundingExerciseViewController?.resetButton.isHidden == true)
        XCTAssert(theGroundingExerciseViewController?.resetButton.isEnabled == false)
        XCTAssert(theGroundingExerciseViewController?.goalDisplay.isHidden == false)
        XCTAssert(theGroundingExerciseViewController?.helpButton.isHidden == false)
        XCTAssert(theGroundingExerciseViewController?.helpButton.isEnabled == true)
    }
    
    // Test the reset button
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testResetButtonAction(){
        // Start the view of the page.
        let _ = theGroundingExerciseViewController?.view
        let testButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        // Press button
         theGroundingExerciseViewController?.resetButtonAction(testButton)
        // Check if buttons are correctly hidden and disabled after reset.
        XCTAssert(theGroundingExerciseViewController?.captureButton.isHidden == false)
        XCTAssert(theGroundingExerciseViewController?.captureButton.isEnabled == true)
        XCTAssert(theGroundingExerciseViewController?.resetButton.isHidden == true)
        XCTAssert(theGroundingExerciseViewController?.resetButton.isEnabled == false)
        XCTAssert(theGroundingExerciseViewController?.goalDisplay.isHidden == false)
        XCTAssert(theGroundingExerciseViewController?.helpButton.isHidden == false)
        XCTAssert(theGroundingExerciseViewController?.helpButton.isEnabled == true)
    }
    
    // Test the imagePickerController view
    // Input: None
    // Output: None
    // Dependency: setUp() has ran
    func testCameraButtonAction(){
        // Start the view of the page.
        let _ = theGroundingExerciseViewController?.view
        let testButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            theGroundingExerciseViewController?.cameraButtonAction(testButton)
            // WARNING: No invalid data for input. Any actual invalid data prevents compiling, or crashes testing program. Argument is there just to see if it actually came from a button or not. Anything else crashes.
            // User must test the camera.
        }
        else{
            // Assert that the title for alert is correct
            XCTAssert(theGroundingExerciseViewController?.theAlert.title == "For Testing")
            // Call Function
            theGroundingExerciseViewController?.cameraButtonAction(testButton)
            // WARNING: No invalid data for input. Any actual invalid data prevents compiling, or crashes testing program. Argument is there just to see if it actually came from a button or not. Anything else crashes.
            // Assert that the title change for the alert was recognized
            XCTAssert(theGroundingExerciseViewController?.theAlert.title == "No Camera")
        }
    }
    
}

