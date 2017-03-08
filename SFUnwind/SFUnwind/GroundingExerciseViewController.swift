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
    
    
    @IBOutlet weak var pickedImaged: UIImageView! // Image UI we have on screen. Get's replaced by the image itself at some point.
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var captureButton: UIButton!
    
    var strings = ["[SEE]", "[TOUCH]", "[HEAR]"] // Scroll through these.
    var stringCount = 0 // Current index of strings
    let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert) // Create alerts
    let okaAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captureButton.layer.cornerRadius=20
        mainLabel.text = strings[stringCount]
        alertVC.addAction(okaAction)
    }
    // This
    @IBAction func cameraButtonAction(_ sender: UIButton) { // Capture Button
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController() // New picker controller: image picker
            let zlabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21)) // The overlay we want
            zlabel.center = CGPoint(x: 160,y: 284) // Specify stuff about overlay
            zlabel.textAlignment = .center
            zlabel.text = strings[stringCount]
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera; // Source becomes camera
            imagePicker.allowsEditing = false // Do not edit photos that we capture
            imagePicker.cameraCaptureMode = .photo // To be specific, redudant
            imagePicker.showsCameraControls = true // Redudant
            imagePicker.modalPresentationStyle = .fullScreen // Redudant, kinda
            self.present(imagePicker, animated: true, completion: {imagePicker.cameraOverlayView = zlabel}) // Activate the camera!
        } else { // You get this if you do not have a camera.
            
            present(alertVC, animated: true, completion: nil) //Present alert
        }
    }
    // This function sets current goal displayed on main screen to be correct.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        stringCount+=1 // Move index
        stringCount = stringCount % 3
        mainLabel.text = strings[stringCount]
        self.dismiss(animated: true, completion: nil);
    }
    
    
    
}
