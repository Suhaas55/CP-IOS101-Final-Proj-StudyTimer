//
//  TimerSettings.swift
//  CP-IOS101-FinalProjectStudyTimer
//
//  Created by Suhaas Achanta on 4/20/25.
//

import Foundation

/// Reads / writes your work/break durations (in seconds) to UserDefaults.
struct TimerSettings {
    private static let workKey  = "workDuration"
    private static let breakKey = "breakDuration"

    /// How long a Focus session should be (in seconds)
    static var workDuration: TimeInterval {
        get {
            let v = UserDefaults.standard.double(forKey: workKey)
            return v > 0 ? v : 25 * 60  // default 25m
        }
        set {
            UserDefaults.standard.set(newValue, forKey: workKey)
        }
    }

    /// How long a Break session should be (in seconds)
    static var breakDuration: TimeInterval {
        get {
            let v = UserDefaults.standard.double(forKey: breakKey)
            return v > 0 ? v : 5 * 60   // default 5m
        }
        set {
            UserDefaults.standard.set(newValue, forKey: breakKey)
        }
    }
}
