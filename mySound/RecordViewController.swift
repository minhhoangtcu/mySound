//
//  ViewController.swift
//  mySound
//
//  Created by Hoang, Minh on 4/8/16.
//  Copyright © 2016 Hoang, Minh. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordFeedback: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    
    var isRecording: Bool = false
    let txtTapToRecord: String = "Tap to Record"
    let txtTapToStop: String = "Tap to Stop Recording"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: AnyObject) {
        // Set text
        if (isRecording) {
            recordFeedback.text = txtTapToRecord
        }
        else {
            recordFeedback.text = txtTapToStop
        }
        isRecording = !isRecording
        
        // Actual Record
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        <#code#>
    }

}

