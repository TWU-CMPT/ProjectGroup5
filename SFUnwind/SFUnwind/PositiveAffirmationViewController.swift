//
//  PositiveAffirmationViewController.swift
//  SFUnwind
//
//  Created by A B on 2017-02-28.
//  Copyright © 2017 CMPT 276 - Group 5. All rights reserved.
//

import UIKit


// This is the main view controller for the SFUnwind "Positive Affirmation" feature
// Primary programmer: Joseph
class PositiveAffirmationViewController: UIViewController{
    
    
    @IBAction func Create(_ sender: AnyObject) {
        createAlert()
    }
    
    @IBOutlet weak var Label: UILabel!
    
    func createAlert (){
        let alert = UIAlertController(title: "Enter Mantra", message: "Write down the mantra you like", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { (textField) in textField.placeholder = "Enter here"
        }
        

        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            }))
        let textField = alert.textFields![0]
        print("Text field: \(textField.text)")
        /*
        // fkfkfkfkfkfk
        //alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (UIAlertAction) in print(String(enterdtext))
        var enteredText:String
        let action = UIAlertAction(title: "Submit", style: UIAlertActionStyle.default, handler: {[weak self]
                                    (paramAction:UIAlertAction!) in
                                    if var textFields = alert.textFields{
                                        var theTextFields = textFields as [UITextField]
                                        enteredText = theTextFields[0].text!
                                        self?.Label.text = String(describing: enteredText)
                                    };print(String(enteredText))
            })
        self.present(alert, animated: true, completion: nil)*/
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()// do any additional setup after loading the view, typically from nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()// dispose of any resources that can be recreated.
    }
    
    
}

