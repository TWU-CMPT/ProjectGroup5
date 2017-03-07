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

class PositiveAffirmationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    //Create button
    @IBAction func Create(_ sender: AnyObject) {
        createAlert()
    }
    
    //Delete button
    @IBAction func DeleteAlert(_ sender: AnyObject) {
        
    }
    
    //Previous button
    @IBAction func Previous(_ sender: AnyObject) {
        previousPA()
    }
    
    //Next button
    @IBAction func Next(_ sender: AnyObject) {
        nextPA()
    }
    
    //Label
    @IBOutlet weak var Label: UILabel!
    
    
    @IBOutlet weak var textTime: UITextField!
    
    func createAlert (){
        
        //create am alert
        let alert = UIAlertController(title: "Enter Mantra", message: "Write down the mantra you like", preferredStyle: UIAlertControllerStyle.alert)
        
        //add textField
        alert.addTextField { (textField) in textField.placeholder = "Enter here"
        }
        
        //Save aciton
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction) -> Void in
            let textField0 = alert.textFields?[0]
            print(textField0?.text!)
            self.Label.text = textField0?.text!
        })
        
         alert.addAction(saveAction)
        
        //Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancelAction)
       
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func previousPA(){
        if index > 0 {
            Label.text = fixed[index]
            index = index - 1
        }
    }
    
    func nextPA(){
        if index < fixed.count - 1 {
            Label.text = fixed[index]
            index = index + 1
        }
    }
    
    var index = 0
    
    //fixed 10 postivite affirmations
    var fixed = ["I am awesome!", "I am the architect of my life; I build its foundation and choose its contents.", "Today, I am brimming with energy and overflowing with joy.", "My body is healthy; my mind is brilliant; my soul is tranquil.", "I am superior to negative thoughts and low actions.", "I have been given endless talents which I begin to utilize today.", "I forgive those who have harmed me in my past and peacefully detach from them.", "A river of compassion washes away my anger and replaces it with love.", "I am guided in my every step by Spirit who leads me towards what I must know and do.", "I possess the qualities needed to be extremely successful.", "My ability to conquer  my challenges is limitless; my potential to succeed is infinite."]
    
    var data = ["Never", "weekly", "Daily", "hourly"]
    var picker = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        textTime.inputView = picker
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()// dispose of any resources that can be recreated.
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return data.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textTime.text = data[row]
        self.view.endEditing(false)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
}

