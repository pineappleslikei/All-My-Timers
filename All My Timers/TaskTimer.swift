//
//  TaskTimer.swift
//  All My Timers
//
//  Created by Chris Ellis on 12/26/21.
//

import Foundation

class TaskTimer {
    
    weak var delegate: TaskTimerDelegate?
    
    var seconds = 0 {
        didSet {
            updateDisplayValue()
        }
    }
    
    var minutes = 0 {
        didSet {
            updateDisplayValue()
        }
    }
    
    var hours = 0 {
        didSet {
            updateDisplayValue()
        }
    }
    
    var displayValue = "00:00:00"
    var storageValue = 0
    
    var startDateTime: TimeInterval?
    var timer: Timer?
    var isRunning = false
    
    public func start() {
        isRunning = true
        startDateTime = Date().timeIntervalSince1970
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { tempTimer in
            self.storageValue += 1
            
            if self.seconds == 59 {
                self.seconds = 0
                if self.minutes == 59 {
                    self.minutes = 0
                    self.hours += 1
                } else {
                    self.minutes += 1
                }
            } else {
                self.seconds += 1
            }
        })
        self.delegate?.didStartRunning()
    }
    
    public func stop() {
        isRunning = false
        timer?.invalidate()
        timer = nil
        
        let taskEntry = TaskEntry(startDate: startDateTime ?? 0, durationInSeconds: storageValue)
        self.delegate?.didStopRunning(taskEntry: taskEntry)
        
        resetDisplay()
    }
    
    private func updateDisplayValue() {
        let formattedSeconds = formatLeadingZero(timeValue: seconds)
        let formattedMinutes = formatLeadingZero(timeValue: minutes)
        let formattedHours = formatLeadingZero(timeValue: hours)
        
        displayValue = "\(formattedHours):\(formattedMinutes):\(formattedSeconds)"

        self.delegate?.displayValueChanged(newDisplayValue: displayValue)
    }
    
    private func formatLeadingZero(timeValue: Int) -> String {
        let formatted = timeValue > 9 ? "\(timeValue)" : "0\(timeValue)"
        return formatted
    }
    
    private func resetDisplay() {
        seconds = 0
        minutes = 0
        hours = 0
        
        storageValue = 0
        displayValue = "00:00:00"
    }
}

protocol TaskTimerDelegate: AnyObject {
    func displayValueChanged(newDisplayValue: String)
    func didStartRunning()
    func didStopRunning(taskEntry: TaskEntry)
}
