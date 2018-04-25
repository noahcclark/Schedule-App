//
//  CourseStruct.swift
//  Schedule App
//
//  Created by Noah on 4/4/18.
//  Copyright © 2018 Noah. All rights reserved.
//

import Foundation


struct Course: Codable {
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
    var startTime: Date
    var endTime: Date
}
