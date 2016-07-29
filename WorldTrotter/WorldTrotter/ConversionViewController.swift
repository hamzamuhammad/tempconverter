//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Hamza Muhammad on 7/28/16.
//  Copyright © 2016 Hamza Muhammad. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter();
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    @IBOutlet var celsiusLabel: UILabel!
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        }
        else {
            return nil
        }
    }
    
    @IBOutlet var textField: UITextField!
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        if let text = textField.text, value = Double(text) {
            fahrenheitValue = value;
        }
        else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range : NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(".")
        let replacementTextHasDecimalSeparator = string.rangeOfString(".")
        
        let alphabetSet = NSCharacterSet.letterCharacterSet()
        let replacementText = string.rangeOfCharacterFromSet(alphabetSet)
        if replacementText != nil {
            return false
        }
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        }
        else {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print("ConversionViewController loaded its view.")
    }
    
    override func viewWillAppear(animated: Bool) {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.Hour, fromDate: date)
        let hour = components.hour
        
        if hour > 16 {
            view.backgroundColor = UIColor.darkGrayColor()
        }
        else {
            view.backgroundColor = UIColor.lightGrayColor()
        }
        
        print("Current hour: \(hour)")
    }
}