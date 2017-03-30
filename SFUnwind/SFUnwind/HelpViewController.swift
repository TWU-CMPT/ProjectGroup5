//
// HelpViewController.swift - Help view Controller for all screens
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: All
// Contributing Programmers: All
// Known issues: 
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import Foundation
import UIKit
import QuartzCore


class HelpViewController: UIViewController {
    // Variables:
    //************
    var helpString = String()   // The string of help text: Is loaded from file by the populateHelpText() function
    var callingScreen = 0   // The feature screen that called the help popup: 0 = Square Breathing, 1 = Grounding, 2 = Positive Affirmations, 3 = Panic Alerts
    let helpTextFilenames = ["squareBreathing", "grounding", "positiveAffirmations", "panicAlerts"] // Store the help text file names in a (constant) array for easy access
    
    
    // UI Elements:
    //**************
    @IBOutlet weak var helpScreenText: UILabel!
    
    @IBOutlet weak var UIScrollView: UIScrollView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func closeHelpScreen(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    // Class Methods:
    //***************
    
    // Called once the first time this view is displayed
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        populateHelpText(screenNumber: callingScreen)
        
        // Set teh help screen text, and format it:
        helpScreenText.text = helpString
        helpScreenText.sizeToFit()
        //helpScreenText.numberOfLines = 0
        //helpScreenText.adjustsFontSizeToFitWidth = true
        
        // Format the close button:
        //closeButton.sizeToFit()
        //closeButton.titleLabel?.numberOfLines = 0
        //closeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        var theContent = CGRect.zero
        for theView in self.UIScrollView.subviews {
            theContent = theContent.union(theView.frame)
        }
        self.UIScrollView.contentSize = theContent.size
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func populateHelpText(screenNumber: Int){
        // Set some debug text, to make debugging easier:
        helpString = "Default help screen text. If you're seeing this, chances are the HelpViewController.swift populateHelpText() function had a problem!"
        
        // Attempt to open the file:
        guard let theFile = Bundle.main.path( forResource: helpTextFilenames[callingScreen], ofType: "txt", inDirectory: "helpFiles") else {
            return // Return if the file can't be found
        }
        
        do { // Extract the file contents, and return them as a split string array
            helpString = try String(contentsOfFile: theFile)
            
        } catch _ as NSError { // Handle any exception: Return a nil if we have any issues
            return
        }
    }

} // End Help view controller
