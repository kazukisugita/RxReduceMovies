
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
}
