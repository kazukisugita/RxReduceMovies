
import UIKit
import SnapKit

class MoviesListViewController: UIViewController, ViewModelBased {
    
    var viewModel: MoviesListViewModel!

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.register(cellType: MovieListViewCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayouts()
    }
    
    private func configureLayouts() {
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
}

extension MoviesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MovieListViewCell = tableView.dequeueReusableCell(for: indexPath)
        return cell
    }
}
