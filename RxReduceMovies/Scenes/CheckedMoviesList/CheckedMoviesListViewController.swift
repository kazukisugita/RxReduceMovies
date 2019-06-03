
import UIKit
import RxCocoa
import RxSwift
import Alamofire
import AlamofireImage

class CheckedMoviesListViewController: UIViewController, ViewModelBased {
    
    var viewModel: CheckedMoviesListViewModel!
    
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
    
    private let disposeBag = DisposeBag()
    private let compositeBag = CompositeDisposable()

    private let viewWillAppearSubject = BehaviorSubject<Void>(value: ())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Checked"
        
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
                
        rx.sentMessage(#selector(viewWillAppear(_:)))
            .subscribeOn(MainScheduler.instance)
            .subscribe({ _ in self.fetchCheckedListFromViewModel() })
            .disposed(by: disposeBag)
    }
    
    private func fetchCheckedListFromViewModel() {
        
        let disposable = viewModel.fetchCheckedList()
            .drive(onNext: { [unowned self] state in
                if case let .checked(checkedMovies) = state {
                    self.movies = checkedMovies
                    self.tableView.reloadData()
                }
                self.compositeBag.dispose()
            })
        _ = compositeBag.insert(disposable)
    }
    
}

extension CheckedMoviesListViewController: UITableViewDataSource {
    
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

extension CheckedMoviesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
