//
//  StatisticsViewController.swift
//  SFUnwind
//
//  Created by berke on 2017-03-27.
//  Copyright © 2017 CMPT 276 - Group 5. All rights reserved.
//

import UIKit

class Draw: UIView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func getArrayLength() -> Int{

        var latestSessions = [Double]()
        if let previousSessions = UserDefaults.standard.value(forKey: "previousSessions"){
            latestSessions = previousSessions as! [Double]
            return latestSessions.count
        }
    return 0
    }
    
    func getSessionArray() -> [Double]{
        var latestSessions = [Double]()
        if let previousSessions = UserDefaults.standard.value(forKey: "previousSessions"){
            latestSessions = previousSessions as! [Double]
        }
        return latestSessions
    }

    
    
    override func draw(_ rect: CGRect)
    {
        
        self.backgroundColor = UIColor.clear
        
        func drawRectangle(offset:CGFloat, heightValue: CGFloat){
            
            let set1 = UIGraphicsGetCurrentContext()
            set1?.saveGState()
            set1?.setLineWidth(0)
            set1?.setStrokeColor(UIColor.blue.cgColor)
            let rectangle = CGRect(x: offset,y: 285,width: 15,height: -heightValue) //was  (x: offset,y: 235,width: 15,height: -heightValue)
            set1?.addRect(rectangle)
            UIColor.blue.setFill()
            UIRectFill(rectangle)
            set1?.strokePath()
            set1?.restoreGState()
        }
        //For Y Value
        let set2 = UIGraphicsGetCurrentContext()
        set2?.saveGState()
        set2?.setLineWidth(4)
        set2?.setStrokeColor(UIColor.black.cgColor)
        let rectangle = CGRect(x: 16,y: 285,width: 4,height: -280) //was  (x: offset,y: 235,width: 15,height: -heightValue)
        set2?.addRect(rectangle)
        set2?.strokePath()
        set2?.restoreGState()
        //For X Value
        let set3 = UIGraphicsGetCurrentContext()
        set3?.saveGState()
        set3?.setLineWidth(4)
        set3?.setStrokeColor(UIColor.black.cgColor)
        let rectangle2 = CGRect(x: 16,y: 289,width: 250,height: 4) //was  (x: offset,y: 235,width: 15,height: -heightValue)
        set3?.addRect(rectangle2)
        set3?.strokePath()
        set3?.restoreGState()

        let arrayLength = getArrayLength()
        let sessionArray = getSessionArray()
        var defaultOffset = 10
        if(arrayLength != 0){
            for i in 0...arrayLength-1{
                defaultOffset+=20
                drawRectangle(offset: CGFloat(defaultOffset), heightValue: CGFloat(sessionArray[i]+1))
            }
        }

    }
    
    
}


class StatisticsViewController: UIViewController {

    
    var shortestSession: Double = 999
    var averageTime: Double = 0
    var longestSession: Double = 0
    var totalNumber = 0
    
    var allViews = [UIView]()

    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets corner radius of back button
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
        
        if(shortestSession != 999){
            averageTime = (round(100*averageTime)/100)
            averageTimeLabel.text = String(averageTime) + " Seconds"
            shortestSessionLabel.text = String(shortestSession) + " Seconds"
            longestSessionLabel.text = String(longestSession) + " Seconds"
            totalNumberOfSessionsLabel.text = String(totalNumber)
        }
        else {
            averageTimeLabel.text = "N/A"
            shortestSessionLabel.text = "N/A"
            longestSessionLabel.text = "N/A"
            totalNumberOfSessionsLabel.text = "0"
        }
        
        
        if(shortestSession == 999){
        shortestSessionLabel.text = "N/A"
        }
        
        if(longestSession > 300){
        longestSessionLabel.text = "300 Seconds"
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





