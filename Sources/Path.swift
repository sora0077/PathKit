//
//  Path.swift
//  PathKit
//
//  Created by 林達也 on 2016/02/13.
//  Copyright © 2016年 jp.sora0077. All rights reserved.
//

import Foundation

public enum Path: Equatable {
    case Root
    case Current
    case Parent
    case Letter(String)
    
}

extension Path: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .Current:
            return "./"
        case .Parent:
            return "../"
        case .Root:
            return "/"
        case let .Letter(p):
            return p + "/"
        }
    }
}

public func ==(lhs: Path, rhs: Path) -> Bool {
    
    switch (lhs, rhs) {
    case (.Root, .Root):
        return true
    case (.Parent, .Parent):
        return true
    case (.Current, .Current):
        return true
    case (let .Letter(lhs), let .Letter(rhs)):
        return lhs == rhs
    default:
        return false
    }
}