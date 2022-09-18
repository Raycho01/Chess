//
//  Queen.swift
//  ChessGame
//
//  Created by Raycho Kostadinov on 17.04.22.
//

import Foundation

public class Queen: Figure {
    
    public var maxSquares: Int = 8
    
    public let team: Color
    
    public let symbol: Character
    
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
        let diagUpLeftPos = Movement.diagUpLeft(currCoordinates: currCoordinates, moveable: self)
        let diagUpRightPos = Movement.diagUpRight(currCoordinates: currCoordinates, moveable: self)
        let diagDownLeftPos = Movement.diagDownLeft(currCoordinates: currCoordinates, moveable: self)
        let diagDownRightPos = Movement.diagDownRight(currCoordinates: currCoordinates, moveable: self)

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
    
    init(team: Color) {
        self.team = team
        switch team {
            case .white:
                symbol = "Q"
                currCoordinates = Coordinates(0, 3)
            case .black:
                symbol = "q"
                currCoordinates = Coordinates(7, 3)
        }
        updatePossibleCoord()
    }
}
