//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Mohamed Allam on 25/01/2024.
//

import XCTest
@testable import MoviesApp

final class MoviesAppTests: XCTestCase {
    let movies = [
        Movie(id: 1, title: "Taken", desc: "Taken desc", imageURL: URL(string: "www.google.com")! , releaseYear: "2024", vote_average: 1),
        Movie(id: 2, title: "Sh", desc: "Taken desc", imageURL: URL(string: "www.google.com")! , releaseYear: "2022", vote_average: 2),
        Movie(id: 3, title: "Lord of the rings", desc: "Taken desc", imageURL: URL(string: "www.google.com")! , releaseYear: "2020", vote_average: 3),
        Movie(id: 4, title: "Cell", desc: "Cell", imageURL: URL(string: "www.google.com")! , releaseYear: "2025", vote_average: 4),
        Movie(id: 5, title: "Alpha", desc: "Alpha desc", imageURL: URL(string: "www.google.com")! , releaseYear: "2019", vote_average: 5),
        Movie(id: 6, title: "Beta", desc: "Taken desc", imageURL: URL(string: "www.google.com")! , releaseYear: "2013", vote_average: 2)
    ]
    let usecase = MockMoviesUseCase()
    let coordinator = MockCoordinator()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_list_with_no_movies() {

        let viewModel = MoviesListViewModel(useCase: usecase, coordinator: coordinator)
        XCTAssertEqual(viewModel.movies.isEmpty,  true)
    }
    
    func test_sort_movies_by_first_alphabet() {
        let viewModel = MoviesListViewModel(useCase: usecase, coordinator: coordinator)
        viewModel.movies = movies
        viewModel.sort(options: .alphabet, completion: { })
        XCTAssertEqual(viewModel.movies.first?.title, "Alpha")
    }
    
    func test_sort_movies_by_newest() {

        let viewModel = MoviesListViewModel(useCase: usecase, coordinator: coordinator)
        viewModel.movies = movies
        viewModel.sort(options: .newest, completion: { })
        XCTAssertEqual(viewModel.movies.first?.releaseYear, "2025")
    }
    
    func test_sort_movies_by_most_vote() {
        let viewModel = MoviesListViewModel(useCase: usecase, coordinator: coordinator)
        viewModel.movies = movies
        viewModel.sort(options: .votes, completion: { })
        XCTAssertEqual(viewModel.movies.first?.vote_average, 5)
    }
    
    func test_search_with_empty_string() {
        let searchText = ""
        let viewModel = MoviesListViewModel(useCase: usecase, coordinator: coordinator)
        viewModel.movies = movies
        viewModel.search(text: searchText, completion: {
            
        })
        XCTAssertEqual(viewModel.movies.count, 6)
    }
    
    func test_search_with_exist_data() {
        let searchText = "Taken"
        let viewModel = MoviesListViewModel(useCase: usecase, coordinator: coordinator)
        viewModel.movies = movies
        viewModel.search(text: searchText, completion: {
            
        })
        XCTAssertEqual(viewModel.movies.count, 1)
    }
    
    func test_search_with_exist_data_but_lowercase() {
        let searchText = "taken"
        let viewModel = MoviesListViewModel(useCase: usecase, coordinator: coordinator)
        viewModel.movies = movies
        viewModel.search(text: searchText, completion: {
            
        })
        XCTAssertEqual(viewModel.movies.count, 1)
    }
    func test_search_with_exist_data_but_uppercase() {
        let searchText = "BETA"
        let viewModel = MoviesListViewModel(useCase: usecase, coordinator: coordinator)
        viewModel.movies = movies
        viewModel.search(text: searchText, completion: {
            
        })
        XCTAssertEqual(viewModel.movies.count, 1)
    }
    func test_search_with_empty_spaces() {
        let searchText = " "
        let viewModel = MoviesListViewModel(useCase: usecase, coordinator: coordinator)
        viewModel.movies = movies
        viewModel.search(text: searchText, completion: {
            
        })
        XCTAssertEqual(viewModel.movies.count, 0)
    }

    func test_search_with_title_with_spaces() {
        let searchText = "Lord of the rings"
        let viewModel = MoviesListViewModel(useCase: usecase, coordinator: coordinator)
        viewModel.movies = movies
        viewModel.search(text: searchText, completion: {
            
        })
        XCTAssertEqual(viewModel.movies.count, 1)
    }
}
class MockMoviesUseCase: MoviesListUseCaseProtocol {
    func getMovies(completion: @escaping ([MoviesApp.Movie]) -> Void) {
        completion([])
    }
}

class MockCoordinator: MoviesListCoordinatorProtocol {
    func navigateToDetails(movie: MoviesApp.Movie) {
        
    }
}
