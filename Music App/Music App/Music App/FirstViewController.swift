//
//  FirstViewController.swift
//  Music App
//
//  Created by Sahil Sarna on 24/06/19.
//  Copyright © 2019 C4LYX. All rights reserved.
//

import UIKit
import AVFoundation

var songs:[String] = []
var audioPlayer = AVAudioPlayer()
var thisSong = 0
var audioStuffed = false

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var songCount: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = songs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do{
            
            let audioPath = Bundle.main.path(forResource: songs[indexPath.row], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
            thisSong = indexPath.row
            audioStuffed = true
        }catch{
            print("ERROR")
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gettingSongName()
        songCount.text = "\(Int(songs.count)) Songs"
        var audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setCategory(AVAudioSession.Category.playback)
        }catch{
            
        }
        
    }

    func gettingSongName(){
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        
        do{
           let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for song in songPath
            {
                var mySong = song.absoluteString
                
                if(mySong.contains(".mp3"))
                {
                    let findString = mySong.components(separatedBy: "/")
                    mySong = (findString[findString.count-1])
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    songs.append(mySong)
                    songs.sort()
                }
            }
            myTableView.reloadData()
        }catch{
            
        }
        
    }

}

