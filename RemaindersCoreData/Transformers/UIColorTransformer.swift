//
//  UIColorTransformer.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/12/24.
//

import SwiftUI

class UIColorTransformer: ValueTransformer {
    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? UIColor else { return nil }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
            return data
        } catch {
            print("Error archiving color to Data: \(error)")
            return nil
        }
        
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        
        guard let data = value as? Data else { return nil }
        
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
            return color
        } catch {
            print("Error unarchiving data to UIColor: \(error)")
            return nil
        }
    }
}
