//
//  ScheduleVC.swift
//  Schedule App
//
//  Created by Noah on 4/19/18.
//  Copyright © 2018 Noah. All rights reserved.
//

import UIKit

class ScheduleVC: UIViewController {

    @IBOutlet weak var scheduleTableView: UITableView!
    @IBOutlet weak var weekdaySegmentedControl: UISegmentedControl!
    
    var coursesArray: [Course] = []
    var weekdayCoursesArray: [Course] = []
    var subtitleCounter = 1
    var numOfSubtitles = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        weekdayCoursesArray = loadWeekdayCoursesArray(weekday: "Mon")
    }

    func loadWeekdayCoursesArray(weekday: String) -> [Course] {
        var loadingArray: [Course] = []
        if coursesArray.count > 0 {
            for course in coursesArray {
                switch weekday {
                case "Mon":
                    if course.monday == true {
                        loadingArray.append(course)
                    }
                case "Tues":
                    if course.tuesday == true {
                        loadingArray.append(course)
                    }
                case "Wed":
                    if course.wednesday == true {
                        loadingArray.append(course)
                    }
                case "Thurs":
                    if course.thursday == true {
                        loadingArray.append(course)
                    }
                case "Fri":
                    if course.friday == true {
                        loadingArray.append(course)
                    }
                case "Sat":
                    if course.saturday == true {
                        loadingArray.append(course)
                    }
                case "Sun":
                    if course.sunday == true {
                        loadingArray.append(course)
                    }
                default:
                    print("ERROR: \(weekday) is not a valid weekday")
                }
            }
            loadingArray = sortWeekdayCoursesArray(weekdayCoursesArray: loadingArray)
        }
        return loadingArray
    }
    
    func sortWeekdayCoursesArray(weekdayCoursesArray: [Course]) -> [Course] {
        var sortedArray = weekdayCoursesArray
        sortedArray.sort(by: {$0.startTime < $1.startTime})
        return sortedArray
    }
    
    @IBAction func segmentedControlDayChanged(_ sender: UISegmentedControl) {
        weekdayCoursesArray = []
        weekdayCoursesArray = loadWeekdayCoursesArray(weekday: weekdaySegmentedControl.titleForSegment(at: weekdaySegmentedControl.selectedSegmentIndex)!)
        subtitleCounter = 1
        scheduleTableView.reloadData()
    }
    
    @IBAction func tableViewTapped(_ sender: UITapGestureRecognizer) {
        scheduleTableView.reloadData()
    }
    
    
}

extension ScheduleVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekdayCoursesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath)
        cell.textLabel?.text = weekdayCoursesArray[indexPath.row].name
        
        //format the times for the right subtitle in switch case using DateFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let startTimeString = dateFormatter.string(from: weekdayCoursesArray[indexPath.row].startTime)
        let endTimeString = dateFormatter.string(from: weekdayCoursesArray[indexPath.row].endTime)
        
        //to switch subtitles
        switch subtitleCounter {
        case 2:
            cell.detailTextLabel?.text = weekdayCoursesArray[indexPath.row].professor
        case 3:
            cell.detailTextLabel?.text = weekdayCoursesArray[indexPath.row].location
        default:
            cell.detailTextLabel?.text = "\(startTimeString) - \(endTimeString)"
        }
        
        //update subtitle counter so that next subtitle will show the next in order
        if indexPath.row == weekdayCoursesArray.count-1 {
            if subtitleCounter == numOfSubtitles {
                subtitleCounter = 1
            } else {
                subtitleCounter += 1
            }
        }
        
        return cell
    }
    
}
