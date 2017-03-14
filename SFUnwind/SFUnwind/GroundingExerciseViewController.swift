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
import AVFoundation

class GroundingFeatureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate{
    
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
    @IBOutlet weak var helpButton: UIButton!
    
    // Grounding Exercise Current Goal Display
    @IBOutlet weak var goalDisplay: UILabel!
    
    // GroundingFeatureViewController Class methods/functions:
    //**************************************************
    
    // ViewDidLoad: This function is called once the GroundingExerciseViewController.swift object is first initialized.
    // This function is used to start up the UI elements, and add the alert reply as needed.
    
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let preview =  AVCaptureVideoPreviewLayer(session: self.cameraSession)
        preview?.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        preview?.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        preview?.videoGravity = AVLayerVideoGravityResizeAspect
        return preview!
    }()
    
    lazy var cameraSession: AVCaptureSession = {
        let s = AVCaptureSession()
        s.sessionPreset = AVCaptureSessionPresetLow
        return s
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.layer.insertSublayer(previewLayer, at: 0)
        
        cameraSession.startRunning()
    }
    
    var stillImageOutput = AVCaptureStillImageOutput.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captureButton.layer.cornerRadius=20
        goalDisplay.text = goalString[goalIndex]
        theAlert.addAction(theOkAction)
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) as AVCaptureDevice
            do {
                let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
                cameraSession.beginConfiguration()
                if (cameraSession.canAddInput(deviceInput) == true) {
                    cameraSession.addInput(deviceInput)
                }
                let dataOutput = AVCaptureVideoDataOutput()
                dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange as UInt32)]
                dataOutput.alwaysDiscardsLateVideoFrames = true
                if (cameraSession.canAddOutput(dataOutput) == true) {
                    cameraSession.addOutput(dataOutput)
                }
                cameraSession.commitConfiguration()
                let queue = DispatchQueue(label: "forCamera")
                dataOutput.setSampleBufferDelegate(self, queue: queue)
            }
            catch let error as NSError {
                NSLog("\(error), \(error.localizedDescription)")
            }
            stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            self.cameraSession.addOutput(stillImageOutput)
        }
    }
    // Modify help screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let DestViewController : HelpViewController = segue.destination as!HelpViewController
        let nav = segue.destination as! UINavigationController
        let svc = nav.topViewController as! HelpViewController
        svc.helpString = "OMG"
    }
    
    // cameraButtonAction: This function is called when the user presses the appropiate button.
    // This function is used to start up the camera, or display an error through an alert message to indicate a camera is not installed.
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        // Test if camera exists
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            if let videoConnection = stillImageOutput.connection(withMediaType:AVMediaTypeVideo){
                stillImageOutput.captureStillImageAsynchronously(from:videoConnection, completionHandler: {
                    (sampleBuffer, error) in
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider = CGDataProvider.init(data: imageData as! CFData)
                    let cgImageRef = CGImage.init(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
                    let image = UIImage.init(cgImage: cgImageRef!, scale: 1.0, orientation: .right)
                    // do something with image
                    self.goalIndex+=1 // Move index
                    self.goalIndex = self.goalIndex % 3
                    self.goalDisplay.text = self.goalString[self.goalIndex]
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                })
            }
        } else { // You get this if you do not have a camera.
            // For testing.
            theAlert.title = "No Camera"
            // Present alert to user.
            present(theAlert, animated: true, completion: nil) //Present alert
        }
    }
}
