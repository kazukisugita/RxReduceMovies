
import Foundation
import RxReduce

enum MovieAction: Action {
    case startLoadingMovies
    case loadMovies(movies: [DiscoverMovieModel])
    case loadMovie(movieId: Int)
}
