
import Foundation
import XCTest
@testable import MyNewspaper

class TimelineViewModelTests: XCTestCase {

    var viewModel: TimelineViewModel!
    var mockArticlesUsecase: ArticlesUsecaseMock!
    var mockUsersUsecase: UsersUsecaseMock!

    override func setUp() {
        super.setUp()
        mockArticlesUsecase = ArticlesUsecaseMock()
        mockUsersUsecase = UsersUsecaseMock()
        viewModel = TimelineViewModel(usecase: mockArticlesUsecase, userUsecase: mockUsersUsecase)
    }

    override func tearDown() {
        viewModel = nil
        mockArticlesUsecase = nil
        mockUsersUsecase = nil
        super.tearDown()
    }

    func testRequestArticlesSuccess() async {
        // Given
        mockArticlesUsecase.requestResult = .success(ArticlesMocks.articles)
        mockUsersUsecase.requestResult = .success(UsersMocks.user)
        // When
        await viewModel.requestArticles()

        // Then
        XCTAssertEqual(viewModel.articles.count, 3)
        XCTAssertEqual(viewModel.articles[0].id, 1)
        XCTAssertEqual(viewModel.articles[0].title1, "Article 1")
        // Check if the showLoading flag is set to false
        XCTAssertFalse(viewModel.showLoading)

        // Check if the error is nil
        XCTAssertNil(viewModel.error)
    }
    
    func testRequestAnyApiFailed() async {
        // Given
        mockArticlesUsecase.requestResult = .success(ArticlesMocks.articles)
        mockUsersUsecase.requestResult = .failure(NetworkError.requestFailed)
        // When
        await viewModel.requestArticles()
        // Then
        // Check if the articles array is empty
        XCTAssertTrue(viewModel.articles.isEmpty)

        // Check if the showLoading flag is set to false
        XCTAssertFalse(viewModel.showLoading)

        // Check if the error is set correctly
        XCTAssertEqual(viewModel.error?.localizedDescription, NetworkError.requestFailed.localizedDescription)
    }

    func testRequestArticlesFailure() async {
        // Given
        mockArticlesUsecase.requestResult = .failure(NetworkError.requestFailed)
        mockUsersUsecase.requestResult = .failure(NetworkError.requestFailed)

        // When
        await viewModel.requestArticles()

        // Check if the articles array is empty
        XCTAssertTrue(viewModel.articles.isEmpty)

        // Check if the showLoading flag is set to false
        XCTAssertFalse(viewModel.showLoading)

        // Check if the error is set correctly
        XCTAssertEqual(viewModel.error?.localizedDescription, NetworkError.requestFailed.localizedDescription)
    }
    
    func testAuthenticationFailure() async {
        // Given
        mockArticlesUsecase.requestResult = .failure(NetworkError.authenticationError)
        mockUsersUsecase.requestResult = .failure(NetworkError.authenticationError)

        // When
        await viewModel.requestArticles()

        // than
        XCTAssertFalse(viewModel.isAuthenticated)
        XCTAssertNil(viewModel.error)
    }

    func testGetArticleAccess() {
        let subscriptions: [Subscription] = [.sports, .full]

        // Test for a free article
        XCTAssertEqual(viewModel.getArticleAcess(subscriptionType: .free, userSubscriptions: subscriptions), .free)

        // Test for a sports article
        XCTAssertEqual(viewModel.getArticleAcess(subscriptionType: .sports, userSubscriptions: subscriptions), .subscripted)

        // Test for an unknown subscription type
        XCTAssertEqual(viewModel.getArticleAcess(subscriptionType: .unknown, userSubscriptions: subscriptions), .notSubcripted)

        // Test for a full subscription type
        XCTAssertEqual(viewModel.getArticleAcess(subscriptionType: .full,
                                                 userSubscriptions: subscriptions), .subscripted)
    }
    
    func testGetArticleAccessForSport() {
        let subscriptions: [Subscription] = [.sports]

        // Test for a sports article
        XCTAssertEqual(viewModel.getArticleAcess(subscriptionType: .sports, userSubscriptions: subscriptions), .subscripted)

        // Test for a free article
        XCTAssertEqual(viewModel.getArticleAcess(subscriptionType: .free, userSubscriptions: subscriptions), .free)

        // Test for an full type
        XCTAssertEqual(viewModel.getArticleAcess(subscriptionType: .full, userSubscriptions: subscriptions), .notSubcripted)

        // Test for a unknown subscription type
        XCTAssertEqual(viewModel.getArticleAcess(subscriptionType: .unknown,
                                                 userSubscriptions: subscriptions), .notSubcripted)
    }
    
    func testGetArticleAccessForFull() {
        let subscriptions: [Subscription] = [.full]

        // Test for a full article
        XCTAssertEqual(viewModel.getArticleAcess(subscriptionType: .full, userSubscriptions: subscriptions), .subscripted)

        // Test for a free article
        XCTAssertEqual(viewModel.getArticleAcess(subscriptionType: .free, userSubscriptions: subscriptions), .free)

        // Test for an sports subscription type
        XCTAssertEqual(viewModel.getArticleAcess(subscriptionType: .sports, userSubscriptions: subscriptions), .notSubcripted)

        // Test for a unknown subscription type
        XCTAssertEqual(viewModel.getArticleAcess(subscriptionType: .unknown,
                                                 userSubscriptions: subscriptions), .notSubcripted)
    }
    
    
    func testGetArticleAccessForNoSubcription() {
        let subscriptions: [Subscription] = []

        // Test for a full article
        XCTAssertEqual(viewModel.getArticleAcess(subscriptionType: .full, userSubscriptions: subscriptions), .notSubcripted)

        // Test for a free article
        XCTAssertEqual(viewModel.getArticleAcess(subscriptionType: .free, userSubscriptions: subscriptions), .free)

        // Test for an sports subscription type
        XCTAssertEqual(viewModel.getArticleAcess(subscriptionType: .sports, userSubscriptions: subscriptions), .notSubcripted)

        // Test for a unknown subscription type
        XCTAssertEqual(viewModel.getArticleAcess(subscriptionType: .unknown,
                                                 userSubscriptions: subscriptions), .notSubcripted)
    }
}
