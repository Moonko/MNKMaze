final class Maze {
    let size: Int

    private(set) var squares: [Bool] // visited or not
    private(set) var path = [Int]()

    init(size: Int) {
        self.size = size
        self.squares = [Bool](repeating: false, count: size * size)
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
            (square % size) != 0 ?          square - 1 : nil,       // left
            square > size ?                 square - size : nil,    // top
            ((square + 1) % size) != 0 ?    square + 1 : nil,       // right
            square < (size * (size - 1)) ?  square + size : nil,    // bottom
        ].compactMap { $0 }.filter { !squares[$0] }.randomElement()
    }

    func isGenerated() -> Bool {
        squares.allSatisfy { $0 }
    }
}
