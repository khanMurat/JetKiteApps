//
//  CloseAlarmViewController.swift
//  task3_app
//
//  Created by Murat on 29.08.2023.
//

import UIKit
import AVFoundation

class CloseAlarmViewController : UIViewController {
    
    //MARK: - Properties
        var audioPlayer: AVAudioPlayer?
       var timer: Timer?
       var currentVolume: Float = 0.0

    //MARK: - Lifecycle
    
       override func viewDidLoad() {
           super.viewDidLoad()
           
           view.backgroundColor = .white
           
           let alertController = UIAlertController(title: "Alarm", message: "Stop Alarm ?", preferredStyle: .alert)

           let stopAction = UIAlertAction(title: "STOP", style: .default) { [self] (_) in
               timer?.invalidate()
               audioPlayer?.stop()
           }

           alertController.addAction(stopAction)

           self.present(alertController, animated: true, completion: nil)

           startPlayingSound()
       }
    
    //MARK: - Helpers

       func startPlayingSound() {
           guard let url = Bundle.main.url(forResource: "wakeup_alarm", withExtension: "caf") else { return }

           do {
               audioPlayer = try AVAudioPlayer(contentsOf: url)
               audioPlayer?.prepareToPlay()
               audioPlayer?.volume = 0.0
               audioPlayer?.play()
               
               timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(increaseVolume), userInfo: nil, repeats: true)

           } catch let error {
               print("Audio play error \(error)")
           }
       }

       @objc func increaseVolume() {
           currentVolume += (1.0 / 30.0)
           if currentVolume > 1.0 {
               currentVolume = 1.0
               timer?.invalidate()
           }
           audioPlayer?.volume = currentVolume
       }
   }

