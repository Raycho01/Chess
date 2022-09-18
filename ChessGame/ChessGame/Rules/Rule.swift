//
//  Rule.swift
//  ChessGame
//
//  Created by Raycho Kostadinov on 28.04.22.
//

import Foundation

enum Outcome {
    case valid, invalid, checkmate
}

protocol Rule {
    
    static func validate(gameBoard: GameBoard, currCoord: Coordinates, destCoord: Coordinates, player: Player) -> Outcome
    
    static var error: String { get }
}
