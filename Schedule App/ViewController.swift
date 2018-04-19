//
//  ViewController.swift
//  Schedule App
//
//  Created by Noah on 4/3/18.
//  Copyright © 2018 Noah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var coursesArray = [Course]()
    //var managementScience = Course(name: "Management Science", professor: "Neale", location: "", monday: false, tuesday: true, wednesday: false, thursday: false, friday: false, saturday: false, sunday: false, startTimeHour: 0, startTimeMinute: 0, startTimeAMPM: "AM", endTimeHour: 0, endTimeMinute: 0, endTimeAMPM: "AM")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //coursesArray.append(managementScience)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuToCourses" {
            if let destination = segue.destination as? CoursesListVC {
                if coursesArray.count >= 1 {
                    for item in 0...coursesArray.count-1 {
                        destination.coursesArray.append(coursesArray[item])
                    }
                }
            } else {
                print("Data NOT passed! destination vc is not set to CoursesListVC")
            }
        }
    }
    
    @IBAction func unwindFromCoursesListVC(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! CoursesListVC
        coursesArray = []
        if sourceViewController.coursesArray.count != 0 {
            for course in sourceViewController.coursesArray {
                coursesArray.append(course)
            }
        }
    }
}

