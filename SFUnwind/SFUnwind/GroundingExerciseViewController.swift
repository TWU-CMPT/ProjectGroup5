//
// GroundingExerciseViewController.swift - View Controller for the Grounding Exercise Feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: David Magaril
// Contributing Programmers:
// Known issues:
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW4 Quality Assurance Documentation

import UIKit
import AVFoundation

class GroundingFeatureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate{
    
    // Properties:
    //******************
    
    // Grounding Exercise Goal Names (constants).
    let goalString = ["[ see ]", "[ touch ]", "[ hear ]"]
    
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
    
    // Grounding Exercise Blank Views
    var blankViews = [UIView]()
    
    // Grounding Exercise Path to Affirmations
    var pathToAff: String? = nil
    
    // Grounding Exercise Array of Mantras
    var arrayOfMantra = [String]()
    
    // Grounding Exercise Total Amount of Mantras
    var totalMantras: Int = 0
    
    // Grounding Exercise Mantra Indicator
    var mantraAvailable = false
    
    // Grounding Exercise Camera Failure Alert.
    let theAlert = UIAlertController(title: "For Testing", message: "Sorry, this device has no camera", preferredStyle: .alert)
    
    // Grounding Exercise Camera Failure Alert Reply.
    let theOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    // Grounding Exercise Calculation of Size of Thumbail
    let sizeOfThumb = min(UIScreen.main.bounds.height/8.0,UIScreen.main.bounds.width/5.0)
    
    // Grounding Exercise Camera Preview Layer
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        // Create preview layer
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let preview =  AVCaptureVideoPreviewLayer(session: self.cameraSession)
            // Set the bounds of the preview layer
            preview?.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            // Set the position of the preview layer
            preview?.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
            // Set the aspect ratio of the preview layer
            preview?.videoGravity = AVLayerVideoGravityResizeAspect
            return preview!
        }
        else {
            let preview = AVCaptureVideoPreviewLayer()
            return preview
        }
        
    }()
    
    // Grounding Exercise Camera Session
    lazy var cameraSession: AVCaptureSession = {
        // Create capture session
        let s = AVCaptureSession()
        // Sets quality of capture session
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            s.sessionPreset = AVCaptureSessionPresetLow
        }
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
    
    // Grounding Exercise Countdown
    @IBOutlet weak var countdown: UILabel!
    
    // GroundingFeatureViewController Class methods/functions:
    //**************************************************
    
    // ViewDidAppear: This function is called every time GroundingExerciseViewController is accessed.
    // This function is used to reset goal indexes and remove current pictures
    // Input: Animation Boolean
    // Output: None
    // No dependencies
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Starts the camera session
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            cameraSession.startRunning()
        }
        // Alters the UI elements appropiately
        // Reset Button --
        resetButton.isHidden = true
        resetButton.isEnabled = false
        self.resetButton.alpha = 1
        // Goal Display --
        goalDisplay.isHidden = false
        // Capture Button
        captureButton.isHidden = false
        captureButton.isEnabled = true
        // Preview Layer -- Remove all animation as well
        self.previewLayer.removeAllAnimations()
        previewLayer.isHidden = false
        previewLayer.opacity = 1
        // Put in blank screens
        for blank in 0...4 {
            self.blankViews[blank*2].isHidden = false
            self.blankViews[(blank*2)+1].isHidden = false
            self.blankViews[blank*2].alpha = 1
            self.blankViews[(blank*2)+1].alpha = 1
        }
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
        // ---
        self.goalDisplay.text = self.goalString[self.goalIndex]
        // SET TO WHITE
        var attAdd = NSMutableAttributedString.init(attributedString: self.goalDisplay.attributedText!)
        var range = ((self.goalDisplay.text as NSString?)!).range(of: self.goalDisplay.text!)
        attAdd.addAttribute(NSStrokeColorAttributeName, value: UIColor.white, range: range)
        attAdd.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: range)
        attAdd.addAttribute(NSStrokeWidthAttributeName, value: -2.5, range: range)
        self.goalDisplay.attributedText = NSAttributedString(attributedString: attAdd)
        // ---
        // Current Total Index Reset
        self.currentTotalIndex = 0
        // Inner Gaol Index Reset
        self.innerGoalIndex = 0
        // Max Goal Reset
        self.maxGoal = 5
        // Reset countdown
        // Sets up the countdown
        self.countdown.text = "0/5"
        // Reset countdown
        // SET TO WHITE
        //--
        attAdd = NSMutableAttributedString.init(attributedString: self.countdown.attributedText!)
        range = ((self.countdown.text as NSString?)!).range(of: self.countdown.text!)
        attAdd.addAttribute(NSStrokeColorAttributeName, value: UIColor.white, range: range)
        attAdd.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: range)
        attAdd.addAttribute(NSStrokeWidthAttributeName, value: -2.5, range: range)
        self.countdown.attributedText = NSAttributedString(attributedString: attAdd)
        //--
        // Set affirmation appropiately
        let desiredFile = "affirmations.txt"
        // Get path
        let thePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        // Get url
        let theURL = NSURL(fileURLWithPath: thePath)
        // Set pathToAff appropiately
        pathToAff = theURL.appendingPathComponent(desiredFile)?.path
        let theFileManager = FileManager.default
        // Checks if affirmations exist
        if theFileManager.fileExists(atPath: self.pathToAff!){
            do {
                // Get file content
                let getText = try String(contentsOfFile: self.pathToAff!)
                // Seperate content
                let tempArray = getText.components(separatedBy: "\n")
                // Check if empty
                if(tempArray[0] != ""){
                    self.arrayOfMantra = getText.components(separatedBy: "\n")
                }
                // Get the count of mantras
                self.totalMantras = self.arrayOfMantra.count
                // Check if there's any
                if(self.totalMantras != 0){
                    self.mantraAvailable = true
                }
            }
                //Catch error
            catch {
                print("error loading contents of url \(self.pathToAff!)")
                print(error.localizedDescription)
            }
        }
            // First time running or mantra file deleted
        else {
            
            // Attempt to open the file:
            guard let theFile = Bundle.main.path(forResource: "mantras", ofType: "txt", inDirectory: "positiveAffirmations") else {
                return // Return if the file can't be found
            }
            
            do {
                // Extract the file contents, and return them as a split string array
                let exportText = try String(contentsOfFile: theFile)
                // Seperate contents
                let tempArray = exportText.components(separatedBy: "\n")
                // Check if empty
                if(tempArray[0] != ""){
                    // Put contents in
                    self.arrayOfMantra = exportText.components(separatedBy: "\n")
                    // Check if last is "", remove if so
                    if self.arrayOfMantra.last == "" {
                        self.arrayOfMantra.removeLast()
                    }
                }
                
                //write to file
                var toWrite = String()
                // Put each string into array
                for stringInArray in self.arrayOfMantra {
                    // Check if last to make sure there isn't "\n" at end
                    if(stringInArray == self.arrayOfMantra.last!){
                        toWrite += (stringInArray)
                    }
                        // Write normally
                    else {
                        toWrite += (stringInArray + "\n")
                    }
                }
                // Write to new file
                try (toWrite).write(toFile: self.pathToAff!, atomically: false, encoding: .utf8)
                // Get mantra count
                self.totalMantras = self.arrayOfMantra.count
                // Check if mantra available
                if(self.totalMantras != 0){
                    self.mantraAvailable = true
                }
                
                // catch errors
            } catch let error as NSError { // Handle any exception: Return a nil if we have any issues
                print("error loading contents of url \(theFile)")
                print(error.localizedDescription)
            }
        }

    }
    
    
    
    // ViewDidLoad: This function is called once the GroundingExerciseViewController.swift object is first initialized.
    // This function is used to start up the UI elements, add the alert reply as needed, and sets up preview layer.
    // Input: None
    // Output: None
    // No dependencies
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
        captureButton.isOpaque = false
        // Activates exclusive touch of capture button
        captureButton.isExclusiveTouch = true
        // Activates multi touch of capture botton
        captureButton.isMultipleTouchEnabled = true
        // Sets the smooth corners of the reset button
        resetButton.layer.cornerRadius=20
        captureButton.alpha = 0.9
        // Activates exclusive touch of reset button
        resetButton.isExclusiveTouch = true
        //Activates multi touch of reset button
        resetButton.isMultipleTouchEnabled = true
        // Scales the buttons and goal displays
        //---
        self.goalDisplay.frame = CGRect(x: UIScreen.main.bounds.width*(1/6), y: UIScreen.main.bounds.height * (14.0/30.0), width: UIScreen.main.bounds.width*(2/3), height: UIScreen.main.bounds.width/8)
        self.captureButton.frame = CGRect(x: UIScreen.main.bounds.width/4, y: UIScreen.main.bounds.height * (6.5/10.0), width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/10)
        self.resetButton.frame = CGRect(x: UIScreen.main.bounds.width/4, y: UIScreen.main.bounds.height * (8.0/10.0), width:  UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/10)
        self.countdown.frame = CGRect(x: UIScreen.main.bounds.width*(1/6), y: UIScreen.main.bounds.height * (7.75/10.0), width: UIScreen.main.bounds.width*(2/3), height: UIScreen.main.bounds.width/8)
        //---
        // Hides the reset button for grid view
        resetButton.isHidden = true
        // Disables the reset button for grid view
        resetButton.isEnabled = false
        // Reveals the preview layer to user
        self.previewLayer.removeAllAnimations()
        previewLayer.isHidden = false
        // Adds white screens
        for blankView in self.blankViews {
            blankView.removeFromSuperview()
        }
        self.blankViews = [UIView]()
        // Apply correctly
        for blank in 0...4 {
            // Get spacing!
            let spacing: CGFloat = 2.0
            let down: CGFloat = 20.0
            // Outer square!
            self.blankViews.append(UIView())
            // Set frame
            self.blankViews[blank*2].frame = CGRect(x: self.sizeOfThumb*CGFloat(blank), y: down+0.0, width: self.sizeOfThumb, height: self.sizeOfThumb)
            // Set color
            self.blankViews[blank*2].backgroundColor = UIColor.white
            // Add view
            self.view.addSubview(self.blankViews[blank*2])
            // Inner square!
            self.blankViews.append(UIView())
            // Set frame
            self.blankViews[(blank*2) + 1].frame = CGRect(x: (self.sizeOfThumb*CGFloat(blank)) + spacing, y: down+spacing, width: self.sizeOfThumb-(spacing*2), height: self.sizeOfThumb-(spacing*2))
            // Set color
            self.blankViews[(blank*2) + 1].backgroundColor = UIColor.lightGray
            // Add view
            self.view.addSubview(self.blankViews[(blank*2) + 1])
        }
        // Bring info button to front
        self.helpButton.superview?.bringSubview(toFront: self.helpButton)
        // Resets the goal display
        goalDisplay.text = goalString[goalIndex]
        // Set text to white!
        var attAdd = NSMutableAttributedString.init(attributedString: self.goalDisplay.attributedText!)
        var range = ((self.goalDisplay.text as NSString?)!).range(of: self.goalDisplay.text!)
        attAdd.addAttribute(NSStrokeColorAttributeName, value: UIColor.white, range: range)
        attAdd.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: range)
        attAdd.addAttribute(NSStrokeWidthAttributeName, value: -2.5, range: range)
        self.goalDisplay.attributedText = NSAttributedString(attributedString: attAdd)
        // Allows the user to press Ok for alert
        theAlert.addAction(theOkAction)
        // Sets up the countdown
        self.countdown.text = "0/5"
        // Reset countdown
        // Set text to white
        attAdd = NSMutableAttributedString.init(attributedString: self.countdown.attributedText!)
        range = ((self.countdown.text as NSString?)!).range(of: self.countdown.text!)
        attAdd.addAttribute(NSStrokeColorAttributeName, value: UIColor.white, range: range)
        attAdd.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: range)
        attAdd.addAttribute(NSStrokeWidthAttributeName, value: -2.5, range: range)
        self.countdown.attributedText = NSAttributedString(attributedString: attAdd)
        // Sets up camera
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
    // Input: Storyboard Segue, Sender
    // Output: None
    // No dependencies
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? HelpViewController{
            nav.callingScreen = 1 // Notify the popup who's calling it: 0 = Square Breathing, 1 = Grounding, 2 = Positive Affirmations, 3 = Panic Alerts
        }
    }
    
    // resetButtonAction: This function resets the controller to the initial state
    // Input: Sender
    // Output: None
    // No dependencies
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
        // Preview Layer and remove animations
        self.previewLayer.removeAllAnimations()
        previewLayer.isHidden = false
        previewLayer.opacity = 1
        // Put in blank screens
        for blank in 0...4 {
            self.blankViews[blank*2].isHidden = false
            self.blankViews[(blank*2)+1].isHidden = false
            self.blankViews[blank*2].alpha = 1
            self.blankViews[(blank*2)+1].alpha = 1
        }
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
        // Set to white
        var attAdd = NSMutableAttributedString.init(attributedString: self.goalDisplay.attributedText!)
        var range = ((self.goalDisplay.text as NSString?)!).range(of: self.goalDisplay.text!)
        attAdd.addAttribute(NSStrokeColorAttributeName, value: UIColor.white, range: range)
        attAdd.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: range)
        attAdd.addAttribute(NSStrokeWidthAttributeName, value: -2.5, range: range)
        self.goalDisplay.attributedText = NSAttributedString(attributedString: attAdd)
        // Current Total Index Reset
        self.currentTotalIndex = 0
        // Inner Gaol Index Reset
        self.innerGoalIndex = 0
        // Max Goal Reset
        self.maxGoal = 5
        // Sets up the countdown
        self.countdown.text = "0/5"
        // Reset countdown
        // Set to white
        attAdd = NSMutableAttributedString.init(attributedString: self.countdown.attributedText!)
        range = ((self.countdown.text as NSString?)!).range(of: self.countdown.text!)
        attAdd.addAttribute(NSStrokeColorAttributeName, value: UIColor.white, range: range)
        attAdd.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: range)
        attAdd.addAttribute(NSStrokeWidthAttributeName, value: -2.5, range: range)
        self.countdown.attributedText = NSAttributedString(attributedString: attAdd)
        // Sets up camera
    }
    
    // cameraButtonAction: This function is called when the user presses the capture button.
    // Allows user to take pictures, display grid and modify the appropiate indexes. Will display error if needed.
    // Input: Sender
    // Output: None
    // Dependencies: Camera (otherwise warning showed).
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
                    self.allViews[self.currentTotalIndex].frame = CGRect(x: self.sizeOfThumb*CGFloat(self.innerGoalIndex), y: -self.sizeOfThumb, width: self.sizeOfThumb, height: self.sizeOfThumb)
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
                    self.allViews[self.currentTotalIndex].alpha = 1
                    // Checks if still valid
                    if self.maxGoal != 0 && self.currentTotalIndex < 45 {
                        // Create CALayer animation
                        let previewAnimation = CABasicAnimation(keyPath: "opacity")
                        // From and to
                        previewAnimation.fromValue = 0.5
                        previewAnimation.toValue = 1
                        // Duration is short
                        previewAnimation.duration = 0.3
                        previewAnimation.autoreverses = false
                        self.previewLayer.add(previewAnimation, forKey: "opacity")
                        // Adds the picture view to controller view
                        self.view.addSubview(self.allViews[self.currentTotalIndex])
                        // Animate new photo to place
                        UIView.animate(withDuration: 1, animations: {
                            // Set the image animation correctly
                            self.allViews[self.currentTotalIndex].frame = CGRect(x: self.sizeOfThumb*CGFloat(self.innerGoalIndex), y: 20.0+0.0, width: self.sizeOfThumb, height: self.sizeOfThumb)
                        })
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
                            // Remove blank screen
                            UIView.animate(withDuration: 2, animations: {
                                self.blankViews[((self.maxGoal-1)*2)].alpha = 0
                                self.blankViews[((self.maxGoal-1)*2+1)].alpha = 0
                            })
                            // Decrement the max goal for 1 less picture per round
                            self.maxGoal-=1
                            // Reset goal index
                            self.goalIndex = 0
                        }
                        // Set current goal to correct index
                        // Set goal appropiately white
                        self.goalDisplay.text = self.goalString[self.goalIndex]
                        let attAdd = NSMutableAttributedString.init(attributedString: self.goalDisplay.attributedText!)
                        let range = ((self.goalDisplay.text as NSString?)!).range(of: self.goalDisplay.text!)
                        attAdd.addAttribute(NSStrokeColorAttributeName, value: UIColor.white, range: range)
                        attAdd.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: range)
                        attAdd.addAttribute(NSStrokeWidthAttributeName, value: -2.5, range: range)
                        self.goalDisplay.attributedText = NSAttributedString(attributedString: attAdd)
                        // Check if grid is now needed to be display
                        if(self.maxGoal==0){
                            // Hide countdown
                            self.countdown.text = ""
                            // Hide capture button
                            self.captureButton.isHidden = true
                            // Disable capture button
                            self.captureButton.isEnabled = false
                            // Hide goal display
                            self.goalDisplay.isHidden = true
                            // Disable reset button
                            self.resetButton.isEnabled = false
                            // Reveal reset button
                            self.resetButton.isHidden = false
                            // Hide the camera preview
                            // Create CALayer animation
                            // Remove all first
                            self.previewLayer.removeAllAnimations()
                            let previewAnimation = CABasicAnimation(keyPath: "opacity")
                            previewAnimation.fromValue = 1
                            previewAnimation.toValue = 0
                            previewAnimation.duration = 4
                            previewAnimation.autoreverses = false
                            previewAnimation.fillMode = kCAFillModeForwards
                            previewAnimation.isRemovedOnCompletion = false
                            self.previewLayer.add(previewAnimation, forKey: "opacity")
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
                            self.resetButton.alpha = 0
                            for tagger in 0...self.totalMax-1 {
                                // Check if program reached divisor
                                if rightLength == divisor {
                                    // Reset right offset
                                    rightLength=0.0
                                    // Increment going down
                                    downHeight+=1
                                }
                                var xVal = gridSize*CGFloat(rightLength)
                                if downHeight == topDiv {
                                    xVal += offset
                                }
                                // Apply offset, and move picture to right spot
                                self.allViews[tagger].frame = CGRect(x: xVal, y: UIScreen.main.bounds.height, width: gridSize, height: gridSize)
                                UIView.animate(withDuration: 2, delay: Double(tagger)*0.1, options: .curveEaseOut, animations: {
                                    self.allViews[tagger].frame = CGRect(x: xVal, y: gridSize*CGFloat(downHeight), width: gridSize, height: gridSize)
                                    
                                }, completion: nil)
                                // Reveal picture to user
                                self.allViews[tagger].alpha = 0
                                self.allViews[tagger].isHidden = false
                                // Reveal to user in animation
                                if(tagger != self.totalMax-1){
                                    UIView.animate(withDuration: 1, delay: Double(tagger)*0.1, options: .curveEaseOut, animations: {
                                        self.allViews[tagger].alpha = 1
                                    }, completion: nil)
                                }
                                else {
                                    // Create animation to move to grid display
                                    UIView.animate(withDuration: 1, delay: Double(tagger)*0.1, options: .curveEaseOut, animations: {
                                        self.allViews[tagger].alpha = 1
                                    }, completion: { (finished: Bool) -> Void in
                                        // Create animation to reveal to user
                                        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                                            self.resetButton.alpha = 1
                                        }, completion: {
                                            (finished: Bool) -> Void in
                                            // Set reset button
                                            if(self.resetButton.isHidden == false){
                                                self.resetButton.isEnabled = true
                                                // Display mantra to user
                                                if(self.mantraAvailable == true){
                                                    // Get mantra settings
                                                    let dMantra = UIAlertController(title: "A Positive Affirmation:", message: self.arrayOfMantra[Int(arc4random_uniform(UInt32(self.arrayOfMantra.count)))], preferredStyle: .alert)
                                                    // Get user reply
                                                    let theOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                                    dMantra.addAction(theOkAction)
                                                    // Present as alert to user
                                                    self.present(dMantra, animated: true, completion: nil)                                           }
                                            }
                                        })
                                    })
                                }
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
                    // Reset countdown
                    self.countdown.text = String(self.innerGoalIndex) + "/" + String(self.maxGoal)
                    // Set text to white!
                    let attAdd = NSMutableAttributedString.init(attributedString: self.countdown.attributedText!)
                    let range = ((self.countdown.text as NSString?)!).range(of: self.countdown.text!)
                    attAdd.addAttribute(NSStrokeColorAttributeName, value: UIColor.white, range: range)
                    attAdd.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: range)
                    attAdd.addAttribute(NSStrokeWidthAttributeName, value: -2.5, range: range)
                    self.countdown.attributedText = NSAttributedString(attributedString: attAdd)
                    // Re-enable capture button
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
