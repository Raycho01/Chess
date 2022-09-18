//
//  Bishop.swift
//  ChessGame
//
//  Created by Raycho Kostadinov on 18.04.22.
//

import Foundation

public class Bishop: Figure {
    
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
        
        let diagUpLeftPos = Movement.diagUpLeft(currCoordinates: currCoordinates, moveable: self)
        let diagUpRightPos = Movement.diagUpRight(currCoordinates: currCoordinates, moveable: self)
        let diagDownLeftPos = Movement.diagDownLeft(currCoordinates: currCoordinates, moveable: self)
        let diagDownRightPos = Movement.diagDownRight(currCoordinates: currCoordinates, moveable: self)

        diagUpLeftPos?.forEach({ coordinates in
            possibleCoordinates.append(coordinates)
        })
        diagUpRightPos?.forEach({ coordinates in
            possibleCoordinates.append(coordinates)
        })
        diagDownLeftPos?.forEach({ coordinates in
            possibleCoordinates.append(coordinates)
        })
        diagDownRightPos?.forEach({ coordinates in
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
            symbol = "B"
            if side == .left {
                currCoordinates = Coordinates(0, 2)
            } else {
                currCoordinates = Coordinates(0, 5)
            }
        case .black:
            symbol = "b"
            if side == .left {
                currCoordinates = Coordinates(7, 2)
            } else {
                currCoordinates = Coordinates(7, 5)
            }
        }
        updatePossibleCoord()
    }
    
    
}
