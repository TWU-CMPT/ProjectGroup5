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

extension UIView {
    func setToX(x:CGFloat){
        var frame:CGRect = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    func setToY(y:CGFloat) {
        var frame:CGRect=self.frame
        frame.origin.y = y
        self.frame = frame
    }
    func setToW(w:CGFloat){
        var frame:CGRect = self.frame
        frame.size.width = w
        self.frame = frame
    }
    func setToH(h:CGFloat){
        var frame:CGRect = self.frame
        frame.size.height = h
        self.frame = frame
    }
}

class GroundingFeatureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate{
    
    // Properties:
    //******************
    
    // Grounding Exercise Goal Names (constants).
    let goalString = ["[SEE]", "[TOUCH]", "[HEAR]"]
    
    // Grounding Exercise Current Index (constant).
    var goalIndex = 0
    var currentTotalIndex = 0
    var innerGoalIndex = 0
    var maxGoal = 5
    let totalMax = ((1+2+3+4+5)*3)
    var allViews = [UIImageView]()
    
    
    // Grounding Exercise Camera Failure Alert.
    let theAlert = UIAlertController(title: "For Testing", message: "Sorry, this device has no camera", preferredStyle: .alert)
    
    // Grounding Exercise Camera Failure Alert Reply.
    let theOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    let sizeOfThumb = (UIScreen.main.bounds.width/5.0)
    
    // UI Buttons:
    //************
    
    // Grounding Exercise Camera Capture Button
    @IBOutlet weak var captureButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
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
        cameraSession.startRunning()
        resetButton.isHidden = true
        resetButton.isEnabled = false
        captureButton.isHidden = false
        captureButton.isEnabled = true
        previewLayer.isHidden = false
        for tagger in 0...self.totalMax-1 {
            if let taggedView = self.view.viewWithTag(60+tagger) {
                taggedView.removeFromSuperview()
            }
        }
        self.goalIndex = 0
        self.goalDisplay.text = self.goalString[self.goalIndex]
        self.currentTotalIndex = 0
        self.innerGoalIndex = 0
        self.maxGoal = 5
    }
    
    var stillImageOutput = AVCaptureStillImageOutput.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...self.totalMax {
            self.allViews.append(UIImageView())
        }
        view.layer.insertSublayer(previewLayer, at: 0)
        captureButton.layer.cornerRadius=20
        captureButton.isExclusiveTouch = true
        captureButton.isMultipleTouchEnabled = true
        resetButton.layer.cornerRadius=20
        resetButton.isExclusiveTouch = true
        resetButton.isMultipleTouchEnabled = true
        self.goalDisplay.tag = 106
        self.captureButton.tag = 107
        self.resetButton.tag = 108
        self.goalDisplay.frame = CGRect(x: UIScreen.main.bounds.width*(1/6), y: UIScreen.main.bounds.height * (2.5/10.0), width: UIScreen.main.bounds.width*(2/3), height: UIScreen.main.bounds.width/8)
        self.captureButton.frame = CGRect(x: UIScreen.main.bounds.width/4, y: UIScreen.main.bounds.height * (4.5/10.0), width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/10)
        self.resetButton.frame = CGRect(x: UIScreen.main.bounds.width/4, y: UIScreen.main.bounds.height * (8.0/10.0), width:  UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/10)
        resetButton.isHidden = true
        resetButton.isEnabled = false
        previewLayer.isHidden = false
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
        let nav = segue.destination as! HelpViewController
        nav.callingScreen = 1 // Notify the popup who's calling it: 0 = Square Breathing, 1 = Grounding, 2 = Positive Affirmations, 3 = Panic Alerts
    }
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
        resetButton.isHidden = true
        resetButton.isEnabled = false
        captureButton.isHidden = false
        captureButton.isEnabled = true
        previewLayer.isHidden = false
        for tagger in 0...self.totalMax-1 {
            if let taggedView = self.view.viewWithTag(60+tagger) {
                taggedView.removeFromSuperview()
            }
        }
        self.goalIndex = 0
        self.goalDisplay.text = self.goalString[self.goalIndex]
        self.currentTotalIndex = 0
        self.innerGoalIndex = 0
        self.maxGoal = 5
    }
    
    // cameraButtonAction: This function is called when the user presses the appropiate button.
    // This function is used to start up the camera, or display an error through an alert message to indicate a camera is not installed.
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        // Test if camera exists
        self.captureButton.isEnabled = false
        if(self.captureButton.isEnabled == true){
            print("FAIL1")
            return
        }
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            if let videoConnection = stillImageOutput.connection(withMediaType:AVMediaTypeVideo) {
                stillImageOutput.captureStillImageAsynchronously(from:videoConnection, completionHandler: {
                    (sampleBuffer, error) in
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider = CGDataProvider.init(data: imageData as! CFData)
                    let cgImageRef = CGImage.init(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
                    let image = UIImage.init(cgImage: cgImageRef!, scale: 1.0, orientation: .right)
                    // do something with image
                    self.allViews[self.currentTotalIndex] = UIImageView(image: image)
                    self.allViews[self.currentTotalIndex].frame = CGRect(x: self.sizeOfThumb*CGFloat(self.innerGoalIndex), y: 0.0, width: self.sizeOfThumb, height: self.sizeOfThumb)
                     self.allViews[self.currentTotalIndex].tag = 60 + self.currentTotalIndex
                    if(self.innerGoalIndex == 0){
                        for hider in 0...self.currentTotalIndex {
                            self.allViews[hider].isHidden = true
                        }
                    }
                    if(self.captureButton.isEnabled == true){
                        print("FAIL2")
                        return
                    }
                    self.allViews[self.currentTotalIndex].isHidden = false
                    if self.maxGoal != 0 && self.currentTotalIndex < 45 {
                        self.view.addSubview(self.allViews[self.currentTotalIndex])
                    }
                    else {
                        print("FAIL3")
                        return
                    }
                    self.currentTotalIndex+=1
                    self.innerGoalIndex+=1
                    if(self.innerGoalIndex==self.maxGoal){
                        self.innerGoalIndex=0
                        self.goalIndex+=1 // Move index
                        if(self.goalIndex == 3){
                            self.maxGoal-=1
                            self.goalIndex = 0
                        }
                        self.goalDisplay.text = self.goalString[self.goalIndex]
                        if(self.maxGoal==0){
                            self.captureButton.isHidden = true
                            self.captureButton.isEnabled = false
                            //print(self.helpButton)
                            self.resetButton.isEnabled = true
                            self.resetButton.isHidden = false
                            self.previewLayer.isHidden = true
                            var downHeight = 0.0
                            var rightLength = 0.0
                            let divisor = 6.0
                            let topDiv = 7.0
                            let offset = (UIScreen.main.bounds.width - ((UIScreen.main.bounds.width/CGFloat(divisor))*3))/2
                            let gridSize = (UIScreen.main.bounds.width/CGFloat(divisor))
                            for tagger in 0...self.totalMax-1 {
                                if rightLength == divisor {
                                    rightLength=0.0
                                    downHeight+=1
                                }
                                //if let taggedView = self.view.viewWithTag(60+tagger) {
                                //    taggedView.removeFromSuperview()
                                //}
                                //print(tagger)
                                if downHeight == topDiv {
                                    self.allViews[tagger].frame = CGRect(x: gridSize*CGFloat(rightLength) + offset, y: gridSize*CGFloat(downHeight), width: gridSize, height: gridSize)
                                }
                                else{
                                    self.allViews[tagger].frame = CGRect(x: gridSize*CGFloat(rightLength), y: gridSize*CGFloat(downHeight), width: gridSize, height: gridSize)
                                }
                                self.allViews[tagger].isHidden = false
                                //self.allViews[tagger].center = CGPoint(x: self.sizeOfThumb*CGFloat(rightLength),y: self.sizeOfThumb*CGFloat(downHeight))
                                //print(self.sizeOfThumb*CGFloat(rightLength))
                                //print(self.sizeOfThumb*CGFloat(downHeight))
                                rightLength+=1
                                //self.view.addSubview(self.allViews[tagger])
                            }
                            self.maxGoal=5
                            self.currentTotalIndex = 0
                        }
                    }
                    //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    self.captureButton.isEnabled = true
                })
            }
        } else { // You get this if you do not have a camera.
            // For testing.
            theAlert.title = "No Camera"
            // Present alert to user.
            present(theAlert, animated: true, completion: nil) //Present alert
            self.captureButton.isEnabled = true
        }
        
    }
}
