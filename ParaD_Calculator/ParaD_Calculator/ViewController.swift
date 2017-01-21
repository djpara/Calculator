//
//  ViewController.swift
//  ParaD_Calculator
//
//  Created by David Para on 1/19/17.
//  Copyright © 2017 David Para. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var addPressed = false
    var addRecentlyPressed = false
    var equalsPressed = false
    var inputtingNum = false
    
    var lastAdded = 0
    var stored = 0;
    
    @IBOutlet weak var resultDisplay: UILabel!
    @IBOutlet weak var swipeView: UIView!
    
    let swipeRec = UISwipeGestureRecognizer()
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if let buttonName = sender.currentTitle {
            
            if resultDisplay.text == "Simple Add Calculator" {
                clearDisplay()
            }
            
            switch buttonName {
                case "Clear":
                    clearAll()
                case "+":
                    inputtingNum = false
                    if addRecentlyPressed == true {
                        break
                    }
                    pressAdd()
                    checkForEquals()
                    calculate()
                case "=":
                    inputtingNum = false
                    if addRecentlyPressed == true {
                        break
                    }
                    if equalsPressed == true {
                        calculate()
                    }
                    if addPressed == true {
                        equalsPressed = true
                        addToLast(resultDisplay.text!)
                        calculate()
                        addPressed = false
                    }
                default:
                    inputtingNum = true
                    if addRecentlyPressed == true {
                            clearDisplay()
                            addRecentlyPressed = false
                    }
                    if resultDisplay.text == "0" || equalsPressed == true {
                        clearAll()
                    }
                    equalsPressed = false
                    if resultDisplay.text!.characters.count < 10 {
                        resultDisplay.text! += "\(buttonName)"
                    }
                
            }
            
        }
        
    }
    
    @IBAction func swiped(_ sender: UISwipeGestureRecognizer) {
        if inputtingNum == true {
            deleteLast()
        }
    }
    func addToLast(_ n: String) {
        lastAdded = Int(n) ?? 0
    }
    
    func calculate()  {
        stored += lastAdded
        resultDisplay.text = "\(stored)"
        store(stored)
    }
    
    func pressAdd() {
        addPressed = true
        addRecentlyPressed = true
    }
    
    func clearDisplay() {
        resultDisplay.text = ""
    }
    
    func store(_ n: Int) {
        stored = n
    }
    
    func clearStored() {
        stored = 0
    }
    
    func checkForEquals() {
        if equalsPressed == true {
            lastAdded = 0
            calculate()
            equalsPressed = !equalsPressed
        } else {
            addToLast(resultDisplay.text!)
        }
    }
    
    func clearAll() {
        clearDisplay()
        clearStored()
        addPressed = false
        addRecentlyPressed = false
        equalsPressed = false
    }
    
    func deleteLast() {
        if resultDisplay.text != "" {
            resultDisplay.text!.characters.removeLast()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

