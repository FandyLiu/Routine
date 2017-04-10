//
//  MirrorTool.swift
//  SwiftDemo
//
//  Created by QianTuFD on 2017/2/15.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit


class MirrorTool {
    
    class func childsFrom(_ object: Any,_ keys: [String]) -> [Mirror.Child] {
        let r = Mirror(reflecting: object)
        return r.children.filter { (child) -> Bool in
            guard let label = child.label else {
                return false
            }
            return keys.contains(label)
        }
    }
    
    class func sortChildsFrom(_ object: Any,_ keys: String...) -> [Mirror.Child] {
        let childs = childsFrom(object, keys)
        return childs.sorted { $0.label! < $1.label! }
    }
    
    class func sortChildsFrom(_ object: Any,_ keys: String...) -> String {
        let childs = childsFrom(object, keys)
        let sortchilds = childs.sorted { $0.label! < $1.label! }
        var sortStr: String = ""
        
        
        
        for child in sortchilds {
//            guard let label = child.label, let value = child.value as? String else {
//                continue
//            }
//            sortStr = label + value
        }
        return sortStr
    }
    
}
