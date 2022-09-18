//
//  Types.swift
//  ChessGame
//
//  Created by Raycho Kostadinov on 19.04.22.
//

import Foundation

public enum Color {
    case black, white
}

public enum Side {
    case left, right
}

public struct Position: Equatable {
    var x: Int
    var y: Character
    
    init(_ x: Int, _ y: Character) {
        self.x = x
        self.y = y
    }
    
    public static func convertToPosition(coordinates: Coordinates) -> Position? {
        
        let x = coordinates.x
        let y = coordinates.y + 97
        
        guard let myUnicodeScalar = UnicodeScalar(y) else {
            return nil
        }
        
        let xFinal = 8 - x
        let yFinal = Character(myUnicodeScalar)
        
        if yFinal <= "h", xFinal >= 1, xFinal <= 8 {
            return nil
        }
       
        return Position(xFinal, yFinal)
    }
    
    public static func convertToPosition(line: String) -> Position? {
        
        let positionInChars: [Character] = line.map { char in
            char
        }
        
        guard let xIntValue = positionInChars[1].wholeNumberValue else {
            return nil
        }
        
        return Position(xIntValue, positionInChars[0])
        
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

public struct Coordinates: Equatable {
    var x: Int
    var y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    public static func convertToCoordinates(position: Position) -> Coordinates {
        
        let x = position.x
        let y = position.y

        guard let yPos = y.asciiValue, yPos >= 97, yPos <= 105, x >= 1, x <= 8 else {
            return Coordinates(-1, -1)
        }
        
        let xFinal = 8 - x
        let yFinal = Int(yPos) - 97
        
        return Coordinates(xFinal, yFinal)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

}
