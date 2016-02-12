//
//  Expression.swift
//  PathKit
//
//  Created by 林達也 on 2016/02/13.
//  Copyright © 2016年 jp.sora0077. All rights reserved.
//

import Foundation

public struct Expression {
    
    private var paths: [Path] = []
    
    public init(path: String) {
        
        if path[path.startIndex] == "/" {
            paths.append(.Root)
        }
        
        for p in (path.characters.split { $0 == "/" }) {
            let p = String(p)
            switch p {
            case ".":
                if paths.count == 0 {
                    paths.append(.Current)
                }
            case "..":
                if let last = paths.last {
                    switch last {
                    case .Parent:
                        paths.append(.Parent)
                    default:
                        paths.removeLast()
                    }
                } else {
                    paths.append(.Parent)
                }
            default:
                paths.append(.Letter(p))
            }
        }
        if paths.count == 0 {
            paths.append(.Current)
        }
    }
    
    init() {}
}

extension Expression: SequenceType {
    
    public var count: Int {
        return paths.count
    }
    
    public var first: Path? {
        return paths.first
    }
    
    public var last: Path? {
        return paths.last
    }
    
    public subscript(idx: Int) -> Path {
        return paths[idx]
    }
    
    public func generate() -> IndexingGenerator<[Path]> {
        return paths.generate()
    }
}


extension Expression {
    
    public func traverse(to: Expression) -> Expression {
        
        var ret = Expression()
        
        if to[0] == .Root {
            var idx = 0
            for (i, (l, r)) in zip(self, to).enumerate() {
                if l == r {
                    idx++
                } else {
                    idx = i
                    break
                }
            }
            for _ in paths[idx..<count] {
                ret.paths.append(.Parent)
            }
            if self.count == idx {
                ret.paths.append(.Current)
            }
            for p in to.paths[idx..<to.count] {
                switch p {
                case .Current:
                    break
                case .Root:
                    break
                default:
                    ret.paths.append(p)
                }
            }
        } else {
            ret.paths = paths
            for p in to {
                switch p {
                case .Parent:
                    if ret.last != .Root {
                        ret.paths.removeLast()
                    }
                case .Current:
                    break
                default:
                    ret.paths.append(p)
                }
            }
        }
        return ret
    }
}

extension Expression: CustomStringConvertible {
    
    public var description: String {
        return paths.reduce("", combine: { i, p in
            i + p.description
        })
    }
}
