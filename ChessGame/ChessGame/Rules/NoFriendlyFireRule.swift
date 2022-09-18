//
//  NoFriendlyFireRule.swift
//  ChessGame
//
//  Created by Raycho Kostadinov on 28.04.22.
//

import Foundation

class NoFriendlyFireRule: Rule {
    
    static func validate(gameBoard: GameBoard, currCoord: Coordinates, destCoord: Coordinates, player: Player) -> Outcome {
        
        guard let currFig = gameBoard.board[currCoord.x][currCoord.y],
              let destFig = gameBoard.board[destCoord.x][destCoord.y] else {
            return .valid
        }
        
        let isSameTeam = currFig.team == destFig.team
        
        if !isSameTeam {
            if currFig is King {
                return .checkmate
            }
            return .valid
        }
        return .invalid
    }
    
    static var error: String = "You can't move to this position, because you own both figures."
    
}
