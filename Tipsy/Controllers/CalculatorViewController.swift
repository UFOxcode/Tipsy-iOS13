//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctBTN: UIButton!
    @IBOutlet weak var tenPct: UIButton!
    @IBOutlet weak var twentyPct: UIButton!
    @IBOutlet weak var spliteNumberLabel: UILabel!
    
    var tip = 0.00
    var numberOfPeople = 2
    var billTotal = 0.0
    var finaResult = ""
    
    @IBAction func tipChanged(_ sender: UIButton) {
        //讓 鍵盤消失掉
        billTextField.endEditing(true)
        
        zeroPctBTN.isSelected = false
        tenPct.isSelected = false
        twentyPct.isSelected = false
        
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        let buttonTitleDrop = String(buttonTitle.dropLast())
        let buttonTitleAsNumber = Double(buttonTitleDrop)!
        tip = buttonTitleAsNumber / 100
    }
    
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        spliteNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
        
    }
    
    @IBAction func calculatedPressed(_ sender: UIButton) {
       
        let bill = billTextField.text!
        if bill != "" {
            billTotal = Double(bill)!
            let result = billTotal * ( 1 + tip) / Double(numberOfPeople)
            finaResult = String(format: "%.2f", result)
        }
        
        self.performSegue(withIdentifier: "goNext", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goNext" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = finaResult
            destinationVC.tip = Int(tip*100)
            destinationVC.split = numberOfPeople
    }
    }
}

