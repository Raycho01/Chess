//
//  gameBoard.swift
//  ChessGame
//
//  Created by Raycho Kostadinov on 15.04.22.
//

import Foundation

public class GameBoard {
    
    static var rules: [Rule.Type] {
        
        return [MoveOnlyYourTeamRule.self, NoFriendlyFireRule.self,
                CanFigureMoveToRule.self, IsDestinationClearRule.self]
    }
    
    private(set) var board: [[Figure?]]
    
    private var gameOver: Bool = false

    private var turns = 1
    
    init() {
        self.board = Array(repeating: Array(repeating: nil, count: 8), count: 8)
    }
    
    public func startGame() {
        
        let playerW = Player(team: .white)
        let playerB = Player(team: .black)
        
        prepareBoard()
        printBoard()

        while !gameOver {

            if turns % 2 == 1 {
                turnTo(playerW)
            } else {
                turnTo(playerB)
            }
            turns += 1
            
            printBoard()
            
        }
        
        print("\nGame over.\n")
        
    }
    
    private func turnTo(_ player: Player) {
        
        print("\n\(player.team) turn: ")
        
        guard let command = readLine()?.split(separator: " ").map({ return String($0) }) else {
            return
        }
        
        switch command[0] {
            
        case "start":
            
            gameOver = true
            return
            
        case "move":
            
            guard
                    let figPos = Position.convertToPosition(line: command[1]),
                    let destPos = Position.convertToPosition(line: command[2])
            else {
                    turns -= 1
                    return
            }
            
            let figCoord = Coordinates.convertToCoordinates(position: figPos)
            let destCoord = Coordinates.convertToCoordinates(position: destPos)
            
            if let figure = board[figCoord.x][figCoord.y] {
                
                if validate(command: command, currFigure: figure, figureCoordinates: figCoord, destinationCoordinates: destCoord, player: player) {
                    
                    move(figure: figure, to: destCoord, player: player)
                    
                    checkForPromotion(currFigure: figure, destCoordinates: destCoord, team: player.team)
                    
                }
            } else {
                
                turns -= 1
                return
            }
            
            
        case "castling":
            
            print("castling")
            
        default:
            
            print("Invalid command.")
            turns -= 1
        }
        
    }
    
    private func validate(command: [String], currFigure: Figure, figureCoordinates: Coordinates, destinationCoordinates: Coordinates, player: Player) -> Bool {

        for rule in Self.rules {
            switch rule.validate(gameBoard: self, currCoord: figureCoordinates, destCoord: destinationCoordinates, player: player) {
            case .valid:
                continue
            case .invalid:
                turns -= 1
                print(rule.error)
                return false
            case .checkmate:
                gameOver = true
                return false
            }
        }
        
        return true
            
    }

    private func isCheck(player: Player) -> Bool {

        var check = false
        var kingCoordinates: Coordinates? = nil
        let team = player.team

        board.forEach { array in
            array.forEach { figure in
                if figure is King && figure?.team == team {
                    kingCoordinates = figure?.currCoordinates
                }
            }
        }

        board.forEach { array in
            array.forEach { figure in
                if figure?.team != team {
                    figure?.possibleCoordinates.forEach({ coordinates in
                        if coordinates == kingCoordinates {
                            if Movement.isPathBlocked(currCoordinates: figure!.currCoordinates,
                                                      destCoordinates: kingCoordinates!,
                                                      board: board) == false {
                                print("You are checked, try another move")
                                check = true
                                return
                            }
                        }
                    })
                }
            }
        }

        return check
    }

    private func move(figure: Figure, to coordinates: Coordinates, player: Player? = nil) {
        
        var fig = figure
        
        let coordinatesToBe = coordinates
        let coordinatesToEmpty = fig.currCoordinates
        
        var x = coordinatesToBe.x
        var y = coordinatesToBe.y
        
        let tempBoard = board
        
        board[x][y] = fig
        
        if fig.currCoordinates != coordinates {
            
            x = coordinatesToEmpty.x
            y = coordinatesToEmpty.y
            
            board[x][y] = nil
            fig.currCoordinates = coordinates
        }
        
        if let player = player {
            if isCheck(player: player) {
                board = tempBoard
                x = coordinatesToEmpty.x
                y = coordinatesToEmpty.y
                fig.currCoordinates = Coordinates(x, y)
                turns -= 1
                return
            }
        }
        
    }
    
    func isPawnsMoveForward(currFigure: Figure, destCoordinates: Coordinates) -> Bool {

        if currFigure is Pawn && currFigure.currCoordinates.y != destCoordinates.y {
            return false
        }
        return true
    }
    
    private func checkForPromotion(currFigure: Figure, destCoordinates: Coordinates, team: Color) {
        
        // promotion rule (it can be written on one line I think)
        if team == .white {
            if currFigure is Pawn && destCoordinates.x == 7 {
                board[destCoordinates.x][destCoordinates.y] = Queen(team: team)
            }
        } else {
            if currFigure is Pawn && destCoordinates.x == 0 {
                board[destCoordinates.x][destCoordinates.y] = Queen(team: team)
            }
        }
    }
    
    private func printBoard() {
        print("\nBoard:\n")
        print("a b c d e f g h")
        print("----------------")
        var counter = 8
        board.forEach { array in
            array.forEach { fig in
                guard let fig = fig else {
                    print(". ", terminator: "")
                    return
                }
                print("\(fig.symbol) ", terminator: "")
            }
            print("|\(counter)", terminator: "")
            print()
            counter -= 1
        }
    }
    
    private func prepareBoard() {
        let kingW = King(team: .white)
        move(figure: kingW, to: kingW.currCoordinates)
        
        let queenW = Queen(team: .white)
        move(figure: queenW, to: queenW.currCoordinates)
        
        let kingB = King(team: .black)
        move(figure: kingB, to: kingB.currCoordinates)
        
        let queenB = Queen(team: .black)
        move(figure: queenB, to: queenB.currCoordinates)
        
        let rookWLeft = Rook(team: .white, side: .left)
        move(figure: rookWLeft, to: rookWLeft.currCoordinates)
        
        let rookWRight = Rook(team: .white, side: .right)
        move(figure: rookWRight, to: rookWRight.currCoordinates)
        
        let rookBLeft = Rook(team: .black, side: .left)
        move(figure: rookBLeft, to: rookBLeft.currCoordinates)
        
        let rookBRight = Rook(team: .black, side: .right)
        move(figure: rookBRight, to: rookBRight.currCoordinates)
        
        let bishopWLeft = Bishop(team: .white, side: .left)
        move(figure: bishopWLeft, to: bishopWLeft.currCoordinates)
        
        let bishopWRight = Bishop(team: .white, side: .right)
        move(figure: bishopWRight, to: bishopWRight.currCoordinates)
        
        let bishopBLeft = Bishop(team: .black, side: .left)
        move(figure: bishopBLeft, to: bishopBLeft.currCoordinates)
        
        let bishopBRight = Bishop(team: .black, side: .right)
        move(figure: bishopBRight, to: bishopBRight.currCoordinates)
        
        let knightWLeft = Knight(team: .white, side: .left)
        move(figure: knightWLeft, to: knightWLeft.currCoordinates)
        
        let knightWRight = Knight(team: .white, side: .right)
        move(figure: knightWRight, to: knightWRight.currCoordinates)
        
        let knightBLeft = Knight(team: .black, side: .left)
        move(figure: knightBLeft, to: knightBLeft.currCoordinates)
        
        let knightBRight = Knight(team: .black, side: .right)
        move(figure: knightBRight, to: knightBRight.currCoordinates)
        
        let pawnW1 = Pawn(team: .white, y: 0)
        let pawnW2 = Pawn(team: .white, y: 1)
        let pawnW3 = Pawn(team: .white, y: 2)
        let pawnW4 = Pawn(team: .white, y: 3)
        let pawnW5 = Pawn(team: .white, y: 4)
        let pawnW6 = Pawn(team: .white, y: 5)
        let pawnW7 = Pawn(team: .white, y: 6)
        let pawnW8 = Pawn(team: .white, y: 7)
        
        move(figure: pawnW1, to: pawnW1.currCoordinates)
        move(figure: pawnW2, to: pawnW2.currCoordinates)
        move(figure: pawnW3, to: pawnW3.currCoordinates)
        move(figure: pawnW4, to: pawnW4.currCoordinates)
        move(figure: pawnW5, to: pawnW5.currCoordinates)
        move(figure: pawnW6, to: pawnW6.currCoordinates)
        move(figure: pawnW7, to: pawnW7.currCoordinates)
        move(figure: pawnW8, to: pawnW8.currCoordinates)
        
        let pawnB1 = Pawn(team: .black, y: 0)
        let pawnB2 = Pawn(team: .black, y: 1)
        let pawnB3 = Pawn(team: .black, y: 2)
        let pawnB4 = Pawn(team: .black, y: 3)
        let pawnB5 = Pawn(team: .black, y: 4)
        let pawnB6 = Pawn(team: .black, y: 5)
        let pawnB7 = Pawn(team: .black, y: 6)
        let pawnB8 = Pawn(team: .black, y: 7)
        
        move(figure: pawnB1, to: pawnB1.currCoordinates)
        move(figure: pawnB2, to: pawnB2.currCoordinates)
        move(figure: pawnB3, to: pawnB3.currCoordinates)
        move(figure: pawnB4, to: pawnB4.currCoordinates)
        move(figure: pawnB5, to: pawnB5.currCoordinates)
        move(figure: pawnB6, to: pawnB6.currCoordinates)
        move(figure: pawnB7, to: pawnB7.currCoordinates)
        move(figure: pawnB8, to: pawnB8.currCoordinates)
        
        // set the whole board to be ready for playing
    }

}
