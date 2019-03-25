//
//  ViewController.swift
//  Notifications
//
//  Created by Nelson Gonzalez on 3/25/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var finalHour = 0
    var finalMinute = 0
    var petName = "Nelson"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getTimeData()
    }
    
    func getTimeData() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        let formattedTime = dateFormatter.string(from: datePicker.date)

        var splittedTime = formattedTime.components(separatedBy: ":")
        
        let hourSplitted = splittedTime[0]
        let minuteSplitted = splittedTime[1]
    
        finalHour = Int(hourSplitted)!
        finalMinute = Int(minuteSplitted)!
       
    }
    
    func morningMessage(){
        let content = UNMutableNotificationContent()
        content.title = "Good Morning 🌞"
        content.body = "\(petName) This is your reminder!"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = finalHour
        dateComponents.minute = finalMinute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "morning alarm", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    
    func getAccess (){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]) { (didAllow, error) in
            if error != nil {
                print("Error.")
            }
            else {
                
                self.morningMessage()
                
            }
        }
    }

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        getTimeData()
        getAccess()
    }
    
}

