//
// StatisticsViewController.swift - View Controller for the "Statistics feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmers: David Magaril, Berke Boz
// Contributing Programmers:
// Known issues: -
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import UIKit



class StatisticsViewController: UIViewController {

    
    var shortestSession: Double = 999                                           //999 set for ease of detection for shortest session
    var averageTime: Double = 0                                                 //Average time decleration
    var longestSession: Double = 0                                              //Longest value decleration
    var totalNumber = 0                                                         //TotalNumber of sessions tracking decleration
    
    var allViews = [UIView]()
    
    //Declerations of User Interface Labels and User Interface Buttons
    @IBOutlet weak var totalNumberOfSessionsLabel: UILabel!
    @IBOutlet weak var longestSessionLabel: UILabel!
    @IBOutlet weak var shortestSessionLabel: UILabel!
    @IBOutlet weak var averageTimeLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBAction func restartAllButton(_ sender: Any){
        
        UserDefaults.standard.set(0, forKey: "averageSession")                  //Reset everything that is tracked
        UserDefaults.standard.set(999, forKey: "minSession")
        UserDefaults.standard.set(0, forKey: "maxSession")
        UserDefaults.standard.set(0, forKey: "totalSessions")
        UserDefaults.standard.set(0, forKey: "lastSession")
        UserDefaults.standard.set(0, forKey: "totalSecs")
        UserDefaults.standard.set(0, forKey: "totalMins")
        UserDefaults.standard.set([Double](), forKey: "previousSessions")
        //self.totalTimer.text = "00:00"
        let allReset = UIAlertController(title: "Statistics Rest", message: "Your usage stats have been reset to default.", preferredStyle: .alert) //Set reset alert
        let theOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)                                                                 //Set alert buttons
        allReset.addAction(theOkAction)                                                                                                             //Add action
        UserDefaults.standard.synchronize()
        for theView in self.allViews {
            theView.removeFromSuperview()
        }
        self.allViews = [UIView]()
        self.averageTimeLabel.text = "Average: N/A"                                                                                                 //Present reseted values
        self.shortestSessionLabel.text = "Shortest: N/A"
        self.longestSessionLabel.text = "Longest: N/A"
        self.totalNumberOfSessionsLabel.text =  "Total Sessions: 0"
        self.present(allReset, animated: true, completion: nil)                                                                                     //Present alert
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets corner radius of back button
        self.backButton.layer.cornerRadius = 10                                                         //Set corner radius for back button
        self.restartButton.layer.cornerRadius = 10                                                      //Set corner radius for restart button
        
        if let avg:Double = UserDefaults.standard.value(forKey: "averageSession") as! Double?{          //Load the values for average session
            averageTime = avg
        }
        if let minS:Double = UserDefaults.standard.value(forKey: "minSession") as! Double? {            //Load the values for min session
            shortestSession = minS
        }
        if let maxS:Double = UserDefaults.standard.value(forKey: "maxSession") as! Double?{             //Load the values for max session
            longestSession = maxS
        }
        if let totalS = UserDefaults.standard.value(forKey: "totalSessions") as! Int?{                  //Load the values for total number of sessions
            totalNumber = totalS
        }
        UserDefaults.standard.synchronize()                                                             //Syncronize the changes
        
        if(shortestSession != 999){
            averageTime = (round(100*averageTime)/100)                                                  //Print in three digits
            averageTimeLabel.text = "Average: " + String(averageTime) + " Seconds"                      //Keep XX:XX format
            shortestSessionLabel.text = "Shortest: " + String(shortestSession) + " Seconds"             //Keep XX:XX format
            longestSessionLabel.text = "Longest: " + String(longestSession) + " Seconds"                //Keep XX:XX format
            totalNumberOfSessionsLabel.text = "Total Sessions: " + String(totalNumber)                  //Keep XX:XX format
        }
        else {
            averageTimeLabel.text = "Average: N/A"                                                      //Present reseted values
            shortestSessionLabel.text = "Shortest: N/A"                                                 //Present reseted values
            longestSessionLabel.text = "Longest: N/A"                                                   //Present reseted values
            totalNumberOfSessionsLabel.text =  "Total Sessions: 0"                                      //Present reseted values
        }
        

        
        let bottomG = UIScreen.main.bounds.height * (9/10)                                              //Scale CGRect image according to screen
        let heightMax = UIScreen.main.bounds.height * (4/10)                                            //Scale CGRect image according to screen
        let leftG = UIScreen.main.bounds.width * (1/10)                                                 //Scale CGRect image according to screen
        let spacer = UIScreen.main.bounds.width * (8/100)                                               //Scale CGRect image according to screen
        var offset = 0                                                                                  //Distance between graphs
        
        if let previousSessions = UserDefaults.standard.value(forKey: "previousSessions") as? [Double] {
            for bar in previousSessions {
                self.allViews.append(UIView())
                self.allViews.append(UIView())
                self.allViews[offset*2].backgroundColor = UIColor.cyan                                  //Set cyan color
                self.allViews[(offset*2) + 1].backgroundColor = UIColor.cyan                            //Set background color
                self.allViews[offset*2].frame = CGRect(x: (leftG + (spacer*CGFloat(offset))), y: bottomG, width: spacer-5, height: -((CGFloat(bar/300.0)*heightMax)))   //Initialize the frame
                self.allViews[(offset*2) + 1].frame = CGRect(x: (leftG + (spacer*CGFloat(offset))), y: bottomG, width: spacer-5, height: -(heightMax))                  //Draw the image
                self.allViews[(offset*2) + 1].alpha = 0.3                                                                                                               //Change alpha to %30
                self.view.addSubview(self.allViews[(offset*2) + 1])     //Set background
                self.view.addSubview(self.allViews[offset*2])           //Set background
                self.view.bringSubview(toFront: self.allViews[(offset*2) + 1])
                self.view.bringSubview(toFront: self.allViews[offset*2])
                offset = offset + 1
            }
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closeScreen(_ sender: Any) {                                                         //Close the screen
        dismiss(animated: true, completion: nil)
    }


}





