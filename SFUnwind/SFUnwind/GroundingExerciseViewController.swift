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
    
    var strings = ["[SEE]", "[TOUCH]", "[HEAR]"] // Scroll through these.
    var stringCount = 0 // Current index of strings
    
    @IBAction func cameraButtonAction(_ sender: UIButton) { // Capture Button
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController() // New picker controller: image picker
            let zlabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21)) // The overlay we want
            zlabel.center = CGPoint(x: 160,y: 284) // Specify stuff about overlay
            zlabel.textAlignment = .center
            zlabel.text = strings[stringCount]
            stringCount+=1 // Move index
            stringCount = stringCount % 3
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera; // Source becomes camera
            imagePicker.allowsEditing = false // Do not edit photos that we capture
            imagePicker.cameraCaptureMode = .photo // To be specific, redudant
            imagePicker.showsCameraControls = true // Redudant
            imagePicker.modalPresentationStyle = .fullScreen // Redudant, kinda
            self.present(imagePicker, animated: true, completion: {imagePicker.cameraOverlayView = zlabel}) // Activate the camera!
        } else { // You get this if you do not have a camera.
            let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert) // Create alerts
            let okaAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(okaAction)
            present(alertVC, animated: true, completion: nil) //Present alert
        }
    }
    

    
    
    
    @IBAction func photoLibraryAction(_ sender: UIButton) { // This is for testing saving without camera - just select from default found in emulators
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){ // if there's a photo library.
            let imagePicker = UIImagePickerController() // The image picker will pick the image
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary; // Set it to photo library selection
            imagePicker.allowsEditing = true // Allow user to edit, why not
            self.present(imagePicker, animated: true, completion: nil) // No overlay this time.
        }
    }
    
    @IBAction func saveAction(_ sender: UIButton) { // This is when user saves
        if pickedImaged.image != nil { // In the case that the user does not actually have anything captured.
            let imageData = UIImageJPEGRepresentation(pickedImaged.image!, 0.6) // Compression and data for insert into phone
            let compressedJPEGImage = UIImage(data: imageData!)
            UIImageWriteToSavedPhotosAlbum(compressedJPEGImage!, nil, nil, nil) // Saves to photo album
            saveNotice() // Alerts user that there's been a save.
        }
        else { // If there's nothing saved, give alert.
            let alertController = UIAlertController(title: "Select Image!", message: "Image not found!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil) // Present alert
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) { // This func sets current image stored on pickedImage to be made image.
        // Apparently called automatically be the camera function.
        pickedImaged.image = image
        self.dismiss(animated: true, completion: nil);
    }
    
    func saveNotice(){ // Gives notice on succesful save
        let alertController = UIAlertController(title: "Image Saved!", message: "Your picture was succesfully saved!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
