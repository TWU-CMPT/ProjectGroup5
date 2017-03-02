//
//  SquareBreathingViewController.swift
//  SFUnwind
//
//  Created by A B on 2017-02-28.
//  Copyright © 2017 CMPT 276 - Group 5. All rights reserved.
//

import UIKit


// This is the main view controller for the SFUnwind "Square Breathing" feature
// Primary programmer: Berke
class SquareBreathingViewController: UIViewController{
 
    @IBOutlet weak var localTimer: UILabel!
    var sessionTime = Timer()            //NSTimer will be used
    var sessionTimeCounter = 0         //Session time added (Will be formatted to XX:XX)



    
    func sessionTimeManager(){                      //This func is called by selector of restartButton every sec
    sessionTimeCounter += 1
    localTimer.text = String(sessionTimeCounter)

    }

    @IBAction func restartButton(_ sender: UIButton) {
        
        sessionTime = Timer.init(timeInterval: 1, target: self, selector: #selector(SquareBreathingViewController.sessionTimeManager), userInfo: nil, repeats: true)
    }
    
    
    

   
}
