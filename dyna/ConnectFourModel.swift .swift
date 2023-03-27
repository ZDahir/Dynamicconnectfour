//
//  ConnectFourModel.swift .swift
//  dyna
//
//  Created by Zaid Dahir on 2023-03-26.
//
import Foundation

enum Player {
    case red
    case yellow
}

enum CellState: Equatable {
    case empty
    case filled(Player)
}

class ConnectFourModel: ObservableObject {
    @Published var grid: [[CellState]]
    var currentPlayer: Player = .red
    private let rows: Int
    private let columns: Int
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: Array(repeating: .empty, count: columns), count: rows)
    }

    func play(column: Int) {
        for row in (0..<grid.count).reversed() {
            if grid[row][column] == .empty {
                grid[row][column] = .filled(currentPlayer)
                
                if checkWin(for: currentPlayer) {
                    print("\(currentPlayer) wins!")
                    reset()
                } else if checkDraw() {
                    print("Draw!")
                    reset()
                } else {
                    currentPlayer = (currentPlayer == .red) ? .yellow : .red
                }
                
                break
            }
        }
    }
    
    func checkWin(for player: Player) -> Bool {
        let directions: [(Int, Int)] = [(1, 0), (1, -1), (1, 1), (0, 1)]
        
        for row in 0..<grid.count {
            for col in 0..<grid[row].count {
                if grid[row][col] == .filled(player) {
                    for direction in directions {
                        if checkWinFrom(row: row, col: col, direction: direction, player: player) {
                            return true
                        }
                    }
                }
            }
        }
        
        return false
    }
    
    private func checkWinFrom(row: Int, col: Int, direction: (Int, Int), player: Player) -> Bool {
        let target = 4
        
        for i in 0..<target {
            let newRow = row + i * direction.0
            let newCol = col + i * direction.1
            
            if newRow < 0 || newRow >= grid.count || newCol < 0 || newCol >= grid[newRow].count {
                return false
            }
            
            if grid[newRow][newCol] != .filled(player) {
                return false
            }
        }
        
        return true
    }
    
    func checkDraw() -> Bool {
        return grid.allSatisfy { row in row.allSatisfy { cell in cell != .empty } }
    }
    
    func reset() {
         grid = Array(repeating: Array(repeating: .empty, count: columns), count: rows)
         currentPlayer = .red
     }
}


