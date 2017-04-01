//
//  StatisticsViewController.swift
//  SFUnwind
//
//  Created by berke on 2017-03-27.
//  Copyright © 2017 CMPT 276 - Group 5. All rights reserved.
//

import UIKit



class StatisticsViewController: UIViewController {

    
    var shortestSession: Double = 999
    var averageTime: Double = 0
    var longestSession: Double = 0
    var totalNumber = 0
    
    var allViews = [UIView]()
    
    @IBOutlet weak var totalNumberOfSessionsLabel: UILabel!
    @IBOutlet weak var longestSessionLabel: UILabel!
    @IBOutlet weak var shortestSessionLabel: UILabel!
    @IBOutlet weak var averageTimeLabel: UILabel!

    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func restartAllButton(_ sender: UIButton){
        UserDefaults.standard.set(0, forKey: "averageSession")
        UserDefaults.standard.set(999, forKey: "minSession")
        UserDefaults.standard.set(0, forKey: "maxSession")
        UserDefaults.standard.set(0, forKey: "totalSessions")
        UserDefaults.standard.set(0, forKey: "lastSession")
        UserDefaults.standard.set(0, forKey: "totalSecs") //Set Seconds
        UserDefaults.standard.set(0, forKey: "totalMins")
        UserDefaults.standard.set([Double](), forKey: "previousSessions")
        //self.totalTimer.text = "00:00"
        let allReset = UIAlertController(title: "Statitics Deleted", message: "All Statistics have been reset to default.", preferredStyle: .alert)
        let theOkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        allReset.addAction(theOkAction)
        UserDefaults.standard.synchronize()
        for theView in self.allViews {
            theView.removeFromSuperview()
        }
        self.allViews = [UIView]()
        self.averageTimeLabel.text = "Average: N/A"
        self.shortestSessionLabel.text = "Shortest: N/A"
        self.longestSessionLabel.text = "Longest: N/A"
        self.totalNumberOfSessionsLabel.text =  "Total Sessions: 0"
        self.present(allReset, animated: true, completion: nil) //Present alert
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets corner radius of back button
        self.backButton.layer.cornerRadius = 10
        self.restartButton.layer.cornerRadius = 10
        
        if let avg:Double = UserDefaults.standard.value(forKey: "averageSession") as! Double?{
            averageTime = avg
        }
        if let minS:Double = UserDefaults.standard.value(forKey: "minSession") as! Double? {
            shortestSession = minS
        }
        if let maxS:Double = UserDefaults.standard.value(forKey: "maxSession") as! Double?{
            longestSession = maxS
        }
        if let totalS = UserDefaults.standard.value(forKey: "totalSessions") as! Int?{
            totalNumber = totalS
        }
        UserDefaults.standard.synchronize()
        
        if(shortestSession != 999){
            averageTime = (round(100*averageTime)/100)
            averageTimeLabel.text = "Average: " + String(averageTime) + " Seconds"
            shortestSessionLabel.text = "Shortest: " + String(shortestSession) + " Seconds"
            longestSessionLabel.text = "Longest: " + String(longestSession) + " Seconds"
            totalNumberOfSessionsLabel.text = "Total Sessions: " + String(totalNumber)
        }
        else {
            averageTimeLabel.text = "Average: N/A"
            shortestSessionLabel.text = "Shortest: N/A"
            longestSessionLabel.text = "Longest: N/A"
            totalNumberOfSessionsLabel.text =  "Total Sessions: 0"
        }
        
        //let board = Draw(frame: CGRect(x: 25, y: 240, width: 250, height: 300))
        
        //board.draw(CGRect(
            //origin: CGPoint(x: 50, y: 50),
            //size: CGSize(width: 100, height: 100)));
        //self.view.addSubview(board)
        
        let bottomG = UIScreen.main.bounds.height * (9/10)
        let heightMax = UIScreen.main.bounds.height * (4/10)
        let leftG = UIScreen.main.bounds.width * (1/10)
        let spacer = UIScreen.main.bounds.width * (8/100)
        var offset = 0
        if let previousSessions = UserDefaults.standard.value(forKey: "previousSessions") as? [Double] {
            for bar in previousSessions {
                self.allViews.append(UIView())
                self.allViews.append(UIView())
                self.allViews[offset*2].backgroundColor = UIColor.cyan
                self.allViews[(offset*2) + 1].backgroundColor = UIColor.cyan
                self.allViews[offset*2].frame = CGRect(x: (leftG + (spacer*CGFloat(offset))), y: bottomG, width: spacer-5, height: -((CGFloat(bar/300.0)*heightMax)))
                self.allViews[(offset*2) + 1].frame = CGRect(x: (leftG + (spacer*CGFloat(offset))), y: bottomG, width: spacer-5, height: -(heightMax))
                self.allViews[(offset*2) + 1].alpha = 0.3
                self.view.addSubview(self.allViews[(offset*2) + 1])
                self.view.addSubview(self.allViews[offset*2])
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

    @IBAction func closeScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}





