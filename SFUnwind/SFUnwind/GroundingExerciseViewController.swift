//
// GroundingExerciseViewController.swift - View Controller for the Grounding Exercise Feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: David Magaril
// Contributing Programmers:
// Known issues:
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import UIKit

class GroundingFeatureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    // Properties:
    //******************
    
    // Grounding Exercise Goal Names (constants).
    let goalString = ["[SEE]", "[TOUCH]", "[HEAR]"]
    
    // Grounding Exercise Current Index (constant).
    var goalIndex = 0
    
    // Grounding Exercise Camera Failure Alert.
    let theAlert = UIAlertController(title: "For Testing", message: "Sorry, this device has no camera", preferredStyle: .alert)
    
    // Grounding Exercise Camera Failure Alert Reply.
    let theOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    // UI Buttons:
    //************
    
    // Grounding Exercise Camera Capture Button
    @IBOutlet weak var captureButton: UIButton!
    
    // UI Labels:
    //************
    
    // Grounding Exercise Current Goal Display
    @IBOutlet weak var goalDisplay: UILabel!
    
    // GroundingFeatureViewController Class methods/functions:
    //**************************************************
    
    // ViewDidLoad: This function is called once the GroundingExerciseViewController.swift object is first initialized.
    // This function is used to start up the UI elements, and add the alert reply as needed.
    override func viewDidLoad() {
        super.viewDidLoad()
        captureButton.layer.cornerRadius=20
        goalDisplay.text = goalString[goalIndex]
        theAlert.addAction(theOkAction)
    }
    
    // cameraButtonAction: This function is called when the user presses the appropiate button.
    // This function is used to start up the camera, or display an error through an alert message to indicate a camera is not installed.
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        // Test if camera exists
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let pickedImager = UIImagePickerController() // New image picker controller: image picker
            // The overlay label is to display the goal while in camera view. Also specify contents of label.
            let overlayLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            overlayLabel.center = CGPoint(x: 160,y: 284)
            overlayLabel.textAlignment = .center
            overlayLabel.text = goalString[goalIndex]
            // Set delegate to self.
            pickedImager.delegate = self
            // Set source type of pickedImager to camera.
            pickedImager.sourceType = UIImagePickerControllerSourceType.camera;
            // We do not want to edit photos that come directly from camera, so we set this to false.
            pickedImager.allowsEditing = false
            // Redundancy to silence warnings.
            pickedImager.cameraCaptureMode = .photo
            // Redundency to minimize errors during camera capture.
            pickedImager.showsCameraControls = true
            // Presents the output image in fullscreen when functionality is implemented.
            pickedImager.modalPresentationStyle = .fullScreen
            // Presents the camera to the user in order to take photos.
            self.present(pickedImager, animated: true, completion: {pickedImager.cameraOverlayView = overlayLabel}) // Activate the camera!
        } else { // You get this if you do not have a camera.
            // For testing.
            theAlert.title = "No Camera"
            // Present alert to user.
            present(theAlert, animated: true, completion: nil) //Present alert
        }
    }
    
    
    // imagePickerController: This function is called when the user exits the camera with a succesfully taken photo.
    // This function is used to do post-camera-operation operations, where we change the goal.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        goalIndex+=1 // Move index
        goalIndex = goalIndex % 3
        goalDisplay.text = goalString[goalIndex]
        self.dismiss(animated: true, completion: nil);
    }
}
