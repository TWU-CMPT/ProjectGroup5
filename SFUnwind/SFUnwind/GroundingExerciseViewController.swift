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
    
    
    @IBOutlet weak var pickedImaged: UIImageView! // Image UI we have on screen.
    
    var strings = ["[SEE]", "[TOUCH]", "[HEAR]"]
    var stringCount = 0
    
    @IBOutlet weak var theOverlay: UIImageView!

    @IBOutlet weak var theLabel: UILabel!
    
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController()
            let zlabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            zlabel.center = CGPoint(x: 160,y: 284)
            zlabel.textAlignment = .center
            zlabel.text = strings[stringCount]
            stringCount+=1
            stringCount = stringCount % 3
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            imagePicker.cameraCaptureMode = .photo
            imagePicker.showsCameraControls = true
            imagePicker.modalPresentationStyle = .fullScreen
            self.present(imagePicker, animated: true, completion: {imagePicker.cameraOverlayView = zlabel})
        } else {
            let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
            let okaAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(okaAction)
            present(alertVC, animated: true, completion: nil)
        }
    }
    

    
    
    
    @IBAction func photoLibraryAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        if pickedImaged.image != nil {
            let imageData = UIImageJPEGRepresentation(pickedImaged.image!, 0.6)
            let compressedJPEGImage = UIImage(data: imageData!)
            UIImageWriteToSavedPhotosAlbum(compressedJPEGImage!, nil, nil, nil)
            saveNotice()
        }
        else {
            let alertController = UIAlertController(title: "Select Image!", message: "Image not found!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        pickedImaged.image = image
        self.dismiss(animated: true, completion: nil);
    }
    
    func saveNotice(){
        let alertController = UIAlertController(title: "Image Saved!", message: "Your picture was succesfully saved!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
