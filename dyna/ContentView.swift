//
//  ContentView.swift
//  dyna
//
//  Created by Zaid Dahir on 2023-03-26.
//
import SwiftUI

struct ContentView: View {
    @State private var rows = 4
    @State private var columns = 4
    @State private var showGrid = false

    var body: some View {
        VStack {
            if showGrid {
                VStack {
                    ConnectFourGrid(rows: rows, columns: columns)
                    
                    Button(action: {
                        showGrid = false
                    }) {
                        Text("Back")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            } else {
                VStack(spacing: 20) {
                    Picker("Number of rows", selection: $rows) {
                        ForEach(4...10, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                    
                        Picker("Number of columns", selection: $columns) {
                        ForEach(4...10, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                    
                    Button(action: {
                        showGrid = true
                    }) {
                        Text("Create Grid")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
    }
}

struct ConnectFourGrid: View {
    let rows: Int
    let columns: Int
    @ObservedObject var gameModel: ConnectFourModel

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.gameModel = ConnectFourModel(rows: rows, columns: columns)
    }

    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<gameModel.grid.count, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(0..<gameModel.grid[row].count, id: \.self) { column in
                        CircleButton(color: colorForCellState(gameModel.grid[row][column])) {
                            gameModel.play(column: column)
                        }
                    }
                }
            }
            
            Button(action: {
                gameModel.reset()
            }) {
                Text("Reset")
                    .font(.title2)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top)
        }
    }
    
    func colorForCellState(_ state: CellState) -> Color {
        switch state {
        case .empty:
            return Color.white
        case .filled(let player):
            return player == .red ? Color.red : Color.yellow
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
