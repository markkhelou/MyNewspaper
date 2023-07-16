
import XCTest
@testable import MyNewspaper

class ArticlesRemoteTests: XCTestCase {
    
    var articlesRemote: ArticlesRemote!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        
        // Create a mock instance of NetworkServiceProtocol
        mockNetworkService = MockNetworkService()
        
        // Initialize ArticlesRemote with the mock network service
        articlesRemote = ArticlesRemote(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        super.tearDown()
        mockNetworkService = nil
        articlesRemote = nil
    }
    
    func testRequestArticles() async throws {
        // Given
        let sampleArticles = ArticlesMocks.articles
        
        // When
        mockNetworkService.requestResult = .success(sampleArticles)
        let returnedArticles = try await articlesRemote.requestArticles()
        XCTAssertEqual(mockNetworkService.url, ArticlesEndPoint.articles)
        
        // Then
        XCTAssertEqual(returnedArticles.count, sampleArticles.count)
        XCTAssertEqual(returnedArticles[0].id, sampleArticles[0].id)
        XCTAssertEqual(returnedArticles[1].id, sampleArticles[1].id)
        XCTAssertEqual(returnedArticles[2].id, sampleArticles[2].id)
    }
    
    func testRequestArticlesWithError() async throws {
        // Given
        let expectedError = NetworkError.authenticationError
        // When
        mockNetworkService.requestResult = .failure(NetworkError.authenticationError)
        
        var caughtError: Error?
        do {
            _ = try await articlesRemote.requestArticles()
        } catch {
            caughtError = error
        }

        // Then
        XCTAssertEqual(mockNetworkService.url, ArticlesEndPoint.articles)
        XCTAssertNotNil(caughtError)
        XCTAssertEqual((caughtError as? NetworkError)?.localizedDescription, expectedError.localizedDescription)
    }

    func testGetArticle() async throws {
        // Given
        let sampleArticleDetails = ArticlesMocks.articleDetails
        
        // When
        mockNetworkService.requestResult = .success(sampleArticleDetails)
        let returnedArticleDetails = try await articlesRemote.getArticle(id: 1)

        // Then
        XCTAssertEqual(mockNetworkService.url, ArticlesEndPoint.getArticle(id: 1))
        // We can do this for all the field
        XCTAssertEqual(returnedArticleDetails.contentHTML, sampleArticleDetails.contentHTML)
        XCTAssertEqual(returnedArticleDetails.id, sampleArticleDetails.id)
        XCTAssertEqual(returnedArticleDetails.authorName, sampleArticleDetails.authorName)
        XCTAssertEqual(returnedArticleDetails.title1, sampleArticleDetails.title1)
        XCTAssertEqual(returnedArticleDetails.title2, sampleArticleDetails.title2)
        XCTAssertEqual(returnedArticleDetails.keyword1, sampleArticleDetails.keyword1)
    }
    
    func testGetArticleWithError() async throws {
        // Given
        let expectedError = NetworkError.authenticationError

        // When
        mockNetworkService.requestResult = .failure(NetworkError.authenticationError)
        var caughtError: Error?
        do {
            _ = try await articlesRemote.getArticle(id: 1)
        } catch {
            caughtError = error
        }

        // Then
        XCTAssertEqual(mockNetworkService.url, ArticlesEndPoint.getArticle(id: 1))
        XCTAssertNotNil(caughtError)
        XCTAssertEqual((caughtError as? NetworkError)?.localizedDescription, expectedError.localizedDescription)
    }
}
