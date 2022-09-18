//
//  King.swift
//  ChessGame
//
//  Created by Raycho Kostadinov on 16.04.22.
//

import Foundation

public class King: Figure {
    
    public var maxSquares: Int = 1
    
    public let team: Color
    
    public let symbol: Character
    
    public var currCoordinates: Coordinates {
        didSet {
            updatePossibleCoord()
        }
    }
    
    public var possibleCoordinates: [Coordinates] = []

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
     
    public func updatePossibleCoord() {
        
        possibleCoordinates.removeAll()
        
        // Maybe this can be done in easier and shorter way but anyway
        
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
    
    init(team: Color) {
        self.team = team
        switch team {
            case .white:
                symbol = "K"
                currCoordinates = Coordinates(0, 4)
            case .black:
                symbol = "k"
                currCoordinates = Coordinates(7, 4)
        }
        updatePossibleCoord()
    }
}
