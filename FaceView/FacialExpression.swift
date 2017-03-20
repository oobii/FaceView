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
        case Open
        case Closed
        case Squinting
    }

enum EyeBrows: Int {
    case Relaxed
    case Normal
    case Furrowed
    
    func moreRelaxedBrow() -> EyeBrows {
        return EyeBrows(rawValue: rawValue - 1) ?? .Relaxed
    }
    func moreFurrowBrow() -> EyeBrows {
        return EyeBrows(rawValue: rawValue + 1) ?? .Furrowed
    }
}

enum Mouth: Int {
    case Frown
    case Smirk
    case Neutral
    case Grin
    case Smile
    
    func sadderMouth() -> Mouth {
        return Mouth(rawValue: rawValue - 1) ?? .Frown
    }
    func happieMouth() -> Mouth {
        return Mouth(rawValue: rawValue + 1) ?? .Smile
    }
}

var eyes: Eyes
var eyeBrows: EyeBrows
var mouth: Mouth

}