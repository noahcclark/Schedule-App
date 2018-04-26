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
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
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
    
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            editBarButton.title = "Edit"
            addBarButton.isEnabled = true
            menuBarButton.isEnabled = true
        } else {
            tableView.setEditing(true, animated: true)
            editBarButton.title = "Done"
            addBarButton.isEnabled = false
            menuBarButton.isEnabled = false
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

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            coursesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveCourses()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let courseToMove = coursesArray[sourceIndexPath.row]
        coursesArray.remove(at: sourceIndexPath.row)
        coursesArray.insert(courseToMove, at: destinationIndexPath.row)
        saveCourses()
    }
}
