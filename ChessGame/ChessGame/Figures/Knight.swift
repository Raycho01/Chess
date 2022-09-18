//
//  Knight.swift
//  ChessGame
//
//  Created by Raycho Kostadinov on 18.04.22.
//

import Foundation

public class Knight: Figure {
    
    public var maxSquares: Int = 2
    
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
        
        let upTemp = Movement.up(currCoordinates: currCoordinates, moveable: self)?.last
        let downTemp = Movement.down(currCoordinates: currCoordinates, moveable: self)?.last
        let leftTemp = Movement.left(currCoordinates: currCoordinates, moveable: self)?.last
        let rightTemp = Movement.right(currCoordinates: currCoordinates, moveable: self)?.last
        
        if let upCheckpoint = upTemp {
            
            if let upLeftPos = Movement.left(currCoordinates: upCheckpoint, moveable: self)?.first {
                possibleCoordinates.append(upLeftPos)
            }
            if let upRightPos = Movement.right(currCoordinates: upCheckpoint, moveable: self)?.first {
                possibleCoordinates.append(upRightPos)
            }
        }
        
        if let downCheckpoint = downTemp {
            
            if let downLeftPos = Movement.left(currCoordinates: downCheckpoint, moveable: self)?.first {
                possibleCoordinates.append(downLeftPos)
            }
            if let downRightPos = Movement.right(currCoordinates: downCheckpoint, moveable: self)?.first {
                possibleCoordinates.append(downRightPos)
            }
        }

        if let leftCheckpoint = leftTemp {
            
            if let leftUpPos = Movement.up(currCoordinates: leftCheckpoint, moveable: self)?.first {
                possibleCoordinates.append(leftUpPos)
            }
            if let leftDownPos = Movement.down(currCoordinates: leftCheckpoint, moveable: self)?.first {
                possibleCoordinates.append(leftDownPos)
            }
        }

        if let rightCheckpoint = rightTemp {
            
            if let rightUpPos = Movement.up(currCoordinates: rightCheckpoint, moveable: self)?.first {
                possibleCoordinates.append(rightUpPos)
            }
            if let rightDownPos = Movement.down(currCoordinates: rightCheckpoint, moveable: self)?.first {
                possibleCoordinates.append(rightDownPos)
            }
        }
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
            symbol = "N"
            if side == .left {
                currCoordinates = Coordinates(0, 1)
            } else {
                currCoordinates = Coordinates(0, 6)
            }
        case .black:
            symbol = "n"
            if side == .left {
                currCoordinates = Coordinates(7, 1)
            } else {
                currCoordinates = Coordinates(7, 6)
            }
        }
        updatePossibleCoord()
    }
}
