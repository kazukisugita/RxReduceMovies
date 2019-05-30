
import Foundation
import RxReduce

struct AppLenses {
    
    static let movieListLens = Lens<AppState, MoviesListState>(
        get: { $0.moviesListState },
        set: { (appState, moviesListState) -> AppState in
            var mutableState = appState
            mutableState.moviesListState = moviesListState
            return mutableState
        }
    )
    
    static let movieDetailLens = Lens<AppState, MovieDetailState>(
        get: { $0.movieDetailState },
        set: { (appState, movieDetailState) -> AppState in
            var mutableState = appState
            mutableState.movieDetailState = movieDetailState
            return mutableState
        }
    )
    
    static let checkedMoviesLens = Lens<AppState, CheckedMoviesState>(
        get: { $0.checkedMoviesState },
        set: { (appState, checkedMoviesState) -> AppState in
            var mutableState = appState
            mutableState.checkedMoviesState = checkedMoviesState
            return mutableState
        }
    )
}
