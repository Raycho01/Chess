//
//  MoveOnlyYourTeamRule.swift
//  ChessGame
//
//  Created by Raycho Kostadinov on 29.04.22.
//

import Foundation

class MoveOnlyYourTeamRule: Rule {
    
    static func validate(gameBoard: GameBoard, currCoord: Coordinates, destCoord: Coordinates, player: Player) -> Outcome {
        
        guard let figure = gameBoard.board[currCoord.x][currCoord.y] else {
            return .invalid
        }
        
        if figure.team != player.team {

            return .invalid
        }
        
        return .valid
    }
    
    static var error: String = "Invalid figure, try again"
    
}
