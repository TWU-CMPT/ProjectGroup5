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
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backButton.layer.cornerRadius = 10
        
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
        
        
        averageTime = (round(100*averageTime)/100)
        averageTimeLabel.text = String(averageTime) + " Seconds"
        shortestSessionLabel.text = String(shortestSession) + " Seconds"
        longestSessionLabel.text = String(longestSession) + " Seconds"
        totalNumberOfSessionsLabel.text = String(totalNumber)
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    func loadTotalStatistics() -> String{
        let fileName = "timeStatistics"
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension(".txt")
        
        
        var readString = "" // Used to store the file contents
        do {
            // Read the file contents
            readString = try String(contentsOf: fileURL)
        } catch let error as NSError {
            print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
        }
        return readString
        
    }
    @IBAction func closeScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }



    @IBOutlet weak var totalNumberOfSessionsLabel: UILabel!
    @IBOutlet weak var longestSessionLabel: UILabel!
    @IBOutlet weak var shortestSessionLabel: UILabel!
    @IBOutlet weak var averageTimeLabel: UILabel!
}
