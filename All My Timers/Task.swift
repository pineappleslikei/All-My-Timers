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
    var taskEntries: [TaskEntry]?
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}

struct TaskEntry: Codable {
    var start: String
    var end: String
}
