//
//  ViewController.swift
//  BullsEye
//
//  Created by Joel on 1/25/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var roundLabel: UILabel!
    
    var round = 0
    
    @IBOutlet var scoreLabel: UILabel!
    
    var score = 0
    
    @IBOutlet var targetLabel: UILabel!
    
    var targetValue = 0
    
    @IBOutlet var slider: UISlider!
    
    var currentValue = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(
        top: 0,
        left: 14,
        bottom: 0,
        right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(
        withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(
        withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    @IBAction func showAlert(){
        
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty Good!"
        } else {
            title = "Not even close..."
        }
        score += points
        
        let message = "You scored \(points) points"
        // Alert message
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        // Action message
        let action = UIAlertAction(
            title: "Ok",
            style: .default,
            handler: { _ in self.startNewRound()})
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func sliderMoved(_ slider: UISlider) {
      currentValue = lroundf(slider.value)
    }
    func startNewRound() {
      round += 1
      targetValue = Int.random(in: 1...100)
      currentValue = 50
      slider.value = Float(currentValue)
      updateLabels()
    }
    @IBAction func startNewGame(){
        score = 0
        round = 0
        startNewRound()
        // Add the following lines
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(
        name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }


}

