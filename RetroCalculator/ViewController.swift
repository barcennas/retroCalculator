//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Abraham Barcenas M on 1/9/17.
//  Copyright © 2017 bardev. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var outputLbl: UILabel!
    
    var btnSound : AVAudioPlayer!
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rigthValStr = ""
    var result = ""
    
    enum Operation : String{
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let sondURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: sondURL)
            btnSound.prepareToPlay()
        }catch let error as NSError{
            print(error.debugDescription)
        }
        
    }
    
    @IBAction func buttonPressed(sender: UIButton){
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject){
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject){
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubstractPressed(sender: AnyObject){
        processOperation(operation: .Substract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject){
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject){
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearPressed(sendr: AnyObject){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
        
        currentOperation = Operation.Empty
        runningNumber = ""
        leftValStr = ""
        rigthValStr = ""
        result = ""
        outputLbl.text = "0"
        
    }
    
    func playSound(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(operation : Operation){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
        
        if currentOperation != Operation.Empty{
            
            //User selected an operation but then selected another operation withouth first entering a number
            if runningNumber != ""{
                rigthValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rigthValStr)!)"
                }else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rigthValStr)!)"
                }else if currentOperation == Operation.Substract{
                    result = "\(Double(leftValStr)! - Double(rigthValStr)!)"
                }else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rigthValStr)!)"
                }
                
                if result == "inf" || result == "nan"{
                    leftValStr = "0"
                    outputLbl.text = "Error"
                }else{
                    leftValStr = result
                    outputLbl.text = result
                }
            
            }
            
            currentOperation = operation
        }else{
            //this is the first time an operator has been pressed
            if runningNumber != ""{
                leftValStr = runningNumber
                runningNumber = ""
                currentOperation = operation
            }
        }
    }



}

