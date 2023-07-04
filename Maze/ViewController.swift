import UIKit

class ViewController: UIViewController {

    private lazy var mazeView = MazeView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        mazeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mazeView)
        NSLayoutConstraint.activate([
            mazeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mazeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mazeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mazeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard view.bounds.size != .zero else { return }
        let maze = Maze(rows: 40, columns: 20)
        maze.generatePath()
        mazeView.maze = maze
    }
}

