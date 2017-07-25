//
//  Tool.swift
//  Drawing
//
//  Created by Tristan Struthers on 7/17/17.
//  Copyright © 2017 Tristan Struthers. All rights reserved.
//

import Foundation
import CoreGraphics
import SceneKit

class Tool {
    
    // MARK: - Class Properties
    var size: CGFloat
    var distanceFromCamera: Float
    var currentMode: toolMode
    var rootNode: SCNNode?
    var toolNode: SCNNode!
    var selection: Set<SCNNode>
    
    // MARK: - Initializers
    init() {
        size = CGFloat(0.007)
        distanceFromCamera = 0.5
        currentMode = toolMode.Pen
        selection = []
        // toolNode = SCNNode()
        toolNode = loadNodeFromFile(filename: "pen.dae", directory: "./")//, directory: "art.scnassets")
    }
    
    enum toolMode {
        
        case Pen
        /*
        The pen tool draws lines
        Pressing and holding should begin drawing a line
        Pinching should change the size of the pen
         */
        
        case Manipulator
        /*
        The manipulator lets you reposition and resize nodes
        Tapping objects should add/remove them to current selection and change their color
        Pressing and holding should let you reposition the current selection
        Pinching should change the size of all nodes in the current selection
         */
    }
    
    // MARK: - Public Class Methods
    
    func updateSelection(withSelectedNode parentNode: SCNNode) {
        if selection.contains(parentNode) {
            selection.remove(parentNode) // bad access
            for childNode in parentNode.childNodes {
                childNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
            }
        } else {
            selection.insert(parentNode)
            for childNode in parentNode.childNodes {
                childNode.geometry?.firstMaterial?.diffuse.contents = UIColor.darkGray
            }
        }
    }
    
    func changeMode(_ newMode: toolMode) {
        self.currentMode = newMode
        /*
        switch newMode {
        case .Pen:
             break
            
        case .Manipulator:
            toolNode!.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
        }
         */
    }
    
    func swipe(_ recognizer: UISwipeGestureRecognizer) {
        switch recognizer.direction {
        case UISwipeGestureRecognizerDirection.left, UISwipeGestureRecognizerDirection.right:
            if currentMode == .Manipulator {
                changeMode(.Pen)
            } else {
                changeMode(.Manipulator)
            }
        default:
            break
        }
    }
    
    func pinch(_ recognizer: UIPinchGestureRecognizer) {
        switch currentMode {
        case .Pen:
            switch recognizer.state {
            case .began, .changed:
                size *= recognizer.scale
                recognizer.scale = 1
            default: break
            }
        case .Manipulator:
            switch recognizer.state {
            case .began, .changed:
                for parentNode in selection {
                    parentNode.scale.scaleBy(Float(recognizer.scale))
                    recognizer.scale = 1
                }
            default: break
            }
        }
    }
    
    
    // MARK: - Private Class Methods
    
    func loadNodeFromFile(filename: String, directory: String) -> SCNNode {
        if let scene = SCNScene(named: filename) {
            let retNode = SCNNode()
            scene.rootNode.childNodes.forEach({node in
                retNode.addChildNode(node)
                })
            return retNode
        } else {
            print("Invalid path supplied")
            return SCNNode()
        }
    }
    
}
