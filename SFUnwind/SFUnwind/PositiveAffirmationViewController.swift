//
// PositiveAffirmationViewController.swift - View Controller for the Positive Affirmation feature screen
// SFUnwind
// Project Group 5: SFU CMPT 276
// Primary programmer: Joseph Zhou
// Contributing Programmers:
// Known issues: ???????
//
// Note: All files in this project conform to the coding standard included in the SFUnwind HW3 Quality Assurance Documentation

import UIKit

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
            })*/
        self.present(alert, animated: true, completion: nil)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()// do any additional setup after loading the view, typically from nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()// dispose of any resources that can be recreated.
    }
    
    
}

