//
//  Movement.swift
//  ChessGame
//
//  Created by Raycho Kostadinov on 20.04.22.
//

import Foundation


public class Movement {

    public static func down(currCoordinates: Coordinates, moveable: Movable) -> [Coordinates]? {
        
        // it could be written with recursion, I think, but anyways
        
        var possibleCoordinates: [Coordinates] = []
        
        var x = currCoordinates.x
        
        for _ in 1...moveable.maxSquares {
            x += 1
            if x > 7 {
                break
            }
            let nextCoordinates = Coordinates(x, currCoordinates.y)
            possibleCoordinates.append(nextCoordinates)
        }

        return possibleCoordinates
    }
    
    public static func up(currCoordinates: Coordinates, moveable: Movable) -> [Coordinates]? {
        
        var possibleCoordinates: [Coordinates] = []
        
        var x = currCoordinates.x
        
        for _ in 1...moveable.maxSquares {
            x -= 1
            if x < 0 {
                break
            }
            let nextCoordinates = Coordinates(x, currCoordinates.y)
            possibleCoordinates.append(nextCoordinates)
        }

        return possibleCoordinates
    }
    
    public static func left(currCoordinates: Coordinates, moveable: Movable) -> [Coordinates]? {
        
        var possibleCoordinates: [Coordinates] = []
        
        var y = currCoordinates.y
        
        for _ in 1...moveable.maxSquares {
            y -= 1
            if y < 0 {
                break
            }
            let nextCoordinates = Coordinates(currCoordinates.x, y)
            possibleCoordinates.append(nextCoordinates)
        }

        return possibleCoordinates
    }
    
    public static func right(currCoordinates: Coordinates, moveable: Movable) -> [Coordinates]? {
        
        var possibleCoordinates: [Coordinates] = []
        
        var y = currCoordinates.y
        
        for _ in 1...moveable.maxSquares {
            y += 1
            if y > 7 {
                break
            }
            let nextCoordinates = Coordinates(currCoordinates.x, y)
            possibleCoordinates.append(nextCoordinates)
        }

        return possibleCoordinates
    }
    
    public static func diagUpLeft(currCoordinates: Coordinates, moveable: Movable) -> [Coordinates]? {
        
        var possibleCoordinates: [Coordinates] = []
        
        var x = currCoordinates.x
        var y = currCoordinates.y
        
        for _ in 1...moveable.maxSquares {
            x -= 1
            y -= 1
            if y > 7 || x > 7 {
                break
            }
            let nextCoordinates = Coordinates(x, y)
            possibleCoordinates.append(nextCoordinates)
        }

        return possibleCoordinates
    }
    
    public static func diagUpRight(currCoordinates: Coordinates, moveable: Movable) -> [Coordinates]? {
        
        var possibleCoordinates: [Coordinates] = []
        
        var x = currCoordinates.x
        var y = currCoordinates.y
        
        for _ in 1...moveable.maxSquares {
            x -= 1
            y += 1
            if y > 7 || x > 7 {
                break
            }
            let nextCoordinates = Coordinates(x, y)
            possibleCoordinates.append(nextCoordinates)
        }

        return possibleCoordinates
    }
    
    public static func diagDownLeft(currCoordinates: Coordinates, moveable: Movable) -> [Coordinates]? {
        
        var possibleCoordinates: [Coordinates] = []
        
        var x = currCoordinates.x
        var y = currCoordinates.y
        
        for _ in 1...moveable.maxSquares {
            x += 1
            y -= 1
            if y > 7 || x > 7 {
                break
            }
            let nextCoordinates = Coordinates(x, y)
            possibleCoordinates.append(nextCoordinates)
        }

        return possibleCoordinates
    }
    
    public static func diagDownRight(currCoordinates: Coordinates, moveable: Movable) -> [Coordinates]? {
        
        var possibleCoordinates: [Coordinates] = []
        
        var x = currCoordinates.x
        var y = currCoordinates.y
        
        for _ in 1...moveable.maxSquares {
            x += 1
            y += 1
            if y > 7 || x > 7 {
                break
            }
            let nextCoordinates = Coordinates(x, y)
            possibleCoordinates.append(nextCoordinates)
        }

        return possibleCoordinates
    }
    
    public static func isPathBlocked(currCoordinates: Coordinates,
                                     destCoordinates: Coordinates, board: [[Figure?]]) -> Bool {
        
        var xCurr = currCoordinates.x
        var yCurr = currCoordinates.y
        
        let xDest = destCoordinates.x
        let yDest = destCoordinates.y
        
        if let figure = board[currCoordinates.x][currCoordinates.y], figure is Knight {
            return false
        }
        
        switch (xDest, yDest) {
            
        case (let xDest, let yDest) where xDest > xCurr && yDest == yCurr:
            // down
            xCurr += 1
            
            while xCurr != xDest {
            
                if board[xCurr][yCurr] != nil {
                    return true
                }
                xCurr += 1
            }
            return false
            
        case (let xDest, let yDest) where xDest < xCurr && yDest == yCurr:
            // up
            xCurr -= 1
            
            while xCurr != xDest {
                
                if board[xCurr][yCurr] != nil {
                    return true
                }
                xCurr -= 1
            }
            return false
            
        case(let xDest, let yDest) where yDest < yCurr && xDest == xCurr:
            // left
            yCurr -= 1
            
            while yCurr != yDest {
                
                if board[xCurr][yCurr] != nil {
                    return true
                }
                yCurr -= 1
            }
            return false
            
        case(let xDest, let yDest) where yDest > yCurr && xDest == xCurr:
            // right
            yCurr += 1
            
            while yCurr != yDest {
                
                if board[xCurr][yCurr] != nil {
                    return true
                }
                yCurr += 1
            }
            return false
            
        case(let xDest, let yDest) where xDest < xCurr && yDest < yCurr:
            // diagonal up left
            xCurr -= 1
            yCurr -= 1
            
            while xDest != xCurr && yDest != yCurr {
                
                if board[xCurr][yCurr] != nil {
                    return true
                }
                xCurr -= 1
                yCurr -= 1
            }
            return false
            
        case(let xDest, let yDest) where xDest < xCurr && yDest > yCurr:
            // diagonal up right
            xCurr -= 1
            yCurr += 1
            
            while xDest != xCurr && yDest != yCurr {
                
                if board[xCurr][yCurr] != nil {
                    return true
                }
                xCurr -= 1
                yCurr += 1
            }
            return false
            
        case(let xDest, let yDest) where xDest > xCurr && yDest < yCurr:
            // diagonal down left
            xCurr += 1
            yCurr -= 1
            
            while xDest != xCurr && yDest != yCurr {
                
                if board[xCurr][yCurr] != nil {
                    return true
                }
                xCurr += 1
                yCurr -= 1
            }
            return false
            
        case(let xDest, let yDest) where xDest > xCurr && yDest > yCurr:
            // diagonal down right
            xCurr += 1
            yCurr += 1
            
            while xDest != xCurr && yDest != yCurr {
                
                if board[xCurr][yCurr] != nil {
                    return true
                }
                xCurr += 1
                yCurr += 1
            }
            return false
            
        default:
            return false
            
        }
    }
    
}
