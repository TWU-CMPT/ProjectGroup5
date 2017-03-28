//
//  StatisticsViewController.swift
//  SFUnwind
//
//  Created by berke on 2017-03-27.
//  Copyright © 2017 CMPT 276 - Group 5. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    
    var shortestSession:Int = 0
    var averageTime:Int = 0
    var longestSession:Int = 0
    var totalNumber:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getShortest(stats: String) -> Int{
        if(stats == ""){
            return 0
        }
        return 3
            
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



}
