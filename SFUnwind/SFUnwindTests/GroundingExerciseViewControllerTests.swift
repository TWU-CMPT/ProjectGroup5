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
    
    var theSFUnwindPageViewController: SFUnwindPageViewController? // Add an instance of the panic alert view controller object to this test class
    
    var theGroundingExerciseViewController: GroundingFeatureViewController? // Add an instance of the panic alert view controller object to this test class
    
    override func setUp() {
        super.setUp()
        
        let theStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main) // Create a storyboard object to use for our tests
        
        theSFUnwindPageViewController = theStoryboard.instantiateInitialViewController() as! SFUnwindPageViewController? // Create a SFUnwindPageViewController object for our tests
        theGroundingExerciseViewController = theSFUnwindPageViewController?.theViewControllers[1] as! GroundingFeatureViewController? // Create a GroundingFeatureViewController object for our tests
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // Tests:
    //*****************
    
    func testMainLabelsShowingProperly() {
        XCTAssert(theGroundingExerciseViewController?.mainLabel == nil)
        let _ = theGroundingExerciseViewController?.view
        XCTAssert(theGroundingExerciseViewController?.mainLabel.text != nil)
        XCTAssert(theGroundingExerciseViewController?.mainLabel.text == theGroundingExerciseViewController?.strings[(theGroundingExerciseViewController?.stringCount)!])
        XCTAssert(theGroundingExerciseViewController?.captureButton.layer.cornerRadius == 20)
    }
    
    func testimagePickerController(){
        let _ = theGroundingExerciseViewController?.view
        let testCheckCount = theGroundingExerciseViewController?.stringCount
        let examplePic = UIImage(named: "ImageExample")
        let dictionary = [NSObject: AnyObject]()
        let imagePicker = UIImagePickerController()
        theGroundingExerciseViewController?.imagePickerController(imagePicker, didFinishPickingImage: examplePic, editingInfo : dictionary)
        XCTAssert(testCheckCount! == (theGroundingExerciseViewController?.stringCount)! - 1)
        XCTAssert((theGroundingExerciseViewController?.mainLabel.text)! == theGroundingExerciseViewController?.strings[testCheckCount!+1])
    }
    
    func testCameraButtonAction(){
        let _ = theGroundingExerciseViewController?.view
        let testButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            theGroundingExerciseViewController?.cameraButtonAction(testButton)
            //User must test.
        }
        else{
            theGroundingExerciseViewController?.cameraButtonAction(testButton)
        }
    }
    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}

