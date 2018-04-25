//
//  ViewController.swift
//  Schedule App
//
//  Created by Noah on 4/3/18.
//  Copyright © 2018 Noah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var defaultsData = UserDefaults.standard
    var coursesArray = [Course]()

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCourses()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadCourses() {
        guard let coursesEncoded = UserDefaults.standard.value(forKey: "coursesArray") as? Data else {
            print("Could not load coursesArray data from UserDefaults")
            return
        }
        let decoder = JSONDecoder()
        if let coursesArray = try? decoder.decode(Array.self, from: coursesEncoded) as [Course] {
            self.coursesArray = coursesArray
        } else {
            print("ERROR: Could not decode data read from UserDefaults")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "MenuToCourses":
            if let destination = segue.destination as? CoursesListVC {
                if coursesArray.count >= 1 {
                    for item in 0...coursesArray.count-1 {
                        destination.coursesArray.append(coursesArray[item])
                    }
                }
            }
        case "MenuToSchedule":
            if let destination = segue.destination as? ScheduleVC {
                if coursesArray.count >= 1 {
                    for item in 0...coursesArray.count-1 {
                        destination.coursesArray.append(coursesArray[item])
                    }
                }
            }
        default:
            print("Data NOT passed! destination vc is not set to CoursesListVC")
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


