
import UIKit
import SnapKit
import RxCocoa
import RxSwift
import SVProgressHUD
import Alamofire
import AlamofireImage

class MoviesListViewController: UIViewController, ViewModelBased {
    
    private let disposeBag = DisposeBag()
    
    var viewModel: MoviesListViewModel!
    private var movies = [DiscoverMovieModel]()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: MovieListViewCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movies"
        
        configureLayouts()
        configureSubscribes()
    }
    
    private func configureLayouts() {
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func configureSubscribes() {
        
        viewModel.fetchMovieList()
            .do(onNext: { [unowned self] state in
                switch state {
                case .loaded:
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        SVProgressHUD.dismiss()
                    }
                case .loading:
                    SVProgressHUD.show()
                default:
                    SVProgressHUD.dismiss()
                }
            })
            .drive(onNext: { [unowned self] state in
                self.render(by: state)
            })
            .disposed(by: disposeBag)
    }
    
}

extension MoviesListViewController {
    
    // MARK: Render
    
    private func render(by movieListState: MoviesListState) {
        
        switch movieListState {
        case .empty:
            movies.removeAll()
            
        case .loading:
            movies.removeAll()
            
        case .loaded(let movies):
            self.movies = movies
            tableView.reloadData()
        }
    }
    
}

extension MoviesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MovieListViewCell = tableView.dequeueReusableCell(for: indexPath)
        let movie = self.movies[indexPath.row]
        cell.title.text = movie.name
        cell.overview.text = movie.overview
        let posterPath = "https://image.tmdb.org/t/p/w154"+movie.posterPath
        Alamofire.request(posterPath).responseImage { (response) in
            guard response.request?.url?.absoluteString == posterPath else { return }
            guard let data = response.data else { return }
            
            cell.poster.image = UIImage(data: data)
        }

        return cell
    }
}

extension MoviesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movie = self.movies[indexPath.row]
        
        viewModel.setAsCheckedMovie(movieID: movie.id)
            .drive()
            .disposed(by: disposeBag)

        let movieDetailViewModel = MovieDetailViewModel(with: self.viewModel.injectionContainer, withMovieId: movie.id)
        let movieDetailViewController = MovieDetailViewController.instanceFromSB(with: movieDetailViewModel)
        UIApplication.shared.keyWindow?.rootViewController?.present(movieDetailViewController, animated: true)
    }
}
