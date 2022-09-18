//
//  Player.swift
//  ChessGame
//
//  Created by Raycho Kostadinov on 19.04.22.
//

import Foundation

public class Player {
    
    let team: Color
    
    var lostFigures: [Figure?] = []
    
    init(team: Color) {
        self.team = team
    }
}
