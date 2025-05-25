//
//  MemoryLeakTracker.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 25/05/25.
//

import Testing

struct MemoryLeakTracker<T: AnyObject> {
    weak var instance: T?
    var sourceLocation: SourceLocation
    
    func verify() {
        #expect(instance == nil, "Memory leak detected at \(sourceLocation)")
    }
}
