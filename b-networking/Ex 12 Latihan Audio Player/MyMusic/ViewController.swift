//
//  ViewController.swift
//  Ex 12 Latihan Audio Player
//
//  Created by septe habudin on 25/09/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  // MARK: Inisialisasi variabel player
  private var player: AVAudioPlayer?

  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var stopButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    // MARK: Memastikan bahwa url dari asset tidak null.
      guard let url = Bundle.main.url(forResource: "sound", withExtension: "mp3") else {
                          return
                      }

      
    // MARK: Setup AVAudioPlayer
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        
      // MARK: Kode ini untuk iOS 11 ke atas.
        print("url -> \(url)")
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
      print("player -> no player ")
      // player?.play()

      // MARK: Kode ini untuk iOS 10 ke bawah.
//       player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3)

    } catch let error{
      print(error.localizedDescription)
        
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    isPlaying(state: false)
  }

  // MARK: Memainkan Musik
  @IBAction func playMusic(_ sender: UIButton) {
      isPlaying(state: true)
  guard let audioPlayer = player else { return }
    audioPlayer.play()
  }

  // MARK: Menghentikan Musik
  @IBAction func stopMusic(_ sender: UIButton) {
      isPlaying(state: false)
  guard let audioPlayer = player else { return }
    audioPlayer.stop()
  }

  private func isPlaying(state: Bool) {
    stopButton.isEnabled = state
    playButton.isEnabled = !state
  }
}
