//
//  CoursesListVC.swift
//  Schedule App
//
//  Created by Noah on 4/3/18.
//  Copyright © 2018 Noah. All rights reserved.
//

import UIKit



class CoursesListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
// HOPEFULLY, THIS COURSES ARRAY IS A DUMMY VARIABLE THAT CAN LATER BE DELETED
    //BECAUSE
    var coursesArray = [Course]()
    
    var swift = Course(name: "Swift", professor: "Gallaugher", location: "Fulton 415", monday: true, tuesday: false, wednesday: false, thursday: false, friday: false, saturday: false, sunday: false, startTimeHour: 0, startTimeMinute: 0, startTimeAMPM: "AM", endTimeHour: 0, endTimeMinute: 0, endTimeAMPM: "AM")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        coursesArray.append(swift)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditCourse" {
            let destination = segue.destination as! CourseEditorVC
            let index = tableView.indexPathForSelectedRow!.row
            destination.currentCourse = coursesArray[index]
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }
    
    @IBAction func unwindFromCourseEditorVC(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! CourseEditorVC
        if let indexPath = tableView.indexPathForSelectedRow {
            coursesArray[indexPath.row] = sourceViewController.currentCourse!
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: coursesArray.count, section: 0)
            coursesArray.append(sourceViewController.currentCourse!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    
}

extension CoursesListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coursesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath)
        cell.textLabel?.text = coursesArray[indexPath.row].name
        return cell
    }
}
