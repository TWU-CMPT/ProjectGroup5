//
// GroundingExerciseViewController.swift - View Controller for the Grounding Exercise Feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: David Magaril
// Contributing Programmers:
// Known issues: ???????
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import UIKit



class GroundingFeatureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @IBOutlet weak var goalDisplay: UILabel!
    
    @IBOutlet weak var captureButton: UIButton!
    
    var goalString = ["[SEE]", "[TOUCH]", "[HEAR]"] // Scroll through these.
    var goalIndex = 0 // Current index of strings
    let theAlert = UIAlertController(title: "For Testing", message: "Sorry, this device has no camera", preferredStyle: .alert) // Create alerts
    let theOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captureButton.layer.cornerRadius=20
        goalDisplay.text = goalString[goalIndex]
        theAlert.addAction(theOkAction)
    }
    // This
    @IBAction func cameraButtonAction(_ sender: UIButton) { // Capture Button
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let pickedImager = UIImagePickerController() // New picker controller: image picker
            let overlayLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21)) // The overlay we want
            overlayLabel.center = CGPoint(x: 160,y: 284) // Specify stuff about overlay
            overlayLabel.textAlignment = .center
            overlayLabel.text = goalString[goalIndex]
            
            pickedImager.delegate = self
            pickedImager.sourceType = UIImagePickerControllerSourceType.camera; // Source becomes camera
            pickedImager.allowsEditing = false // Do not edit photos that we capture
            pickedImager.cameraCaptureMode = .photo // To be specific, redudant
            pickedImager.showsCameraControls = true // Redudant
            pickedImager.modalPresentationStyle = .fullScreen // Redudant, kinda
            self.present(pickedImager, animated: true, completion: {pickedImager.cameraOverlayView = overlayLabel}) // Activate the camera!
        } else { // You get this if you do not have a camera.
            theAlert.title = "No Camera"
            present(theAlert, animated: true, completion: nil) //Present alert
        }
    }
    // This function sets current goal displayed on main screen to be correct.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        goalIndex+=1 // Move index
        goalIndex = goalIndex % 3
        goalDisplay.text = goalString[goalIndex]
        self.dismiss(animated: true, completion: nil);
    }
}
