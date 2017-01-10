//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Nano Degree on 04/01/2017.
//  Copyright © 2017 Swift Pakistan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var LblOutput: UILabel!
    
    var btnSound : AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperations = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        
        runningNumber += "\(sender.tag)"
        
        LblOutput.text = runningNumber
        
    }
    
    @IBAction func onDividePressed(sender:AnyObject){
        processOperation(operation: .Divide)
    }
    @IBAction func onMultiplePressed(sender:AnyObject){
        processOperation(operation: .Multiply)
    }
    @IBAction func onSubtractPressed(sender:AnyObject){
        processOperation(operation: .Subtract)
    }
    @IBAction func onAddPressed(sender:AnyObject){
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender:  AnyObject){
        processOperation(operation: currentOperations)
    }
    
    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        
        btnSound.play()
        }
    
    func processOperation(operation: Operation){
        if currentOperations != Operation.Empty {
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperations == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                
                } else if currentOperations == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                
                } else if currentOperations == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                
                } else if currentOperations == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                LblOutput.text = result
            }
            currentOperations = operation
        } else {
           leftValStr = runningNumber
            runningNumber = ""
            currentOperations = operation
        }
    }
    
    }


