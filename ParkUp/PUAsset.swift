//
//  IDBAsset.swift
//  idobi
//
//  Created by Victor Gabriel Chirino on 2/22/16.
//  Copyright © 2016 Victor Gabriel Chirino. All rights reserved.
//



import Foundation
import SDWebImage

public let PUAsset = PUAssetClass()
public class PUAssetClass {
    
//    private let font = STFont.SFUITextMedium(12.0)
    
//    var initialsColor = UIColor.whiteColor()
//    var backgroundColor = STColor.StrideGray()
//    private var avatarAttributes : [String:AnyObject]?
    private var imageManager = SDWebImageManager.sharedManager()
    
    private init() {
        //caching for drawing avatars
        let style = NSMutableParagraphStyle()
        style.alignment = .Center
//        self.avatarAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: initialsColor, NSParagraphStyleAttributeName: style]
    }
    
    func fetchImage(url urlString: String, completionHandler:((img:UIImage?) -> Void)) -> SDWebImageOperation? {
        if let url = NSURL(string:urlString) {
            return imageManager.downloadImageWithURL(url, options: .AvoidAutoSetImage, progress: nil, completed: { (image, err, cacheType, ok, url) -> Void in
                if let img = image where err == nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completionHandler(img:img)
                    })
                } else {
                    completionHandler(img:nil)
                }
            })
        }
        
        return nil
        
    }
    

}