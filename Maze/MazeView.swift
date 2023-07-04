import UIKit

final class MazeView: UIView {
    var maze: Maze? {
        didSet {
            updatePaths()
        }
    }

    private let pathLayer = CAShapeLayer()
    private let currentSquareLayer = CALayer()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .black
        pathLayer.strokeColor = UIColor.white.cgColor
        currentSquareLayer.backgroundColor = UIColor.red.cgColor

        pathLayer.lineCap = .round
        pathLayer.lineJoin = .round

        layer.addSublayer(pathLayer)
        layer.addSublayer(currentSquareLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        pathLayer.frame = bounds
        CATransaction.commit()

        updatePaths()
    }

    func animatePathGeneration() {
        let duration = 10.0

        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = 1.0
        pathAnimation.duration = duration
        pathLayer.add(pathAnimation, forKey: nil)

        let squareAnimation = CAKeyframeAnimation(keyPath: "position")
        squareAnimation.path = pathLayer.path
        squareAnimation.duration = duration
        squareAnimation.fillMode = .both
        squareAnimation.isRemovedOnCompletion = false
        currentSquareLayer.add(squareAnimation, forKey: nil)
    }

    func updatePaths() {
        guard let maze, bounds.size != .zero else { return }

        let borderWidth: CGFloat = bounds.width / 50
        let lineWidth = (bounds.width - borderWidth * CGFloat(maze.size + 1)) / CGFloat(maze.size)

        func coordinates(for square: Int) -> CGPoint {
            let xIndex = CGFloat(square % maze.size)
            let yIndex = CGFloat(square / maze.size)
            return CGPoint(
                x: borderWidth + xIndex * (lineWidth + borderWidth) + lineWidth / 2,
                y: borderWidth + yIndex * (lineWidth + borderWidth) + lineWidth / 2
            )
        }

        let mazePath = UIBezierPath()
        (1 ..< maze.path.count).forEach { index in
            mazePath.move(to: coordinates(for: maze.path[index - 1]))
            mazePath.addLine(to: coordinates(for: maze.path[index]))
        }

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        pathLayer.lineWidth = lineWidth
        pathLayer.path = mazePath.cgPath
        currentSquareLayer.bounds.size = CGSize(width: lineWidth, height: lineWidth)
        currentSquareLayer.position = coordinates(for: maze.path[0])
        currentSquareLayer.cornerRadius = currentSquareLayer.bounds.width / 2
        CATransaction.commit()

        animatePathGeneration()
    }
}
