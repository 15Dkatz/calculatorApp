//
//  ViewController.swift
//  gameDesignCalculator
//
//  Created by David Katz on 9/22/15.
//  Copyright © 2015 davidkatz. All rights reserved.
//

//includes an audio feature!!!

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    //Properties
    @IBOutlet weak var numberDisplay: UILabel!
    
    
    
    //controls sound and display
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    
    
    //Functions
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        runningNumber += "\(btn.tag)"
        numberDisplay.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: UIButton) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
        
        if currentOperation == Operation.Divide {
            result = "\(Double(leftValStr)!/Double(rightValStr)!)"
        } else if currentOperation == Operation.Multiply {
            result = "\(Double(leftValStr)!*Double(rightValStr)!)"
        } else if currentOperation == Operation.Add {
            result = "\(Double(leftValStr)!+Double(rightValStr)!)"
        } else if currentOperation == Operation.Subtract {
            result = "\(Double(leftValStr)!-Double(rightValStr)!)"
        }
        
        leftValStr = result
        numberDisplay.text = result
        
        
        runningNumber = ""
    }
    @IBAction func onClearPressed(sender: UIButton) {
        processOperation(Operation.Empty)
        numberDisplay.text = ""
    }
    
    
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //execute math
            rightValStr = runningNumber
            runningNumber = ""
            
            
        } else {
            //operator's first execution:
            leftValStr = runningNumber
            runningNumber = ""
        }
        
        currentOperation = op
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
}

