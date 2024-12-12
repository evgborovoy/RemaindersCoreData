//
//  MyList+CoreDataProperties.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/12/24.
//

import Foundation
import SwiftUI
import CoreData

extension MyList {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyList> {
        return NSFetchRequest<MyList>(entityName: "MyList")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var color: UIColor
}

extension MyList: Identifiable {
    
}
