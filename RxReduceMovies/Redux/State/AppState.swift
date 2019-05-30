
import Foundation
import RxReduce

struct AppState: Equatable {
    var moviesListState: MoviesListState
//    var movieDetailState: MovieDetailState
//    var checkedMoviesState: CheckedMoviesState
}

enum MoviesListState: Equatable {
    case empty
    case loading
    case loaded([DiscoverMovieModel])
}

enum MovieDetailState: Equatable {
    case empty
    case loaded(DiscoverMovieModel)
}

enum CheckedMoviesState: Equatable {
    case empty
    case checked
}
