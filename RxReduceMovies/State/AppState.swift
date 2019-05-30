
import Foundation
import RxReduce

struct AppState: Equatable {
    var moviesListState: MoviesListState
    var movieDetailState: MovieDetailState
    var checkedMoviesState: CheckedMoviesState
}

enum MoviesListState: Equatable {
    case empty
    case loading
    case loaded
}

enum MovieDetailState: Equatable {
    case empty
    case loaded
}

enum CheckedMoviesState: Equatable {
    case empty
    case checked
}
