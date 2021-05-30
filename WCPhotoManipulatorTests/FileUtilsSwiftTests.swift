//
//  FileUtilsSwiftTests.swift
//  WCPhotoManipulatorTests
//
//  Created by Woraphot Chokratanasombat on 1/8/20.
//  Copyright © 2020 Woraphot Chokratanasombat. All rights reserved.
//

import XCTest
@testable import WCPhotoManipulator

class FileUtilsSwiftTests: XCTestCase {
    var prefix: String! = nil
    var path: String! = nil
    var file: String! = nil
    var image: UIImage! = nil
    var data: Data! = nil
    var url: URL! = nil
    var fileManager: FileManager! = nil
    
    override func setUpWithError() throws {
        fileManager = FileManager.default
    }

    override func tearDownWithError() throws {
        prefix = nil
        path = nil
        file = nil
        image = nil
        data = nil
        url = nil
        fileManager = nil
    }

    ////////////////////////////
    /// createTempFile
    ///////////////////////////
    func testCeil_ShouldReturnValueCorrectly() throws {
        prefix = "TEST_"
        path = FileUtils.createTempFile(prefix, mimeType:MimeUtils.PNG)
        file = URL(fileURLWithPath: path).lastPathComponent
        
        XCTAssertNotNil(path)
        XCTAssertTrue(path.hasPrefix(FileUtils.cachePath()))
        XCTAssertTrue(file.hasPrefix(prefix))
        XCTAssertTrue(file.hasSuffix(".png"))
    }
    
    func testCreateTempFile_WhenJPEG_ShouldReturnFileWithPrefix() throws {
        prefix = "JPG_"
        path = FileUtils.createTempFile(prefix, mimeType:MimeUtils.JPEG)
        file = URL(fileURLWithPath: path).lastPathComponent
        
        XCTAssertNotNil(path)
        XCTAssertTrue(path.hasPrefix(FileUtils.cachePath()))
        XCTAssertTrue(file.hasPrefix(prefix))
        XCTAssertTrue(file.hasSuffix(".jpg"))
    }

    ////////////////////////////
    /// imageToData
    ///////////////////////////
    func testImageToData_WhenOuptutJpeg_ShouldReturnJpeg() throws {
        image = UIImage.init(namedTest: "overlay.png")
        data = FileUtils.imageToData(image, mimeType: MimeUtils.JPEG, quality: 100)
        
        XCTAssertNotNil(data)
        XCTAssertEqual((data as NSData).mimeType(), MimeUtils.JPEG)
    }
    
    func testImageToData_WhenOuptutPNG_ShouldReturnPng() throws {
        image = UIImage.init(namedTest: "overlay.png")
        data = FileUtils.imageToData(image, mimeType: MimeUtils.PNG, quality: 100)
        
        XCTAssertNotNil(data)
        XCTAssertEqual((data as NSData).mimeType(), MimeUtils.PNG)
    }

    ////////////////////////////
    /// imageFromUrl
    ///////////////////////////
    func testImageFromUrl_WhenLocalFile_ShouldHaveData() throws {
        url = Bundle(for: type(of: self)).url(forResource: "overlay", withExtension: "png")
        
        image = FileUtils.imageFromUrl(url)
        XCTAssertNotNil(image)
    }
    
    func testImageFromUrl_WhenUrl_ShouldHaveData() throws {
        url = URL.init(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/200px-React-icon.svg.png")
        
        image = FileUtils.imageFromUrl(url)
        XCTAssertNotNil(image)
    }
    
    func testImageFromUrl_WhenUrlNotValid_ShouldBeNil() throws {
        url = URL.init(string: "https://invalidhost.notexist/invalid.png")
        
        image = FileUtils.imageFromUrl(url)
        XCTAssertNil(image)
    }

    ////////////////////////////
    /// saveImageFile
    ///////////////////////////
    func testSaveImageFile_WhenPNG_ShouldSavePNG() throws {
        path = FileUtils.createTempFile("PNG_", mimeType:MimeUtils.PNG)
        image = UIImage.init(namedTest: "overlay.png")
        
        XCTAssertFalse(fileManager.fileExists(atPath: path))
        
        FileUtils.saveImageFile(image, mimeType:MimeUtils.PNG, quality:100, file:path)
        
        XCTAssertTrue(fileManager.fileExists(atPath: path))
        
        let attributes = try! fileManager.attributesOfItem(atPath: path)
        XCTAssertNotNil(attributes)
        XCTAssertTrue(attributes[.size] as! UInt64 > 0)
    }
    
    func testSaveImageFile_WhenJPEG_ShouldSaveJEPG() throws {
        path = FileUtils.createTempFile("JPEG_", mimeType:MimeUtils.JPEG)
        image = UIImage.init(namedTest: "overlay.png")
        
        XCTAssertFalse(fileManager.fileExists(atPath: path))
        
        FileUtils.saveImageFile(image, mimeType:MimeUtils.JPEG, quality:100, file:path)
        
        XCTAssertTrue(fileManager.fileExists(atPath: path))
        
        let attributes = try! fileManager.attributesOfItem(atPath: path)
        XCTAssertNotNil(attributes)
        XCTAssertTrue(attributes[.size] as! UInt64 > 0)
    }

    ////////////////////////////
    /// cleanDirectory
    ///////////////////////////
    func testCleanDirectory() throws {
        prefix = "PREFIX_"
        data = Data()
        path = NSTemporaryDirectory()
        
        fileManager.createFile(atPath: (path as NSString).appendingPathComponent("\(prefix!)bee1.png"), contents:data, attributes:[:])
        fileManager.createFile(atPath: (path as NSString).appendingPathComponent("\(prefix!)bee2.png"), contents:data, attributes:[:])
        
        var files = FileUtils.filesIn(path, withPrefix: prefix)
        XCTAssertEqual(files.count, 2)
        
        FileUtils.cleanDirectory(path, prefix: prefix)
        
        files = FileUtils.filesIn(path, withPrefix: prefix)
        XCTAssertEqual(files.count, 0)
    }

    ////////////////////////////
    /// filesIn
    ///////////////////////////
    func testFilesIn_WithInvalidPath_ShouldReturnEmptyArray() throws {
        prefix = "PREFIX_"
        path = "invalid path"
        
        let files = FileUtils.filesIn(path, withPrefix: prefix)
        XCTAssertEqual(files.count, 0)
    }
}
