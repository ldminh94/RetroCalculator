//
//  ViewController.swift
//  Calculator.Retro
//
//  Created by Minh Le on 7/18/16.
//  Copyright © 2016 MinhLe. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    enum Operation:String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
    }
    
    @IBOutlet weak var outputLable:UILabel!
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    
    var leftValStr = ""
    
    var rightValStr = ""
    
    var currentOperation: Operation = Operation.Empty
    
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        do{
            try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }

    
    @IBAction func numberPressed(btn: UIButton!){
        
        playSound()
        
        runningNumber += "\(btn.tag)"
        
        outputLable.text = runningNumber
        
        
        
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
        
        playSound()
    
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
    }

    func processOperation(op: Operation){
        
        playSound()
        if currentOperation != Operation.Empty{
            if runningNumber != ""{
                
                rightValStr = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    
                }else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)!/Double(rightValStr)!)"
                }else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    
                }else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    
                }
                
                leftValStr = result
                
                outputLable.text = result
                
            }
            
            
            currentOperation = op
            
        }else{
            // This is the first time an operator has been pressed.
            
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
        
    }

    
    func playSound(){
        if buttonSound.play(){
            buttonSound.stop()
        }
        
        buttonSound.play()
        
    }
}

