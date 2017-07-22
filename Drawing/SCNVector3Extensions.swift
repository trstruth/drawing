//
//  SCNVector3Extensions.swift
//  Drawing
//
//  Created by Tristan Struthers on 7/17/17.
//  Copyright © 2017 Tristan Struthers. All rights reserved.
//

import Foundation
import SceneKit

extension SCNVector3 {
    
    static func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3(left.x + right.x, left.y + right.y, left.z + right.z)
    }
    
    /**
     * Increments a SCNVector3 with the value of another.
     */
    static func += (left: inout SCNVector3, right: SCNVector3) {
        left = left + right
    }
    
    /**
     * Subtracts two SCNVector3 vectors and returns the result as a new SCNVector3.
     */
    static func - (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(left.x - right.x, left.y - right.y, left.z - right.z)
    }
    
    /**
     * Decrements a SCNVector3 with the value of another.
     */
    static func -= (left: inout SCNVector3, right: SCNVector3) {
        left = left - right
    }
    
    mutating func scaleBy(_ scalar: Float) {
        self.x *= scalar
        self.y *= scalar
        self.z *= scalar
    }
    
    /**
     * Returns the length (magnitude) of the vector described by the SCNVector3
     */
    static func SCNVector3Length(_ vector: SCNVector3) -> Float
    {
        return sqrtf(vector.x*vector.x + vector.y*vector.y + vector.z*vector.z)
    }
    
    /**
     * Returns the distance between two SCNVector3 vectors
     */
    static func SCNVector3Distance(vectorStart: SCNVector3, vectorEnd: SCNVector3) -> Float {
        return SCNVector3.SCNVector3Length(vectorEnd - vectorStart)
    }
    
}
