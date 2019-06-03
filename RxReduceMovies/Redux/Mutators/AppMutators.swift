
import Foundation
import RxReduce

struct AppMutators {
    
    static let movieListMutator = Mutator<AppState, MoviesListState>(
        lens: AppLenses.movieListLens,
        reducer: AppReducers.movieListReducer
    )
    
    static let movieDetailMutator = Mutator<AppState, MovieDetailState>(
        lens: AppLenses.movieDetailLens,
        reducer: AppReducers.movieDetailReducer
    )
    
    static let checkedMoviesMutator = Mutator<AppState, CheckedMoviesState>(
        lens: AppLenses.checkedMoviesLens,
        reducer: AppReducers.checkedMoviesReducer
    )
}
