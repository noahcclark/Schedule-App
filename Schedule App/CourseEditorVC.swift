//
//  CourseEditorVC.swift
//  Schedule App
//
//  Created by Noah on 4/3/18.
//  Copyright © 2018 Noah. All rights reserved.
//

import UIKit

class CourseEditorVC: UIViewController {
    //NOTE: -- need to have save button as .isHidden if:
        //1) courseNameField.text == ""
        //2) start time >= end time
    
    @IBOutlet weak var courseNameField: UITextField!
    @IBOutlet weak var professorField: UITextField!
    @IBOutlet weak var courseLocationField: UITextField!
    @IBOutlet weak var mondayCheckbox: UIImageView!
    @IBOutlet weak var tuesdayCheckbox: UIImageView!
    @IBOutlet weak var wednesdayCheckbox: UIImageView!
    @IBOutlet weak var thursdayCheckbox: UIImageView!
    @IBOutlet weak var fridayCheckbox: UIImageView!
    @IBOutlet weak var saturdayCheckbox: UIImageView!
    @IBOutlet weak var sundayCheckbox: UIImageView!
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    
    
    var currentCourse: Course?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentCourse = currentCourse {
            courseNameField.text = currentCourse.name
            professorField.text = currentCourse.professor
            courseLocationField.text = currentCourse.location
            mondayCheckbox.image = initiateCheckbox(value: currentCourse.monday)
            tuesdayCheckbox.image = initiateCheckbox(value: currentCourse.tuesday)
            wednesdayCheckbox.image = initiateCheckbox(value: currentCourse.wednesday)
            thursdayCheckbox.image = initiateCheckbox(value: currentCourse.thursday)
            fridayCheckbox.image = initiateCheckbox(value: currentCourse.friday)
            saturdayCheckbox.image = initiateCheckbox(value: currentCourse.saturday)
            sundayCheckbox.image = initiateCheckbox(value: currentCourse.sunday)
            startTimePicker.setDate(currentCourse.startTime, animated: true)
            endTimePicker.setDate(currentCourse.endTime, animated: true)
            
            
            //NOTE: -- fill out the rest of the fields
        } else {
            let dateZero = Date(timeIntervalSince1970: 0)
            startTimePicker.setDate(dateZero, animated: true)
            endTimePicker.setDate(dateZero, animated: false)
            
        }
    }
    
    func initiateCheckbox(value: Bool) -> UIImage {
        if value == false {
            return #imageLiteral(resourceName: "checkbox-unchecked")
        } else {
            return #imageLiteral(resourceName: "checkbox-checked")
        }
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindFromSaveCourseEditor" {
            let courseName = courseNameField.text!
            
            let courseProfessor = professorField.text!
            /*var courseProfessor = ""
            if let professor = professorField.text {
                courseProfessor = professor
            } else {
                courseProfessor = ""
            }*/
            let courseLocation = courseLocationField.text!
            /*var courseLocation = ""
            if let location = courseLocationField.text {
                courseLocation = location
            } else {
                courseLocation = ""
            }*/
            
            let mondayBool = (mondayCheckbox.image == #imageLiteral(resourceName: "checkbox-checked"))
            let tuesdayBool = (tuesdayCheckbox.image == #imageLiteral(resourceName: "checkbox-checked"))
            let wednesdayBool = (wednesdayCheckbox.image == #imageLiteral(resourceName: "checkbox-checked"))
            let thursdayBool = (thursdayCheckbox.image == #imageLiteral(resourceName: "checkbox-checked"))
            let fridayBool = (fridayCheckbox.image == #imageLiteral(resourceName: "checkbox-checked"))
            let saturdayBool = (saturdayCheckbox.image == #imageLiteral(resourceName: "checkbox-checked"))
            let sundayBool = (sundayCheckbox.image == #imageLiteral(resourceName: "checkbox-checked"))
            
            let startTime = startTimePicker.date
            let endTime = endTimePicker.date
            
            currentCourse = Course(name: courseName, professor: courseProfessor, location: courseLocation, monday: mondayBool, tuesday: tuesdayBool, wednesday: wednesdayBool, thursday: thursdayBool, friday: fridayBool, saturday: saturdayBool, sunday: sundayBool, startTime: startTime, endTime: endTime)
        }
    }

    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    //Keyboard resigning first responder
    
    @IBAction func nameDoneKeyPressed(_ sender: UITextField) {
        courseNameField.resignFirstResponder()
    }
    
    @IBAction func professorDoneKeyPressed(_ sender: UITextField) {
        professorField.resignFirstResponder()
    }
    
    @IBAction func locationDoneKeyPressed(_ sender: UITextField) {
        courseLocationField.resignFirstResponder()
    }
    
    @IBAction func outsidePressed(_ sender: UITapGestureRecognizer) {
        courseNameField.resignFirstResponder()
        professorField.resignFirstResponder()
        courseLocationField.resignFirstResponder()
    }
    
    
    
    //Checkbox checking functions
    
    func checkboxChecked(dayCheckbox: UIImageView) {
        if dayCheckbox.image == #imageLiteral(resourceName: "checkbox-unchecked") {
            dayCheckbox.image = #imageLiteral(resourceName: "checkbox-checked")
        } else {
            dayCheckbox.image = #imageLiteral(resourceName: "checkbox-unchecked")
        }
    }
    
    @IBAction func mondayCheckboxChecked(_ sender: UITapGestureRecognizer) {
        checkboxChecked(dayCheckbox: mondayCheckbox)
    }
    @IBAction func tuesdayCheckboxChecked(_ sender: UITapGestureRecognizer) {
        checkboxChecked(dayCheckbox: tuesdayCheckbox)
    }
    @IBAction func wednesdayCheckboxChecked(_ sender: UITapGestureRecognizer) {
        checkboxChecked(dayCheckbox: wednesdayCheckbox)
    }
    @IBAction func thursdayCheckboxChecked(_ sender: UITapGestureRecognizer) {
        checkboxChecked(dayCheckbox: thursdayCheckbox)
    }
    @IBAction func fridayCheckboxChecked(_ sender: UITapGestureRecognizer) {
        checkboxChecked(dayCheckbox: fridayCheckbox)
    }
    @IBAction func saturdayCheckboxChecked(_ sender: UITapGestureRecognizer) {
        checkboxChecked(dayCheckbox: saturdayCheckbox)
    }
    @IBAction func sundayCheckboxChecked(_ sender: UITapGestureRecognizer) {
        checkboxChecked(dayCheckbox: sundayCheckbox)
    }
    
}
