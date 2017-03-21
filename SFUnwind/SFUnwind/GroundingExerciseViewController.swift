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
    
    // Grounding Exercise Goal Current Index
    var goalIndex = 0
    
    // Grounding Exercise Goal Current Index Max
    var currentTotalIndex = 0
    
    // Grounding Exercise Inner Goal Current Index
    var innerGoalIndex = 0
    
    // Grounding Exercise Current Maximum Inner Goal
    var maxGoal = 5
    
    // Grounding Exercise Maximum Amount of Photos Taken
    let totalMax = ((1+2+3+4+5)*3)
    
    // Grounding Exercise Array of Pictures
    var allViews = [UIImageView]()
    
    // Grounding Exercise Camera Failure Alert.
    let theAlert = UIAlertController(title: "For Testing", message: "Sorry, this device has no camera", preferredStyle: .alert)
    
    // Grounding Exercise Camera Failure Alert Reply.
    let theOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    // Grounding Exercise Calculation of Size of Thumbail
    let sizeOfThumb = (UIScreen.main.bounds.width/5.0)
    
    // Grounding Exercise Camera Preview Layer
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        // Create preview layer
        let preview =  AVCaptureVideoPreviewLayer(session: self.cameraSession)
        // Set the bounds of the preview layer
        preview?.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        // Set the position of the preview layer
        preview?.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        // Set the aspect ratio of the preview layer
        preview?.videoGravity = AVLayerVideoGravityResizeAspect
        return preview!
    }()
    
    // Grounding Exercise Camera Session
    lazy var cameraSession: AVCaptureSession = {
        // Create capture session
        let s = AVCaptureSession()
        // Sets quality of capture session
        s.sessionPreset = AVCaptureSessionPresetLow
        return s
    }()
    
    // Grounding Exercise Image Capturer Output
    var stillImageOutput = AVCaptureStillImageOutput.init()
    
    // UI Buttons:
    //************
    
    // Grounding Exercise Camera Capture Button
    @IBOutlet weak var captureButton: UIButton!
    
    // Grounding Exercise Reset Button
    @IBOutlet weak var resetButton: UIButton!
    
    // Grounding Exercise Help Button
    @IBOutlet weak var helpButton: UIButton!
    
    // UI Labels:
    //************
    
    // Grounding Exercise Current Goal Display
    @IBOutlet weak var goalDisplay: UILabel!
    
    // GroundingFeatureViewController Class methods/functions:
    //**************************************************
    
    // ViewDidAppear: This function is called every time GroundingExerciseViewController is accessed.
    // This function is used to reset goal indexes and remove current pictures
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Starts the camera session
        cameraSession.startRunning()
        // Alters the UI elements appropiately
        // Reset Button
        resetButton.isHidden = true
        resetButton.isEnabled = false
        // Goal Display
        goalDisplay.isHidden = false
        // Capture Button
        captureButton.isHidden = false
        captureButton.isEnabled = true
        // Preview Layer
        previewLayer.isHidden = false
        // Removes all picture from screen
        for tagger in 0...self.totalMax-1 {
            // Check for each with tag
            if let taggedView = self.view.viewWithTag(60+tagger) {
                // Remove from screen
                taggedView.removeFromSuperview()
            }
        }
        // Resets all indexes for current goal
        // Goat Index Reset
        self.goalIndex = 0
        // Goal Display Reset
        self.goalDisplay.text = self.goalString[self.goalIndex]
        // Current Total Index Reset
        self.currentTotalIndex = 0
        // Inner Gaol Index Reset
        self.innerGoalIndex = 0
        // Max Goal Reset
        self.maxGoal = 5
    }
    
    
    
    // ViewDidLoad: This function is called once the GroundingExerciseViewController.swift object is first initialized.
    // This function is used to start up the UI elements, add the alert reply as needed, and sets up preview layer.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add empty images to picture array
        for _ in 1...self.totalMax {
            self.allViews.append(UIImageView())
        }
        // Insert preview layer to back-most layer
        view.layer.insertSublayer(previewLayer, at: 0)
        // Sets the smooth corners of the capture button
        captureButton.layer.cornerRadius=20
        // Activates exclusive touch of capture button
        captureButton.isExclusiveTouch = true
        // Activates multi touch of capture botton
        captureButton.isMultipleTouchEnabled = true
        // Sets the smooth corners of the reset button
        resetButton.layer.cornerRadius=20
        // Activates exclusive touch of reset button
        resetButton.isExclusiveTouch = true
        //Activates multi touch of reset button
        resetButton.isMultipleTouchEnabled = true
        // Scales the buttons and goal display
        //---
        self.goalDisplay.frame = CGRect(x: UIScreen.main.bounds.width*(1/6), y: UIScreen.main.bounds.height * (2.5/10.0), width: UIScreen.main.bounds.width*(2/3), height: UIScreen.main.bounds.width/8)
        self.captureButton.frame = CGRect(x: UIScreen.main.bounds.width/4, y: UIScreen.main.bounds.height * (4.5/10.0), width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/10)
        self.resetButton.frame = CGRect(x: UIScreen.main.bounds.width/4, y: UIScreen.main.bounds.height * (8.0/10.0), width:  UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/10)
        //---
        // Hides the reset button for grid view
        resetButton.isHidden = true
        // Disables the reset button for grid view
        resetButton.isEnabled = false
        // Reveals the preview layer to user
        previewLayer.isHidden = false
        // Resets the goal display
        goalDisplay.text = goalString[goalIndex]
        // Allows the user to press Ok for alert
        theAlert.addAction(theOkAction)
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            // Obtain the capture device available
            let theCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) as AVCaptureDevice
            do {
                // Obtain input from available capture device
                let deviceInput = try AVCaptureDeviceInput(device: theCaptureDevice)
                // Configures current session for camera
                cameraSession.beginConfiguration()
                // If there's input, add input to camera session
                if (cameraSession.canAddInput(deviceInput) == true) {
                    // Adds the input
                    cameraSession.addInput(deviceInput)
                }
                // Obtain data output
                let dOutput = AVCaptureVideoDataOutput()
                // Update the video settings for output
                dOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange as UInt32)]
                // Remove frames that are late
                dOutput.alwaysDiscardsLateVideoFrames = true
                //  Add output if there output can be added
                if (cameraSession.canAddOutput(dOutput) == true) {
                    // Add the output
                    cameraSession.addOutput(dOutput)
                }
                // Commit the configureation that we set
                cameraSession.commitConfiguration()
                // Set the delegate sample to self
                dOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "forCamera"))
            }
            catch _ as NSError {
                //Print error
                print("ERROR")
            }
            // Set output settings for output
            stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            // Add the output to the camera session
            self.cameraSession.addOutput(stillImageOutput)
        }
    }
    
    // prepare: Modify help screen to the specific text for within
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? HelpViewController{
            nav.callingScreen = 1 // Notify the popup who's calling it: 0 = Square Breathing, 1 = Grounding, 2 = Positive Affirmations, 3 = Panic Alerts
        }
    }
    
    // resetButtonAction: This function resets the controller to the initial state
    @IBAction func resetButtonAction(_ sender: UIButton) {
        // Alters the UI elements appropiately
        // Reset Button
        resetButton.isHidden = true
        resetButton.isEnabled = false
        // Goal Display
        goalDisplay.isHidden = false
        // Capture Button
        captureButton.isHidden = false
        captureButton.isEnabled = true
        // Preview Layer
        previewLayer.isHidden = false
        // Removes all picture from screen
        for tagger in 0...self.totalMax-1 {
            // Check for each with tag
            if let taggedView = self.view.viewWithTag(60+tagger) {
                // Remove from screen
                taggedView.removeFromSuperview()
            }
        }
        // Resets all indexes for current goal
        // Goat Index Reset
        self.goalIndex = 0
        // Goal Display Reset
        self.goalDisplay.text = self.goalString[self.goalIndex]
        // Current Total Index Reset
        self.currentTotalIndex = 0
        // Inner Gaol Index Reset
        self.innerGoalIndex = 0
        // Max Goal Reset
        self.maxGoal = 5
    }
    
    // cameraButtonAction: This function is called when the user presses the capture button.
    // Allows user to take pictures, display grid and modify the appropiate indexes. Will display error if needed.
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        // Create a lock for input.
        self.captureButton.isEnabled = false
        // Deny entry
        if(self.captureButton.isEnabled == true){
            // Denies all invalid entry
            return
        }
        // Test if camera exists
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            // Obtain video connection. Deny all that can't connect
            if let videoConnection = stillImageOutput.connection(withMediaType:AVMediaTypeVideo) {
                // Capture still image with connection
                stillImageOutput.captureStillImageAsynchronously(from:videoConnection, completionHandler: {
                    (sampleBuffer, error) in
                    // Transform image to jpeg
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    // Obtain image data
                    let dataProvider = CGDataProvider.init(data: imageData as! CFData)
                    // Transform into CGImage
                    let cgImageRef = CGImage.init(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
                    // Transform into UIImage for display
                    let image = UIImage.init(cgImage: cgImageRef!, scale: 1.0, orientation: .right)
                    // Put image into array
                    self.allViews[self.currentTotalIndex] = UIImageView(image: image)
                    // Move and scale the image to appropiate place
                    self.allViews[self.currentTotalIndex].frame = CGRect(x: self.sizeOfThumb*CGFloat(self.innerGoalIndex), y: 0.0, width: self.sizeOfThumb, height: self.sizeOfThumb)
                    // Set the tag for overlay on picture
                    self.allViews[self.currentTotalIndex].tag = 60 + self.currentTotalIndex
                    // Hide all previous pictures when goal is changed
                    if(self.innerGoalIndex == 0){
                        // Hide each one
                        for hider in 0...self.currentTotalIndex {
                            // Hide this specific one
                            self.allViews[hider].isHidden = true
                        }
                    }
                    // Do a rec-check in case of edge case for thread entry
                    if(self.captureButton.isEnabled == true){
                        return
                    }
                    // Sets current picture to visible
                    self.allViews[self.currentTotalIndex].isHidden = false
                    // Checks if still valid
                    if self.maxGoal != 0 && self.currentTotalIndex < 45 {
                        // Adds the picture view to controller view
                        self.view.addSubview(self.allViews[self.currentTotalIndex])
                    }
                    else {
                        // Return if invalid
                        return
                    }
                    // Increment through indexe
                    self.currentTotalIndex+=1
                    // Increment through inner indexe
                    self.innerGoalIndex+=1
                    // Bring help button to top
                    self.helpButton.superview?.bringSubview(toFront: self.helpButton)
                    // Check is inner goal is finished
                    if(self.innerGoalIndex==self.maxGoal){
                        // Resets inner goal index
                        self.innerGoalIndex=0
                        // Decrements the goal index
                        self.goalIndex+=1
                        // If we went through entire goal array
                        if(self.goalIndex == 3){
                            // Decrement the max goal for 1 less picture per round
                            self.maxGoal-=1
                            // Reset goal index
                            self.goalIndex = 0
                        }
                        // Set current goal to correct index
                        self.goalDisplay.text = self.goalString[self.goalIndex]
                        // Check if grid is now needed to be display
                        if(self.maxGoal==0){
                            // Hide capture button
                            self.captureButton.isHidden = true
                            // Disable capture button
                            self.captureButton.isEnabled = false
                            // Hide goal display
                            self.goalDisplay.isHidden = true
                            // Enable reset button
                            self.resetButton.isEnabled = true
                            // Reveal reset button
                            self.resetButton.isHidden = false
                            // Hide the camera preview
                            self.previewLayer.isHidden = true
                            // Find y for each picture
                            var downHeight = 0.0
                            // Find x for each picture
                            var rightLength = 0.0
                            // Determine how many pictures per row
                            let divisor = 6.0
                            // Determines when pictures will be set to center
                            let topDiv = 7.0
                            // Determines offset for when pictures will be centered
                            let offset = (UIScreen.main.bounds.width - ((UIScreen.main.bounds.width/CGFloat(divisor))*3))/2
                            // Obtain the size of each grid
                            let gridSize = (UIScreen.main.bounds.width/CGFloat(divisor))
                            // Obtain each picture, display in grid
                            for tagger in 0...self.totalMax-1 {
                                // Check if program reached divisor
                                if rightLength == divisor {
                                    // Reset right offset
                                    rightLength=0.0
                                    // Increment going down
                                    downHeight+=1
                                }
                                // Check if we reach for center
                                if downHeight == topDiv {
                                    // Apply offset, and move picture to right spot
                                    self.allViews[tagger].frame = CGRect(x: gridSize*CGFloat(rightLength) + offset, y: gridSize*CGFloat(downHeight), width: gridSize, height: gridSize)
                                }
                                // Else, do it regularly
                                else{
                                    // Move picture to right spot
                                    self.allViews[tagger].frame = CGRect(x: gridSize*CGFloat(rightLength), y: gridSize*CGFloat(downHeight), width: gridSize, height: gridSize)
                                }
                                // Reveal picture to user
                                self.allViews[tagger].isHidden = false
                                // Pushes future pictures to the right
                                rightLength+=1
                            }
                            // Bring reset button to the front
                            self.resetButton.superview?.bringSubview(toFront: self.resetButton)
                            // Bring capture button to the front
                            self.captureButton.superview?.bringSubview(toFront: self.captureButton)
                            // Bring goal display to the front
                            self.goalDisplay.superview?.bringSubview(toFront: self.goalDisplay)
                            // Bring help button to the front
                            self.helpButton.superview?.bringSubview(toFront: self.helpButton)
                            // Reset goal max
                            self.maxGoal=5
                            // Reset current total index
                            self.currentTotalIndex = 0
                            return
                        }
                    }
                    self.captureButton.isEnabled = true
                })
            }
        } else { // You get this if you do not have a camera.
            // For testing.
            theAlert.title = "No Camera"
            // Present alert to user.
            present(theAlert, animated: true, completion: nil) //Present alert
            // Re-enable capture button
            self.captureButton.isEnabled = true
        }
        
    }
}
