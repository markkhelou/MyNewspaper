
import Foundation
import XCTest
@testable import MyNewspaper

class ArticlesRepositoryTests: XCTestCase {
    
    var articlesRepository: ArticlesRepository!
    var remoteMock: ArticlesRemoteMock!
    
    override func setUp() {
        super.setUp()
        
        // Create a mock instance of ArticlesRemoteProtocol
        remoteMock = ArticlesRemoteMock()
        
        articlesRepository = ArticlesRepository(remote: remoteMock)
    }
    
    override func tearDown() {
        super.tearDown()
        remoteMock = nil
        articlesRepository = nil
    }
    
    func testRequestArticles() async throws {
        // Given
        let sampleArticles = ArticlesMocks.articles
        
        // When
        remoteMock.requestResult = .success(sampleArticles)
        let returnedArticles = try await articlesRepository.requestArticles()

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
        remoteMock.requestResult = .failure(expectedError)
        
        var caughtError: Error?
        do {
            _ = try await articlesRepository.requestArticles()
        } catch {
            caughtError = error
        }
        
        // Then
        XCTAssertNotNil(caughtError)
        XCTAssertEqual((caughtError as? NetworkError)?.localizedDescription, expectedError.localizedDescription)
    }
    
    func testGetArticle() async throws {
        // Given
        let sampleArticleDetails = ArticlesMocks.articleDetails

        // When
        remoteMock.requestResult = .success(sampleArticleDetails)
        let returnedArticleDetails = try await articlesRepository.getArticle(id: 3)
        
        // Than
        XCTAssertEqual(returnedArticleDetails.contentHTML, sampleArticleDetails.contentHTML)
        XCTAssertEqual(returnedArticleDetails.id, sampleArticleDetails.id)
        XCTAssertEqual(returnedArticleDetails.authorName, sampleArticleDetails.authorName)
        XCTAssertEqual(returnedArticleDetails.title1, sampleArticleDetails.title1)
        XCTAssertEqual(returnedArticleDetails.title2, sampleArticleDetails.title2)
        XCTAssertEqual(returnedArticleDetails.keyword1, sampleArticleDetails.keyword1)
    }
    
    func testGetArticleWithError() async throws {
        // Given
        let expectedError = NetworkError.requestFailed
        // When
        remoteMock.requestResult = .failure(expectedError)
        var caughtError: Error?
        do {
            _ = try await articlesRepository.getArticle(id: 3)
        } catch {
            caughtError = error
        }
        
        // Then
        XCTAssertNotNil(caughtError)
        XCTAssertEqual((caughtError as? NetworkError)?.localizedDescription, expectedError.localizedDescription)
    }
}
