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
    
    let txtTapToRecord: String = "Tap to Record"
    let txtTapToStop: String = "Tap to Stop Recording"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the full documentary path and set up where to put the recording
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print("RecordView > Future recording files stored at: \(filePath)")
        
        // Get the audio session from the phone hardware
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: AnyObject) {
        
        if (audioRecorder.recording) {
            print("RecordView > Stopped recording.")
            audioRecorder.stop();
            let session = AVAudioSession.sharedInstance()
            try! session.setActive(false)
            recordFeedback.text = txtTapToRecord
        } else {
            print("RecordView > Start recording.")
            recordFeedback.text = txtTapToStop
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag){
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        } else {
            print("RecordView > Finished recording and failed to save the file.")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destinationViewController as! PlayViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

