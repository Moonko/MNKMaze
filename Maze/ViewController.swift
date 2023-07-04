import UIKit

class ViewController: UIViewController {

    private lazy var mazeView = MazeView()

    let maze = Maze(size: 10)

    override func viewDidLoad() {
        super.viewDidLoad()

        maze.generatePath()
        mazeView.maze = maze

        view.backgroundColor = .black

        mazeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mazeView)
        NSLayoutConstraint.activate([
            mazeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mazeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mazeView.widthAnchor.constraint(equalTo: mazeView.heightAnchor),
            mazeView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24)
        ])
    }
}

