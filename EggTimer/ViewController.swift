//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var doneLabel: UILabel!
    @IBOutlet var progressBarInfo: UIProgressView!
    
    var secondsRemaining = 60
    var timer = Timer()
    var player: AVAudioPlayer!
    
    let eggTime = [
        "Soft" : 300,
        "Medium" : 420,
        "Hard" : 720
    ]
    
    override func viewDidLoad() {
        doneLabel.text = "Выбери, как сварить яйца"
        progressBarInfo.setProgress(0, animated: true)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        timer.invalidate()
        progressBarInfo.setProgress(0, animated: true)
        
        guard let buttonTitile = sender.currentTitle else { return }
        secondsRemaining = eggTime[buttonTitile]!
        
        doneLabel.text = buttonTitile

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            print("\(secondsRemaining) seconds")
            secondsRemaining -= 1
            progressBarInfo.setProgress(Float(secondsRemaining), animated: true)
        } else {
            doneLabel.text = "Done"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
            timer.invalidate()
        }
    }
}
