//
//  PUParkDetailView.swift
//  ParkUp
//
//  Created by Victor Gabriel Chirino on 5/18/16.
//  Copyright © 2016 Victor Gabriel Chirino. All rights reserved.
//

import UIKit
import SDWebImage

protocol PUParkDetailDelegate {
    func puParDelegateBookPark(park: Parking?)
}

class PUParkDetailView: UIView {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var parkStreet: UILabel!
    @IBOutlet weak var parkButton: UIButton!
    var park: Parking?
    private var imageTokens : [SDWebImageOperation] = []
    var viewDisplayed = false
    var delegate: PUParkDetailDelegate?
    
    func setImageURL(urlString: String?) {
        if let thumbnailUrlString = urlString,
            token = PUAsset.fetchImage(url: thumbnailUrlString, completionHandler: { (img) -> Void in
                self.userImage.backgroundColor = UIColor.clearColor()
                self.userImage.alpha = 0
                self.userImage.image = img
                if img?.width > self.userImage.width || img?.height > self.userImage.height {
                    self.userImage.contentMode = .ScaleAspectFit
                }
                UIView.animateWithDuration(0.28, animations: { () -> Void in
                    self.userImage.alpha = 1.0
                    }, completion: { (ok) -> Void in
                })
            }) {
            self.imageTokens.append(token)
        } else {
            self.userImage.image = UIImage(named: "user_placeholder")
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.parkButton.addTarget(self, action: #selector(PUParkDetailView.parkAction), forControlEvents: .TouchUpInside)
        self.parkButton.layer.borderWidth = 1
        self.parkButton.layer.borderColor = UIColor.grayColor().CGColor
    }
    
    func updateViewWithPark(park: Parking) {
        self.park = park
        self.userName.text = park.ownerName
        self.parkStreet.text = park.street
        if let url = park.ownerImageThumb where url != "" {
            self.setImageURL(url)
        } else {
            self.userImage.image = UIImage(named: "user_placeholder")
        }
    }

    func cancelImageLoading() {
        _ = self.imageTokens.map({
            $0.cancel()
        })
        self.imageTokens.removeAll()
    }
    
    func parkAction() {
        self.delegate?.puParDelegateBookPark(self.park)
    }

}
