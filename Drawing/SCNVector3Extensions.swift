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
    
    mutating func scaleBy(_ scalar: Float) {
        self.x *= scalar
        self.y *= scalar
        self.z *= scalar
    }
    
}
