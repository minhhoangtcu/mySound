//
//  ViewController.swift
//  mySound
//
//  Created by Hoang, Minh on 4/8/16.
//  Copyright © 2016 Hoang, Minh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordFeedback: UILabel!
    
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
        if (isRecording) {
            recordFeedback.text = txtTapToRecord
        }
        else {
            recordFeedback.text = txtTapToStop
        }
        isRecording = !isRecording
    }
    

}

