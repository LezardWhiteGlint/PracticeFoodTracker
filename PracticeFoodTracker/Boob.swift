//
//  Boob.swift
//  PracticeBoobsTracker
//
//  Created by Lezardvaleth on 2019/2/11.
//  Copyright © 2019 Lezardvaleth. All rights reserved.
//

import UIKit
import os.log

class Boob: NSObject, NSCoding {
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //MARK: Archiving paths
    static let DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentDirectory.appendingPathComponent("boobs")
    
    //MARK: Initializer
    init?(name:String, photo: UIImage?, rating: Int) {
        // Initialization should fail if there is no name or if rating is negative
        guard !name.isEmpty else {
            return nil
        }
        guard (rating>=0) && (rating<=5) else {
            return nil
        }
        // Initialize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey:PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey:PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Boob object.", log: OSLog.default, type: .debug)
            return nil
        }
        // Because photo is an optional property of Boob, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        self.init(name: name, photo: photo, rating: rating)
    }
}
