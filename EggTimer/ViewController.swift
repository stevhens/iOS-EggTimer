//
//  ViewController.swift
//  EggTimer
//
//  Created by Steven Sim on 22/10/2019.
//  Copyright © 2019 Steven Sim. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var audioPlayer : AVAudioPlayer!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    var estimatedTime = 0
    var secondsPassed = 0
    
    var timer = Timer()
    
    override func viewDidLoad() {
        initAlert()
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        audioPlayer.stop()
        
        timer.invalidate()
        let hardness = sender.currentTitle! //Soft, Medium, Hard
        estimatedTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if secondsPassed < estimatedTime {
            //print("\(secondsPassed) seconds.")
            secondsPassed += 1
            
            let percentageProgress = Float(secondsPassed) / Float(estimatedTime)
            
            progressBar.progress = percentageProgress
        } else {
            timer.invalidate()
            titleLabel.text = "Done"
            
            audioPlayer.play()
        }
    }
    
    func initAlert() {
        
        let soundURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        }
        catch {
            print(error)
        }
    }
}
