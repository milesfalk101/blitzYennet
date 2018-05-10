//
//  WIPhoto.swift
//  Wardrobez
//
//  Created by Sophia Blitz on 5/10/18.
//  Copyright © 2018 Maharishi School. All rights reserved.
//

import Foundation
import UIKit

class WIPhoto : Equatable {
    var thumbnail : UIImage?
    var largeImage : UIImage?
    let photoID : String
    
    init (photoID:String) {
        self.photoID = photoID
    }
    func loadLargeImage()->WIPhoto{
        // TO DO
        return WIPhoto(photoID:"TODO")
    }
    
    func sizeToFillWidthOfSize(_ size:CGSize) -> CGSize {
        
        guard let thumbnail = thumbnail else {
            return size
        }
        
        let imageSize = thumbnail.size
        var returnSize = size
        
        let aspectRatio = imageSize.width / imageSize.height
        
        returnSize.height = returnSize.width / aspectRatio
        
        if returnSize.height > size.height {
            returnSize.height = size.height
            returnSize.width = size.height * aspectRatio
        }
        
        return returnSize
    }
    
}
func == (lhs: WIPhoto, rhs: WIPhoto) -> Bool {
    return lhs.photoID == rhs.photoID
}
