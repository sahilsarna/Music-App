//
//  SecondViewController.swift
//  Music App
//
//  Created by Sahil Sarna on 24/06/19.
//  Copyright © 2019 C4LYX. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBAction func play(_ sender: Any) {
        if audioStuffed == true && audioPlayer.isPlaying == false{
            audioPlayer.play()
        }
    }
    @IBAction func pause(_ sender: Any) {
        if audioStuffed == true && audioPlayer.isPlaying{
            audioPlayer.pause()
        }
    }
    @IBAction func previous(_ sender: Any) {
        if audioStuffed == true && thisSong != 0{
            playThis(thisOne: songs[thisSong-1])
            thisSong -= 1;
            label.text = songs[thisSong]
        }
        else{
            thisSong = songs.count-1;
            playThis(thisOne: songs[thisSong])
            label.text = songs[thisSong]
        }
    }
    @IBAction func next(_ sender: Any) {
        if audioStuffed == true && thisSong < songs.count-1{
            playThis(thisOne: songs[thisSong+1])
            thisSong += 1;
            label.text = songs[thisSong]
        }
        else{
            thisSong = 0;
            playThis(thisOne: songs[thisSong])
            label.text = songs[thisSong]
        }
    }
    @IBAction func slider(_ sender: UISlider) {
        if audioStuffed == true{
            audioPlayer.volume = sender.value
        }
    }
    
    func playThis(thisOne: String){
        do{
            
            let audioPath = Bundle.main.path(forResource: thisOne, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
        }catch{
            print("ERROR")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = songs[thisSong]
        // Do any additional setup after loading the view.
    }


}

