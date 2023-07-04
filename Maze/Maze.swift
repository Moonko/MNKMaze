final class Maze {
    let rows: Int
    let columns: Int

    private(set) var squares: [Bool] // visited or not
    private(set) var path = [Int]()

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.squares = [Bool](repeating: false, count: rows * columns)
    }

    func generatePath(startSquare: Int = 0) {
        squares[startSquare] = true

        var newPath = [Int]()
        var currentStack = [startSquare]

        while !isGenerated() {
            newPath.append(currentStack.last!)
            while let nextSquare = randomUnvisitedNeighbor(for: currentStack.last!) {
                squares[nextSquare] = true
                currentStack.append(nextSquare)
                newPath.append(nextSquare)
            }
            _ = currentStack.popLast()
        }
        path = newPath
    }

    func randomUnvisitedNeighbor(for square: Int) -> Int? {
        [
            (square % columns) != 0 ?          square - 1 : nil,       // left
            square > columns ?                 square - columns : nil,    // top
            ((square + 1) % columns) != 0 ?    square + 1 : nil,       // right
            square < (columns * (rows - 1)) ?  square + columns : nil,    // bottom
        ].compactMap { $0 }.filter { !squares[$0] }.randomElement()
    }

    func isGenerated() -> Bool {
        squares.allSatisfy { $0 }
    }
}
