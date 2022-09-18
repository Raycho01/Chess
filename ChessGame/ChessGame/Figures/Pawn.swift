//
//  Pawn.swift
//  ChessGame
//
//  Created by Raycho Kostadinov on 18.04.22.
//

import Foundation

public class Pawn: Figure {
    
    public var maxSquares: Int = 2
    
    public var team: Color
    
    public var symbol: Character
    
    public var currCoordinates: Coordinates {
        didSet {
            isAtStart = false
            updatePossibleCoord()
        }
    }
    
    public var possibleCoordinates: [Coordinates] = []
    
    private var isAtStart = true
    
    public func updatePossibleCoord() {
        
        possibleCoordinates.removeAll()
        
        switch self.team {
            
            case .white:
            
                let downPos = Movement.down(currCoordinates: currCoordinates, moveable: self)
            
                if isAtStart {
                    downPos?.forEach({ coordinates in
                        possibleCoordinates.append(coordinates)
                    })
                } else {
                    if let onlyPossibleDownPos = downPos?.first {
                        possibleCoordinates.append(onlyPossibleDownPos)
                    }
                }
                
                if let diagDownLeftPos = Movement.diagDownLeft(currCoordinates: currCoordinates, moveable: self)?.first {
                    possibleCoordinates.append(diagDownLeftPos)
                }
                
                if let diagDownRightPos = Movement.diagDownRight(currCoordinates: currCoordinates, moveable: self)?.first {
                    possibleCoordinates.append(diagDownRightPos)
                }
            
            case .black:
            
                let upPos = Movement.up(currCoordinates: currCoordinates, moveable: self)
                
                if isAtStart {
                    upPos?.forEach({ coordinates in
                        possibleCoordinates.append(coordinates)
                    })
                } else {
                    if let onlyPossibleUpPos = upPos?.first {
                        possibleCoordinates.append(onlyPossibleUpPos)
                    }
                }
                
                if let diagUpLeftPos = Movement.diagUpLeft(currCoordinates: currCoordinates, moveable: self)?.first {
                    possibleCoordinates.append(diagUpLeftPos)
                }
                
                if let diagUpRightPos = Movement.diagUpRight(currCoordinates: currCoordinates, moveable: self)?.first {
                    possibleCoordinates.append(diagUpRightPos)
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
    
    
    init(team: Color, y: Int) {
        self.team = team
        switch team {
            case .white:
                symbol = "P"
                currCoordinates = Coordinates(1, y)
            case .black:
                symbol = "p"
                currCoordinates = Coordinates(6, y)
        }
        updatePossibleCoord()
    }
}
