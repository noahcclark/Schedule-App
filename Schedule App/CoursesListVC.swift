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
    
    var defaultsData = UserDefaults.standard
    var coursesArray = [Course]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func saveCourses() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(coursesArray) {
            UserDefaults.standard.set(encoded, forKey: "coursesArray")
        } else {
            print("ERROR: Saving encoded did not work")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "EditCourse":
            let destination = segue.destination as! CourseEditorVC
            let index = tableView.indexPathForSelectedRow!.row
            destination.currentCourse = coursesArray[index]
        case "UnwindFromMenuCoursesList": break
        default:
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
        saveCourses()
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
