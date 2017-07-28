//
//  FacialExpression.swift
//  FaceView
//
//  Created by martynov on 2017-01-25.
//  Copyright © 2017 martynov. All rights reserved.
//

// Our Model

import Foundation

// UI-independent representation of a facial expression
// This is a Model that has to be interpreted by a Contoller for that View

struct FacialExpression
{
    enum Eyes: Int {
        case open
        case closed
        case squinting
    }

enum EyeBrows: Int {
    case relaxed
    case normal
    case furrowed
    
    func moreRelaxedBrow() -> EyeBrows {
        return EyeBrows(rawValue: rawValue - 1) ?? .relaxed
    }
    func moreFurrowBrow() -> EyeBrows {
        return EyeBrows(rawValue: rawValue + 1) ?? .furrowed
    }
}

enum Mouth: Int {
    case frown
    case smirk
    case neutral
    case grin
    case smile
    
    func sadderMouth() -> Mouth {
        return Mouth(rawValue: rawValue - 1) ?? .frown
    }
    func happieMouth() -> Mouth {
        return Mouth(rawValue: rawValue + 1) ?? .smile
    }
}

var eyes: Eyes
var eyeBrows: EyeBrows
var mouth: Mouth

}
