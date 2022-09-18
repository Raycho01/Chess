//
//  Figure.swift
//  ChessGame
//
//  Created by Raycho Kostadinov on 15.04.22.
//

import Foundation

public protocol Movable {
    
    var maxSquares: Int { get }
}

public protocol Figure: Movable {
    
    var team: Color { get }
    
    var symbol: Character { get }
    
    var currCoordinates: Coordinates { get set }
    
    var possibleCoordinates: [Coordinates] { get set }
    
    func updatePossibleCoord()
    
    func canMoveTo(newCoordinates: Coordinates) -> Bool
    
}
