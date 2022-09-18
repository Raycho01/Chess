//
//  CanFigureMoveToRule.swift
//  ChessGame
//
//  Created by Raycho Kostadinov on 29.04.22.
//

import Foundation

class CanFigureMoveToRule: Rule {
    
    static func validate(gameBoard: GameBoard, currCoord: Coordinates, destCoord: Coordinates, player: Player) -> Outcome {
        
        guard let figure = gameBoard.board[currCoord.x][currCoord.y] else {
            return .invalid
        }
        
        if figure.canMoveTo(newCoordinates: destCoord) &&
            Movement.isPathBlocked(currCoordinates: currCoord,
                                   destCoordinates: destCoord,
                                   board: gameBoard.board) == false {
            return .valid
        }
        
        return .invalid
    }
    
    static var error: String = "\nThis figure can't move like that, try again"
    
}
