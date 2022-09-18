//
//  Rook.swift
//  ChessGame
//
//  Created by Raycho Kostadinov on 18.04.22.
//

import Foundation

public class Rook: Figure {
    
    public var maxSquares: Int = 8

    public var team: Color
    
    public var symbol: Character
    
    public var currCoordinates: Coordinates {
        didSet {
            updatePossibleCoord()
        }
    }
    
    public var possibleCoordinates: [Coordinates] = []
    
    public func updatePossibleCoord() {
        
        possibleCoordinates.removeAll()
        
        let upPos = Movement.up(currCoordinates: currCoordinates, moveable: self)
        let downPos = Movement.down(currCoordinates: currCoordinates, moveable: self)
        let leftPos = Movement.left(currCoordinates: currCoordinates, moveable: self)
        let rightPos = Movement.right(currCoordinates: currCoordinates, moveable: self)

        upPos?.forEach({ coordinates in
            possibleCoordinates.append(coordinates)
        })
        downPos?.forEach({ coordinates in
            possibleCoordinates.append(coordinates)
        })
        leftPos?.forEach({ coordinates in
            possibleCoordinates.append(coordinates)
        })
        rightPos?.forEach({ coordinates in
            possibleCoordinates.append(coordinates)
        })
    }
    
    public func canMoveTo(newCoordinates: Coordinates) -> Bool {
        
        var canMove = false
        
        possibleCoordinates.forEach({ coordinates in
            if newCoordinates == coordinates {
                canMove = true
                return
            }
        })
        
        return canMove
    }
    
    init(team: Color, side: Side) {
        self.team = team
        switch team {
        case .white:
            symbol = "R"
            if side == .left {
                currCoordinates = Coordinates(0, 0)
            } else {
                currCoordinates = Coordinates(0, 7)
            }
        case .black:
            symbol = "r"
            if side == .left {
                currCoordinates = Coordinates(7, 0)
            } else {
                currCoordinates = Coordinates(7, 7)
            }
        }
        updatePossibleCoord()
    }
    
}
