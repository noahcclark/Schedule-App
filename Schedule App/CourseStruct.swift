//
//  CourseStruct.swift
//  Schedule App
//
//  Created by Noah on 4/4/18.
//  Copyright © 2018 Noah. All rights reserved.
//

import Foundation

struct Course {
    var name = ""
    var professor = ""
    var location = ""
    var monday: Bool
    var tuesday: Bool
    var wednesday: Bool
    var thursday: Bool
    var friday: Bool
    var saturday: Bool
    var sunday: Bool
    var startTimeHour = 0
    var startTimeMinute = 0
    var startTimeAMPM = ""
    var endTimeHour = 0
    var endTimeMinute = 0
    var endTimeAMPM = ""
}
