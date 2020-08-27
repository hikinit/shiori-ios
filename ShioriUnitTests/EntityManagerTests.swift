//
//  LibraryTests.swift
//  ShioriUnitTests
//
//  Created by hikinit on 21/08/20.
//

import XCTest

class EntityManagerTests: XCTestCase {
  var sut: EntityManager<Series>!
  var coreDataStack: CoreDataStack!

  override func setUp() {
    coreDataStack = TestCoreDataStack()
    sut = EntityManager(
      coreDataStack: coreDataStack,
      context: coreDataStack.context
    )
  }

  override func tearDown() {
    coreDataStack = nil
    sut = nil
  }

  func stubMaker(context: NSManagedObjectContext) ->  Series {
    return Series(
      context: context,
      title: "Overgeared",
      kind: .webnovel,
      status: .onhold,
      website: "https://example.com"
    )
  }

  func testGetAllSeries() {
    var allSeries = sut.getAll()
    XCTAssertEqual(allSeries.count, 0)

    let newSeries = sut.add(stubMaker)

    allSeries = sut.getAll()

    XCTAssertEqual(allSeries.count, 1)
    XCTAssertEqual(allSeries.first, newSeries)
  }

  func testAddSeries() {
    let websiteUrlString = "https://example.com"
    let websiteUrl = URL(string: websiteUrlString)

    let newSeries = sut.add(stubMaker)

    XCTAssertEqual(newSeries.title, "Overgeared")
    XCTAssertEqual(newSeries.kind, "Web Novel")
    XCTAssertEqual(newSeries.status, "onhold")
    XCTAssertNotNil(newSeries.id, "Id should not be nil")
    XCTAssertEqual(newSeries.website, websiteUrl)

    let fetchedSeries = sut.getAll()
    XCTAssertEqual(fetchedSeries.first, newSeries)
  }

  func testDeleteSeries() {
    let newSeries = sut.add(stubMaker)
    var allSeries = sut.getAll()
    XCTAssertEqual(allSeries.count, 1)

    let deleted = sut.delete(newSeries)
    allSeries = sut.getAll()

    XCTAssertEqual(allSeries.count, 0)
    XCTAssertTrue(deleted)
  }

  func testUpdateSeries() {
    let newSeries = sut.add(stubMaker)

    newSeries.title = "Overgearedd"

    XCTAssertTrue(coreDataStack.context.hasChanges)

    sut.update(newSeries)

    XCTAssertFalse(coreDataStack.context.hasChanges)
  }

  func testAddSeriesWithChapter() {
    let chapterManager = EntityManager<Bookmark>(
      coreDataStack: coreDataStack,
      context: coreDataStack.context
    )

    let newSeries = sut.add(stubMaker)

    for i in 1...3 {
      let chapter = chapterManager.add { Bookmark(context: $0, number: Float(i), kind: .chapter, name: nil) }
      newSeries.addToBookmarks(chapter)
    }

    let bookmarks = newSeries.bookmarks?.array as? [Bookmark]

    XCTAssertEqual(bookmarks?.count, 3)
    XCTAssertEqual(bookmarks?.first?.number, 1)
  }
}
