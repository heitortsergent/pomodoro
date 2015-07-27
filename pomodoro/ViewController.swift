//
//  ViewController.swift
//  pomodoro
//
//  Created by Heitor Sergent on 7/27/15.
//  Copyright (c) 2015 heitor. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var timeLabel: NSTextField!
    
    let defaultSeconds = 10
    
    var currentSeconds = 0
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTimer()
    }

    @IBAction func startTimer(sender: NSButton) {
        if(!timer.valid && currentSeconds > 0) {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func resetTimer(sender: NSButton) {
        setupTimer()
    }
    
// MARK: timer methods
    
    func setupTimer() {
        currentSeconds = defaultSeconds
        
        var currentTime = getMinutesAndSeconds(currentSeconds)
        timeLabel.stringValue = getTimeString(currentTime.minutes, seconds:currentTime.seconds)
        
        timer.invalidate()
    }
    
    func subtractTime() {
        currentSeconds--
        
        var currentTime = getMinutesAndSeconds(currentSeconds)
        timeLabel.stringValue = getTimeString(currentTime.minutes, seconds:currentTime.seconds)
        
        if(currentSeconds == 0)  {
            timer.invalidate()
        }
    }
    
    func getMinutesAndSeconds(currentSeconds:Int) -> (minutes:Int, seconds:Int) {
        var minutes = currentSeconds / 60
        var seconds = currentSeconds % 60
        
        return (minutes, seconds)
    }
    
    func getTimeString(minutes:Int, seconds:Int) -> String {
        var minutesString = leftPad(minutes)
        var secondString = leftPad(seconds)
        
        return minutesString + ":" + secondString
    }
    
    func leftPad(value:Int) -> String {
        if(value < 10) {
            return "0" + "\(value)"
        } else {
            return "\(value)"
        }
    }

}

