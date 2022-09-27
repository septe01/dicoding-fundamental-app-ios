//
//  ViewController.swift
//  Ex 12 Music Player
//
//  Created by septe habudin on 27/09/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private var player: AVAudioPlayer?

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // MARK: Memastikan bahwa url dari asset tidak null.
            guard let url = Bundle.main.url(forResource: "guitar_background", withExtension: "mp3") else {
              return
            }
        
        do {
              try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    
              // MARK: Kode ini untuk iOS 11 ke atas.
              player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                    
              // MARK: Kode ini untuk iOS 10 ke bawah.
              // player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3)
                    
            } catch let error {
              print(error.localizedDescription)
            }
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      isPlaying(state: false)
    }

    @IBAction func playMusic(_ sender: Any) {
        guard let audioPlayer = player else { return }
          audioPlayer.play()
        isPlaying(state: true)
    }
    
    @IBAction func stopMusic(_ sender: Any) {
        guard let audioPlayer = player else { return }
          audioPlayer.stop()
        isPlaying(state: false)
    }
    
    
    private func isPlaying(state: Bool) {
      stopButton.isEnabled = state
      playButton.isEnabled = !state
    }
    
    
}

