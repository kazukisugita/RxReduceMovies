
import Foundation
import RxReduce

struct AppMutators {
    
    static let movieListMutator = Mutator<AppState, MoviesListState>(
        lens: AppLenses.movieListLens,
        reducer: movieListReducer
    )
    
    static let movieDetailMutator = Mutator<AppState, MovieDetailState>(
        lens: AppLenses.movieDetailLens,
        reducer: movieDetailReducer
    )
    
    static let checkedMoviesMutator = Mutator<AppState, CheckedMoviesState>(
        lens: AppLenses.checkedMoviesLens,
        reducer: checkedMoviesReducer
    )
}
