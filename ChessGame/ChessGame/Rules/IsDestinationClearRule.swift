//
//  IsDestinationClearRule.swift
//  ChessGame
//
//  Created by Raycho Kostadinov on 29.04.22.
//

import Foundation

class IsDestinationClearRule: Rule {
    
    static func validate(gameBoard: GameBoard, currCoord: Coordinates, destCoord: Coordinates, player: Player) -> Outcome {
        
        guard let figure = gameBoard.board[currCoord.x][currCoord.y] else {
            return .invalid
        }
        
        if gameBoard.board[destCoord.x][destCoord.y] == nil {
            
            if gameBoard.isPawnsMoveForward(currFigure: figure, destCoordinates: destCoord) {
                return .valid
            } else {
                return .invalid
            }
        }
        
        return .valid
    }
    
    static var error: String = "This figure can't move like that, try again"
    
}
