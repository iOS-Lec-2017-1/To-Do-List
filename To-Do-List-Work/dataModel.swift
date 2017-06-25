//
//  dataModel.swift
//  To-Do-List-Work
//
//  Created by 김종현 on 2017. 6. 14..
//  Copyright © 2017년 DIT Apps. All rights reserved.
//

import Foundation

class dataModel : NSObject, NSCoding {
    //var id: String
    //var image: String
    var title: String
    var date: String
    
    init (title: String, date: String) {
        //self.id = id
        //self.image = image
        self.title = title
        self.date = date
    }
    
    // object decode
    required convenience init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let date = aDecoder.decodeObject(forKey: "date") as! String
        
        print("title = \(String(describing: title))")
        
        self.init(title: title, date: date)
        
    }
    
    // object encode
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.date, forKey: "date")
    }
    
}
