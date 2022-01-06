//
//  Task.swift
//  All My Timers
//
//  Created by Chris Ellis on 12/23/21.
//

import Foundation

class Task: Codable {
    var name: String
    var description: String
    var color: String
    var taskEntries = [TaskEntry]()
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
        self.color = "Not yet"
    }
}

class TaskEntry: Codable {
    var startDate: TimeInterval
    var duration: Int
    
    init(startDate: TimeInterval, durationInSeconds: Int) {
        self.startDate = startDate
        self.duration = durationInSeconds
    }
}
