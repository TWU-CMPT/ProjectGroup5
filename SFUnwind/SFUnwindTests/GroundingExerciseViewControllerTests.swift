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
    
    override func setUp() {
        super.setUp()
        
        let theStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main) // Create a storyboard object to use for our tests.
        
        theSFUnwindPageViewController = theStoryboard.instantiateInitialViewController() as! SFUnwindPageViewController? // Create a SFUnwindPageViewController object for our tests.
        theGroundingExerciseViewController = theSFUnwindPageViewController?.theViewControllers[1] as! GroundingFeatureViewController? // Create a GroundingFeatureViewController object for our tests.
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    // Tests:
    //*****************
    
    func testMainLabelsShowingProperly() {
        // See if it's nil before loading page.
        XCTAssert(theGroundingExerciseViewController?.mainLabel == nil)
        // Start the view of the page.
        let _ = theGroundingExerciseViewController?.view
        // Check if the text is now not nothing.
        XCTAssert(theGroundingExerciseViewController?.mainLabel.text != nil)
        // Check if the main goal display is correct
        XCTAssert(theGroundingExerciseViewController?.mainLabel.text == theGroundingExerciseViewController?.strings[(theGroundingExerciseViewController?.stringCount)!])
        // Check if corner radius is correct
        XCTAssert(theGroundingExerciseViewController?.captureButton.layer.cornerRadius == 20)
    }
    
    func tesIimagePickerController(){
        // Start the view of the page.
        let _ = theGroundingExerciseViewController?.view
        // Take measure of the current goal index
        let testCheckCount = theGroundingExerciseViewController?.stringCount
        // Create a test picture
        let examplePic = UIImage(named: "ImageExample")
        // Create a test anyObject dictionary
        let dictionary = [NSObject: AnyObject]()
        // create test imagePicker
        let imagePicker = UIImagePickerController()
        // Call function
        theGroundingExerciseViewController?.imagePickerController(imagePicker, didFinishPickingImage: examplePic, editingInfo : dictionary)
        // Test if goal index was incremented
        XCTAssert(testCheckCount! == (theGroundingExerciseViewController?.stringCount)! - 1)
        // Test if goal string is correct as well
        XCTAssert((theGroundingExerciseViewController?.mainLabel.text)! == theGroundingExerciseViewController?.strings[testCheckCount!+1])
    }
    
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
            XCTAssert(theGroundingExerciseViewController?.alertVC.title == "For Testing")
            // Call Function
            theGroundingExerciseViewController?.cameraButtonAction(testButton)
            // WARNING: No invalid data for input. Any actual invalid data prevents compiling, or crashes testing program. Argument is there just to see if it actually came from a button or not. Anything else crashes.
            // Assert that the title change for the alert was recognized
            XCTAssert(theGroundingExerciseViewController?.alertVC.title == "No Camera")
        }
    }
    
}

