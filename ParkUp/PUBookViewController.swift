//
//  PUBookViewController.swift
//  ParkUp
//
//  Created by Victor Gabriel Chirino on 5/31/16.
//  Copyright © 2016 Victor Gabriel Chirino. All rights reserved.
//

import UIKit

class PUBookViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var hourFromPicker: UIDatePicker!
    @IBOutlet weak var hourToPicker: UIDatePicker!
    @IBOutlet weak var statusLabel: UILabel!
    var date: NSDate?
    var hourFrom: String?
    var hourTo: String?

    var park: Parking? {
        didSet {
            if park != nil {
                self.updateView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.statusLabel.text = "Chequeando disponibilidad.."
        self.statusLabel.textColor = UIColor(red: 111/255, green: 113/255, blue: 123/255, alpha: 1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { 
            
        }
    }
    
    func updateView() {
        self.title = park?.street
        self.date = NSDate()
        let hourToday = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate())
        self.hourFrom = "\(hourToday)"
    }
    
    @IBAction func dateChanged(sender: AnyObject) {
        if sender as? UIDatePicker == datePicker {
            self.date = datePicker.date
        } else if sender as? UIDatePicker == hourFromPicker {
            let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: hourFromPicker.date)
//            let minutes = NSCalendar.currentCalendar().component(.Minute, fromDate: hourFromPicker.date)
            self.hourFrom =  "\(hour)"
        } else if sender as? UIDatePicker == hourToPicker {
            let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: hourToPicker.date)
//            let minutes = NSCalendar.currentCalendar().component(.Minute, fromDate: hourToPicker.date)
            self.hourTo =  "\(hour)"
            self.checkAvailability()
        }
    }
    
    func checkAvailability() {
        if self.date != nil && self.hourTo != nil && self.hourFrom != nil {
            PUClient.fetchParks(self.date, self.hourFrom, self.hourTo, completion: { (parks, error) -> (Void) in
                if let p = parks {
                    for parkDic in p {
                        let parkObject = Parking()
                        parkObject.createParkingWithDic(parkDic)
                        if parkObject.garage_id == self.park?.garage_id, let bool = parkObject.available where bool == true{
//                            print("disponible")
                            self.statusLabel.text = "Disponible"
                            self.statusLabel.textColor = UIColor(red: 32/255, green: 177/255, blue: 39/255, alpha: 1)
                            return
                        }
                    }
//                    print("no disponible")
                    self.statusLabel.text = "No Disponible"
                    self.statusLabel.textColor = UIColor(red: 220/255, green: 50/255, blue: 40/255, alpha: 1)
                }
            })
        }
        self.statusLabel.text = "No Disponible"
        self.statusLabel.textColor = UIColor(red: 220/255, green: 50/255, blue: 40/255, alpha: 1)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
