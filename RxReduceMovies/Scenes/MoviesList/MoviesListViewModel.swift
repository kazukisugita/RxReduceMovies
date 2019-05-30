
import Foundation
import RxReduce
import RxSwift
import RxCocoa
import Alamofire

class MoviesListViewModel: ViewModel, Injectable {
    
    typealias InjectionContainer = HasStore & HasNetworkService
    var injectionContainer: InjectionContainer

    init(with injectionContainer: InjectionContainer) {
        self.injectionContainer = injectionContainer
    }
    
    func fetchMovieList() -> Driver<MoviesListState> {
        
        // Build an asynchronous action
    
        let loadMovieAction: Observable<Action> = self.injectionContainer.networkService
            .fetch(withRoute: Routes.discoverMovie)
            .asObservable()
            .map { $0.movies.filter { $0.backdropPath != nil }}
            .map { MovieAction.loadMovies(movies: $0) }
            .startWith(MovieAction.startLoadingMovies)
        
        // Dispatch action
        
        return self.injectionContainer
            .store
            .dispatch(action: loadMovieAction) { $0.moviesListState }
            .asDriver(onErrorJustReturn: .empty)
    }
    
    func setAsCheckedMovie(movieID: Int) -> Driver<CheckedMoviesState> {
        
        return self.injectionContainer
            .store
            .dispatch(action: MovieAction.asChecked(movieId: movieID)) { $0.checkedMoviesState }
            .asDriver(onErrorJustReturn: .empty)
    }
}
