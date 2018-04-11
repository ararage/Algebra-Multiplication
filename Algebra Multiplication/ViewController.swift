//
//  ViewController.swift
//  Algebra Multiplication
//
//  Created by Ricardo Perez on 1/26/17.
//  Copyright © 2017 Ricardo Perez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblQuestionLabel: UILabel!
    @IBOutlet weak var txtInputText: UITextField!
    @IBOutlet weak var btnCheckAnswerButton: UIButton!
    @IBOutlet weak var lblCorrectLabel: UILabel!
    @IBOutlet weak var pgvProgressView: UIProgressView!
    @IBOutlet weak var swcNegativeSwitch: UISwitch!
    @IBOutlet weak var lblSwitchLabel: UILabel!
    
    var randonNumber : Int?
    var lastRandomNumber : Int?
    var correctAnswer : Int?
    var userAnswer : Int?
    var progress : Float = 0
    var multiplier : Int = 1
    var includeNegative : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        chooseQuestionNumbers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressCheckAnswerButton(_ sender: UIButton) {
        
        if(progress == 1){
            btnCheckAnswerButton.setTitle("CHECK ANSWER", for: UIControlState.normal)
            progress = 0
            
            if(includeNegative == true){
                multiplier *= -1
            }else{
                multiplier *= +1
            }
            
            chooseQuestionNumbers()
            lblCorrectLabel.text = "Good Attitude! Moving to "+String(describing:multiplier)+" x multiplier"
        }else{
            if let _ = Int(txtInputText.text!){
                userAnswer = Int(txtInputText.text!)
                checkIfCorrect()
            }
        }
        
        pgvProgressView.progress = progress
        txtInputText.text?.removeAll()
    }

    @IBAction func turnSwitchOnOrOff(_ sender: UISwitch) {
        switch swcNegativeSwitch.isOn {
        case true:
            includeNegative = true
            lblSwitchLabel.text = "Negatives included"
            multiplier *= -1
        case false:
            includeNegative = false
            lblSwitchLabel.text = "Negatives excluded"
            multiplier *= -1
        default:
            break
        }
        chooseQuestionNumbers()
        txtInputText.text?.removeAll()
    }
    
    //multiplier * x = randomNumber
    func chooseQuestionNumbers(){
        switch includeNegative {
        case true:
            correctAnswer = 12 - Int(arc4random_uniform(25))
        case false:
            correctAnswer = Int(arc4random_uniform(13))
        default:
            break
        }
        if(correctAnswer == lastRandomNumber){
            chooseQuestionNumbers()
        }
        lastRandomNumber = correctAnswer
        randonNumber = multiplier * correctAnswer!
        lblQuestionLabel.text = String(describing:multiplier)+" * X = "+String(describing:randonNumber!)
    }
    
    func checkIfCorrect(){
        if(userAnswer == correctAnswer){
            progress+=0.25
            lblCorrectLabel.text = "Correct!"
            lblCorrectLabel.backgroundColor = UIColor.green
            if(progress == 1){
                lblCorrectLabel.text = "Correct! Advancing Difficulty"
                btnCheckAnswerButton.setTitle("BRING IT ON!", for: UIControlState.normal)
            }else{
                lblCorrectLabel.text = "Correct!"
                chooseQuestionNumbers()
            }
        }else{
            lblCorrectLabel.text = "Incorrect!"
            lblCorrectLabel.backgroundColor = UIColor.red
        }
    }
}

