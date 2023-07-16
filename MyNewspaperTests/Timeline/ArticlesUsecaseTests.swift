
import Foundation
import XCTest
@testable import MyNewspaper

class ArticlesUsecaseTests: XCTestCase {
    
    var articlesUsecase: ArticlesUsecase!
    var repositoryMock: ArticlesRepositoryMock!
    
    override func setUp() {
        super.setUp()
        
        repositoryMock = ArticlesRepositoryMock()
        articlesUsecase = ArticlesUsecase(repository: repositoryMock)
    }
    
    override func tearDown() {
        super.tearDown()
        repositoryMock = nil
        articlesUsecase = nil
    }
    
    func testRequestArticles() async throws {
        // Given
        let sampleArticles = ArticlesMocks.articles
        
        // When
        repositoryMock.requestResult = .success(sampleArticles)
        
        // Than
        let returnedArticles = try await articlesUsecase.requestArticles()
        XCTAssertEqual(returnedArticles.count, sampleArticles.count)
        XCTAssertEqual(returnedArticles[0].id, sampleArticles[0].id)
        XCTAssertEqual(returnedArticles[1].id, sampleArticles[1].id)
        XCTAssertEqual(returnedArticles[2].id, sampleArticles[2].id)
    }
    
    func testRequestArticlesWithError() async throws {
        // Given
        let expectedError = NetworkError.authenticationError
        
        // When
        repositoryMock.requestResult = .failure(expectedError)
        var caughtError: Error?
        do {
            _ = try await articlesUsecase.requestArticles()
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
        repositoryMock.requestResult = .success(sampleArticleDetails)
        let returnedArticleDetails = try await articlesUsecase.getArticle(id: 3)
        
        // Then
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
        repositoryMock.requestResult = .failure(expectedError)
        var caughtError: Error?
        do {
            _ = try await articlesUsecase.getArticle(id: 3)
        } catch {
            caughtError = error
        }
        
        // Then
        XCTAssertNotNil(caughtError)
        XCTAssertEqual((caughtError as? NetworkError)?.localizedDescription, expectedError.localizedDescription)
    }
}
