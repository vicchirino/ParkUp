//
//  PUFirstViewController.swift
//  ParkUp
//
//  Created by Victor Gabriel Chirino on 5/11/16.
//  Copyright © 2016 Victor Gabriel Chirino. All rights reserved.
//

import UIKit

class PUFirstViewController: UIViewController, PUMapViewControllerDelegate {
    
    @IBOutlet weak var parkDetailView: PUParkDetailView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        bottomConstraint.constant = -100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func PUMMapViewPinPressed(annotation: PinAnnotation) {
        if let park = annotation.park {
            self.parkDetailView.updateViewWithPark(park)
        }
        if parkDetailView.viewDisplayed {
            // TODO: CHANGE INFO
        } else {
            bottomConstraint.constant = 0
            UIView.animateWithDuration(0.35) {
                self.view.layoutIfNeeded()
            }
            self.parkDetailView.viewDisplayed = true
        }
    }
    
    func PUMMapViewPinDeselected() {
        if parkDetailView.viewDisplayed {
            bottomConstraint.constant = -100
            UIView.animateWithDuration(0.35) {
                self.view.layoutIfNeeded()
            }
            self.parkDetailView.viewDisplayed = false
            self.parkDetailView.userImage.image = UIImage(named: "user_placeholder")
        } else {

        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "containerMapSegue" {
            if let vc = segue.destinationViewController as? PUMapViewController {
                vc.delegate = self
            }
        }
    }
 

}
