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
    
    func testImageFromUrl_WhenBase64_ShouldBeEncoded() throws {
        let url = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQQAAADwCAYAAADmfBqxAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAAB3RJTUUH6AYTBgw2nK2YuQAAQstJREFUeNrtXXmcFMX1/77qnZmeXQ4BFeJ9QATxJooaEwWvxGg0RtawM7uKJpBE0ZifCigzFLOAV4wJagxEgu7OLMniHe8LNRpFxRvxQOOBCBJAYHen5+h6vz9mNRo5tnqO7Znt7+eTTxCmuqtevfrWe9Wv3gM8ePDgwYMHDx48ePDgwYMHDx48ePDgwYMHDx48ePDgwYMHDx4KA/JEoIc+srV/SmW/K2APZdAQMIaAsD2AXgD6EiAYUADWA8iA6RMQPgTwIUG9Ywvj5TTeeQdSKk+aW4GUwp/dax+DxMFMNATEe0DRbiDeGYAPQL+vyHoDgDYAa0D8LinxrjL4LdOiZzZcGVrvCdMjhIIiGGk5Qgk+A6xGEehAACLPR24C8AoIT4LoEWtl27OYOyHTswmg1W/a2SNA6ngA3wdwcCfJ5gPFwCsAFglWC5ONDYs9bfYIwRF6TWndIVuV+gWIGgDsU+TXtRHjcQYWWgbugQxv7BFCntTa1/SnTiXCGQwaDaCmyG98C0BTVcZ/c9sVtWs8LfcIYZvoPeXWARm/cTEY5xdgh3ICi4EHBNCcFDv/A3JUtqIEPH6OLzio+scA1TP4BwAFuqEXbQCu92XsazddcdZaT+s9QvgmxrQawaGpC5lIAujtkl6tBGgeCfvmpGz4qJzFa8oFe4DVL8A8DsC3XNKtTcQsk28F/oiFtba3CDxCAAD4Iy3DBal5AEa6tIuKGPfDoMakDD1fTrL1RZoPNIj+D8BYAFUu7eZzSuDctAy/6RFCD4cZiZ8D4j91k+mqD8bDMPgKS9Y/4Wq5RhOjwHwZCMeVhyZwCsCvrFj9fI8QeqiLYA5LzQRoUpmO4BkSYnJS1j3tpk4FZeIw2BxhwsnluSJ4rkW7nFdxZzceIWwFstUfVKnbGHRKmY+EmXEnmC9Lzah/u1vdrqlNwwwhrmDgx+WuVwTcnRT+WsjatEcIlY7xc3yBgb1aifi0ChpVmolnp4gaS/7JUs7fLqCqogQ6H7mAoYoAM+5IGTuf2dMshZ5FCFIKkwcvAKO2Qke4GuApVix8C0BcdFnae58DopkAdqxQeS6wxPJwT4oqFT2JD0y1d7RIZMDIhSp/DOB9ACsZ+LwbhjgQoL+a0cQTganNRQum8k9tGmaqvZ8E0V+6gww6ZbuyU9YrOmVfDIw17cFTPQuhAhGItpxCUHcViAQ/AtHDpHiRbYg30huq3sV1tclv/Oqi1qC/b3Z3Au9FNg5hYAQRH5FbuEWHBaaZ1uq2qwoWFi1b/aadngziy0r0VWY1Mz1LxC+yoJcZ9H56Q9WHm5W1nFPtR+/BQvH+gBoF0AkAdi1AHxQLOiUlQ/d7hFAhCMqm3ZQSrxKwXT6KAWAhBP/ZwntPOTcjmfxywf6GUsd3HsAdVUxLjcCv2cKoT8u61/J5Tmc8QRzAfkWcKgXwP4lxj20Yj6bl2Ncduz5SChN7HQMlfgngp/nImIHPhW0ckJw59mOPECrBVYjG7wfwwzxs1IeVof4vLRveKHTfquWCnWxbnQFSZxPo4CIZ2SkCIknx3rXaRCalCNqDL2ZCIwB/kaZoCQO3Glm+rWNW/acFd3Fk037CFteCcEIeC+W+ZCx8skcIZU8GiXqAmxw2bwPTRKsxdEsp+lodiR+qiCcAVAcgWIRXPAWbGqyZoQ+7JLvLE7vD4GYA3ytCX9oBtAih5nbIhhdLowvN4wC6Hg4vUREjlGwMt3iEUK6Y1NrXDKSXA9jeQesPlRA/ztfUdoJeU1p3yPrTF4DxawD9C/z49Qo0Lh0L3b1VNysa/wkD8wD0K/D714Jwo4/E9Ztk3X9KLdsamTjIVnw3gN0cNP/MslKDcfW5mzxCKE/rIAZwxEHT98k2jul2n1G29gqqzHkMvrTAxMBM+GOK/JO+EXwzcXYg2K//NQycX2D9WEvgq5Id/Cf8rqG9O8UalE27sRJPAtjDgfs4zWoMxzxCKDP0kk07ZpVYDv2bi5/CpiO6alaXzNIx0xeD8RsU9kr2C7BpzBdjNac27QkhFgIYUcB3bAL495ag37spz0PnWJ+F/hefjb6MvVelXpuuWEIIRONXE3CJZrMMCTHabfcDvjxjuKz5W6qKrgDQULi54zWAOBMCBhT/DcCAAnVXAXSrkaUp7bPqVrvSgpSJ70Pxo9CPsLzCioUv8wihXCDnVJuqZoWu/0ugyclY6Cq3Dy8YaRrJJGYDOKxApKBABHDBPn8+JxgXdDSGX3C/WxmfAmCWZrP/WCKzK+Q4q9KWTkVGKpp2rzD0D8OWJMVO15bD+JKNDYstsfwIBi7ImeSOieALKhQFIoONzDjPEsu/Ww5kAACW2PmazryLOtjeVFVjPQuhTBCMNr/KoAN0VoZgjCwXJf7aWC9fsCuE/afuvm5MwN2w7fOSM8/6pOxkGGk5gkn9S3cDsWLh73iE4HL4I/H9BUHrUyGDbk/FQmeUNwkmxjB4Dgr/mXCbVgGYLrEaQ3PLWn6R+N1M+LHWIYnA8ErLslRxLoMQ2peXmIUty33cyVhoIWw6GIwnSvjaRSTU/uVOBgAgDJqm3UbRGO8Mwe1g0iMExmPFCEnuFn94ZuhDy1h+LDEmASjmPf4MMSZZYvlx5Z789Qu0y9ArAD+pqWxnei6Dm90F2TJUKLVMa0oFn5qS9fdU2sQGZfORrGgBnEXkbQ0fEouxyca6ZytOZtHmnzLoNj39sfdJybPe8SwEN7KbUsdrNvlPamXHA6hAJGX9v3wZ+xBi3Fsw+TLu8Qv/IZVIBgCQFIF/QDe3gqo61nMZ3DoY1s7we2cll1DbdEXDOhD+XajnKSHe3yjHVG6tRFmbBuFOzVYeIbgSY1oNJhyjd3xAt1escoMpOC1xAwMT83rK1ywE9ZvgtMQfAK7YCFdmaLkMBB5VSfKoGELwD80OBdBHo4mV2uR7qlLJwIwmbuLcbcn83IRvLpgLgtHE9ZVKCinR/mRnjYauon9ANg3xCMFtAyGlFyTCeHqzqbgqxDIAMKFobwDOM6OJOZCy8r5SyQkdYNI6IxFKjPAIwWUgwiGaar2o8pRZCnNa4uZCWAZdwC9M3vumirQUiJ7Q+bkCeYTgQt/vIL19VCypODLgwfPAOKeExsh4c1rL3EqzFBhKK4MTcbFS33mEkA++rfNjX8b3UsWMfEyrYarBfwXj7G5g4p+basjNlUQKVVlDL6UbsXeG4K7dsbUX9BJdrGi7onZNxVgGw9LzAZyVx5aYAZDH51ceZ6ohN1eK+9CZv2GVRpOdcVFr0CMEl6AGmcHQi7p8t1IYPaD2/h2A+jwesZ4MMRqCjsuvuAyPC0QTV6FiwMt11pG/V3YvjxBcAqV4T80myyth3MFoYhKBLsrjEWsFG8cmZd3Tlgw9ZQh1PPKogkTAJcFI828rgg+Iluv93N7DIwS3EAJ4Rz3FpffKfcxmJHE2g6/I4xH/MQQd19E49uUv/qJDNrwoBB8HYJ3jfZXod7nU9+WuVHo6QkwDPUJwC5lDDNJzmbGyrN2EaPOPQPwXOL6cxmuUEMfmbvh9HR2y/iVD0LEA/uN4OsDzAtH4D8tcqT7V/L1HCO6ZO95BkxA+K1s3QSYOI9DfAVQ5fMRniunYrdWbaJehV2zm4/IgBR8BtwUj8e+W7QmC4NV6OuhZCO6ZPGKtTMGGUGX5hcEv4/uy4vvhsPIQgNWKxeh0Y/j1bf0w01j/qhLi2FxWZkeoZsLd/qlNw8pR1oYNLUJgqO09QnCLhcB6C0Shal25jTEo47sIhQfhPE36KqXUqHRj3dKuNkjLuteU4NFwblENEEI8GJTxXcpN3rbBWoerzKLGIwS3WAiak1GFTEdZDVDO345zZLCrYzIQYlR6RsMy3YZp2fCGYjE6D0thN1Z4EJNa+5aVhZCGVnUpAld7hOAeE0FrMtqQbCsfMpAiaPuaAQx3+ISNQvCP0rLuLaddSDfWLRWCT4LzlO/DzUD67xjTapSL2DvsQEcxddAjhGLygV6lZIYcXza3HAO891XOU6xzCkL9pEPW5x2m3SEbXmTwTwGkHT7ixMC+6Vllo1Tr12takeRFKrrIadD8/EZcDqMyo4l6YrrYYXNFEPWWbHi8UP1JxeofIaazAChnhhwuNSPxc8qDEPop9EBUCCFoLfCyiLevjiRGIFdnwRlFMl2UjIUWFrpfycbQ3xh0fh7m3I3BSNNI10/A8B0qcpPpEYSgvp7pq+xRfVnztxTx3dBzhb5KB9NTjaHZxepfKha6CUROzX+TSdxVjl8ePAuhrDhBA24+3LqoNaiq6G4AOzs0luZasXpZ7G5a0+umAjzPYfNBrHA75HzTtfOw9nVNHWHPQnCNwwCktBrsucmlJ8JMZp/0zQAOdeg43WPRLueVyk2zlgUmMOMOhw84zGTfX9yqU31rBujqiOURgnsoQeszYnWVv5cbRxGMJCaBUeew+XNJI3Mm5KhsyTq8sNZOtfnDAJ53xn8IB6PNl7hxLtIm12iOpb0SVlJVJQyCGe2kcQRk++G6qLKAjJ/ACjMdNv9EZPl0zBpnYfwcX68B/bbLBjK9AYCzymeQ6AUAbLCPQbk/A36hcnJgwN9paaUBQAm0f/FnAreRTRkAsFm1UZXIAEBVyrepbe36z3FdbVLIBT9Ryn4BwE76nEBXmDLxsiVDj7ppPmyIXkLDE2UijxBcYx+Qatf5eGDYVb3d1P/qy5q/pRSanVlsrAC0qyp6zozG+wHonUX6y1MVEgT1xZmr6lz+ucX/jZPYL/6b1Nf/jjsP0IkIULk/Z31pmINqgGh8k1L2+pyVxsrBGAwobq6R8w9ul+NWuWZh2Kq30thkCNzmEYJ7zhA26pzo2JR1xUWUvpMT/TI+YzBTdh6AHR2OXkAzn2SB0Tv3v7zO1AbZtu/RwPSWi4j5PWup70MsrLW71UIweABpMAIBGz1CcIvLoHn5hiB2LFnnJs4O1AwYMEzZGMrE+zFoKIGHA9grBfYXt0hzWbH6cLLVwwBgDkunEY2/x6A3iXgZKVqahVqW+Xz9W7j+glRJumNjR52IFWb6zCME1xACrdGJIiHWy5/QJcj5ZjWq9lVKDAN4ODMNI8otfFux8YVyUWWFTBQLfgDDCDwMnHNZDBCMfv1tROPvM/AGAW8R4w2Csazj8zVvFpooiGgHnZliUms8QnAJBPMa1jhVZJF/dptquWAnVuq7ID6KGSOgMEIB5pc+OnkLvwgwAAwhYEhuEQIMG2a//llE4++A+GkoPKNgLEk3jn0zn+hBBu+gcy4lBK31CMEtFoKBzzRDk7Si5PpOTvSzTDWSlBgJ8EgAhyllD/jCX/HgCj3eF0z7gjBeQMGMJtaCmxcDtJiJFqdEejHkuM81TIRddeaW4bkMbjpDWEF6DXbb6r9Pau0bDKRHA3w8g0anwN8mReSt/rLCABCdBOAkAsNUPkY0/jYRHreZHk4LXgQZ3rgVHdld830rPEJwCVJr139s9uvP6LqN93VCGNNqVA/NHMSE45j5OFD6+7lv8+Qtq8oBARjKjKEC/GtTwUY0/grAj0KIR62VbU9i7oSvFqvRIQRlwbeiUoRUETCj8U8BdDX7cpZV1VAi+1gmnEDg0QD6lcCS8SjGvTJbx4zHifAwq6rHSWTf7jyz6Ao+sWLhirisVVVBuvORBiFUkci+C4BKuUA9MnC1zPoT4QwAZ5DQ/hT8YaXIW1SQ5nzgrU8PZaJ7noVQArzTw9WyA8A6AtYzeF0uepO+uIFngTiZ012ymPmLFHIWQSS/bqKrIAATAIgoyODcFWWm//49I8iEPgT0Y6B/p7tV3WMlr/C2Rwhug60+gBAVpWfMnCLQ85070EcEWsvgdSx4vYCxzraxvsq213VsWr+uVBF8W4Scb1anq/plDaO/YaCfgt2fFPUjUH8mbA/mXQHsAdCh+IJkKmemKsZCKHuzuToSP1QRzgU4DFBNBWnZOhLq4KRs+KiSlo4pF+wBZb+EEhzilhBtBG4mFvM6GkNLPEIo+W7U6g+qzKkMvhCA28uFOTkoZyH49A5Zf1clWtgBGT+ZFO5xIpcy0NklYJprGekmyHGWRwhFRK8prTtkfalfAvQrAN9yYReXA7yYQC8rwUuh6HwCfqQ9KUQ3JKeHJlay2x2cFr+RGb/Wd6NwLwy+UdhiPxZ8MJhHArS3C4e4Ekw3+Qz68yZZ9x+PEAqpPLJpN7D4P2acC7gmuckmAK8RYQmYnjaE/WSbbPgyfDUYSfyMiRc4eO77lvAfCFnbVsmEADmn2lQ1r6DzXoKe0lLt1zJKT2rtawYzh0Kpo4hpBBOOgPOSd4U2EFMg3ErEM8vB/XM1IQSmNu9DgqYAqAPg6+buLCPwEwxarJR6Pj2j/q0tXZ7JWTLpN6Cf40CB+Rirsf6f6AEIyuYjWdFT6HoA0Bf4j5EV+7XPqtt8QVYphR+DhwqbDgPx4QCOBjC0m4ebASHBNs1KzQi96xGCpkXATJeD6Rx035eQtQAeB9OjUHjImhnqcvBJIBq/g4CfODhsuDYVC1+MHoTAtPh1xPiNA9fhtlRjeExXf18j5w9Syv89Bp8C4KRutCAUgNshaLIlQ+97hLC1SbusZaCqUhEGfoHOPH8lRBrgZ8F4WBj8cAfefwlSalfvCcjmH5CiBxy8/21rk/9gXFeb7EmEADnfNJVvCYB99QmUT07F6u/Tf6cU1fbgEYpwAoATABxReguUUwSaawg146uupkcIADBxdiDYb8BvGHwZgD4lnRbgPkPwzR0IPJq3335Ra9DsnX4DwF66uwYJcXRS1j2NHoigjB/OCk/ruw78niWy++V9mi9bewVV+ngG/QLgH5Z4AW4A04yk4ZsNWZvu7rkQ3a8MidPNfv3fZPCVpSYDACDGHR2y/q5CHOKZvdOXOyADALiqp5IBACRl+DkGfu9g9vY2VdXk/K2U2rZkLHwnWN1R6rEz0JeJrzFV+o2AbP5xjyWEarlgp0Akfjsrvt3hIioURR9eEF9Y3vptgJ34/0ut9eumo4cjJTJRAMscTOCkwNTEkMKsBtGdNSeHkKK7g5H4P4KyabeeQwhjWo1AtPlCpey3iXB696sijy4IryjjDwAFNJtlBWNct4cdu+IsYZwlBIcBZHQNMxK4sTCqwMd2uzYSTmYl3ghE4xMhpahoQghM/dve5rD0Pwn0BwBFqZ5EwGd6mY1ob1Mu2CMvtyfSXAvghw46e2VHY/gFeAAAdMj6lwD8zsEyOj4o42fk5e7JxF4A9tQy9gnFOgzsTcBsU+39pDm1ac+KJAQz0txAIvsycie6xcASME1IiszuAC3Vamnbzq2ES+f1ZiIH/i/etdatm+HRwNfR6T5p3x5khdmQcednUDaO0+NyetUi/64EqgXwTJH82aMgxKtmJDG+cghhUmvfQCR+O4huRa6oRyFhg9BKrA63YuHvWI2huZDjLAI9qikFx6ZiIGhKOKjUzMCFnquwGVx/QYoFLnDQ8lsB5ojzlaDnLiiixyBr08lYaKEVCx9FAkcAWAjdSuRdsBZAPMecFv87Lp3Xu6wJwS9bhpqB9LNFOCtIA2hWQuxnTQ+fmWxsWPy1yQI9prk6j80l9dYcX6RlODE7uXPw91Qs/IC3+jePlAw/zIzbtPdTpt/4Is0HOvLcmUdpuntf07GkDD9nxcK1EDSECLNR6GrQjFrTNF/0y6b9ypIQgtH4mUKpFwEMKyQRENENQhh7WrFwQ1rWvbVZhbKST0DvcGqgXzYP11UiAXUD9ANaNpFt/5+37LehmAYuAqD7KbjKINygS+6+SPwAgHSK92RT4M1+JrZk6P3k9PCFZNuDifCnzs2rUKzwbaHEv/I9Lyk5IQSizRcysACFu4ikACxkVbVvcnpoYoccu3Krv7763E0AXtQifEVaJmMwkhgLwjH6uxjL5MyzPvGW/NaRlOEVxOTgcywdFYwkxmqxCLRdxsVbTeEOIDnzrE+S08PnkVBDQDwXhavZ15sVWs1os3Q/IchFVea0xF86vyIUKgryAaXUflYsXJua8bP3NNo9rimIriuFbPUzodHBWJYmV3dc7y33LpKCsdMfCHjVgQMwExNnd/kTMGsTAnf5jCopGz6yptdPUCwOAuPhAomGAJoWjDb/CWNaDXcSwsTZgaD65C4w/7xAT1zGwElWLHxSekaDfsCKYK2DRQYdjfFzumT+B1V6IvSDqZiE+OX/5P73sFXiHZXl3BmNboWcPYLb9Tuvq+QOou9r+vOP6Q4l3Vi31GoMn8gCpwBUkPyfDPpVYGjmNshWv7sIQbb6g/36LWQHyUA254YBPN1av+7gfA7erLXrn0Uu8WhX0ScwqHqbLkDfyYl+DFzmoEtNPTk82fE85q6CN+lbCXR538mJbaZpCyA1GnoxMe2WEVjsdDwpGb7XWtW2H4EmowAHj0R8mqnSd0HON91BCBNnB4IqfQeDTilAfxaxogOsWL3M+5Pc9RekAHpGT7i0za8hlp8vRy7TsA7WVwl1qbe8naFTdus1m/W3/Dxlm3OuSPcL2FN5X0KaOyGTjIWuYsUHAfxkAUT0w6DtW6jjJhWJEJjMfv3mFcAysAg02RLLjytk8ghiPbcBjNO2Fi5qygV7EPh8B6bd5W664lpuaJMNnzHocgeO9kTz8sSWS7Ll/O9TNZ/5WKHGlZpR/7YVC48C0wRNa3Zz5yYnm/37N+Ub7pxX8pFANHENQKH8/CB+mQWF0zL0ZqEVyYa4T0BdpdFkUBDfPjIJbN60V9kZuvcVCPyatcw/1x0++XzTRNXhsHEkiIYCGAzQAIA7aypQB8BrASwH81sw8C9r7fpn3RBAlVrmmxsclvolgw7QaGaiimcAqN/sPw7PfBdKL6uVLcR9hR0ZsdWIuf5I/FmDOK45vv9dTLUBHvxhCnBsjTr+EhCINJ9PRHmemPM8S2TPL2Z2WjMaXwaN9FlM9PvU9NA34gRqZOIgW/ESXauKQT9IxUIPdR8JtPqDyJwMxQ2cSwYS1HxCkpkeMgx1awcC93fnnX2HyWeUYDpsc+nRg9HEHzozd3cVb1qx8PCiDTCXT+MmAGflt8nSr1Ox0E0lcxmCkZYjyFn8/hddTgEYb8Xqf16CVNV3aroZp28usMW2+RoH8lrUbWRwcVNNMBL/janS77Pi2zlnGgedTDcRn6YU3Wmq9HuBaPOFkHO6pUpTStY/CNAjujquiK/ZHPUzWC/NHaG4+RKuq01asfDZDPo18ghoIvAfgpGmkSUhhL6TE/2YVAucp5xaDzZOtGLhv5RCiQTrEQKAPaojLYd83TVq/hFI7/ILACUEd0t+xEC05RSzWixlwnVwcM9iK9iFQH8wVc07ZqS5oTvGZrO6BPr3BUYFZPMPvvoX1ZHEdwBo5R0QxHeWYoypWOgmEjwKubyeTuBnEgt7T7l1QNEJIe3jWwDs4bCjHyilvms11j1ZKgXqaAy9iFxl6K6vZPrKzjGm1SDQlfo0TfHO67ylPCPYLhBN3EZQ9wDYvYhv2hlEt5rReCsmtfYt5RAzjfWvgtCireiKrv5qEI8i7SS4H3TI8MulGmdS1v9LsThaV3e/gl3TPuMvRSWEYLR5LBOcpnn6AMIY5SjIKM9DGwJpMjt9mc3XHJb5GQDdCyUWsoiWcpT+SHx/U/leIvBPS/jaMWYgtcQfaRle0hklTAGglYyWgf2DQzNfzdKsRQhMdMeW0u4XC+nGuqVkG0cB/J4jOQE/0b330OVDxT6ytX9apd8EMNApGVhy7AfdYWaakZajQeoJLSuBxX5p451lphr8OjQzAjNwTSoWLlncQVAmDmPF96P7UouvJyF+XMrAq8C05muISdclW2qJ5Qf4sde+QonXtVoyf7+76mUEL1+wKxvZRQ4rVK2yRGYY5LjPC2ohpFV6lkMyWAmbjukuMgAAy3jnnwBWaTGlUA1Be+8zoJ8efH1A+K8sMRk8hu6tVNSPlXooKJuPLNULU5Sd6cDHHh7EkNOISfcUf7X1VuBf3SXc5MyxH0Px8bo63IlBQfZ3+d5NlwihM8XYOAed2STYOFmnyElxfGupAPxDz9HAWQBN1XdQENsoa9eVZJec2rxPp2XQC92Pala4KyCbB5dmTsd9TsAVus2UzVFizdgZwp1YWGt3p3CtGQ3/FkwnQ/9KOJh5QmeKuAJZCMqW0C+cwgpU39E49mUXKCsY2l8bBjJhf802/05+vu6m0iyI+SYE/Q2uqWEIALSDUHQHLmoNluJtSeG/Xte/JsKB0CwUzIQ73SDdjsbQEgKf7aCpDwpTC0IInYwf1l6ARNelY6G73aKqKeF/DM4/43RV3SKliuoLqqrfE3AQXAYG9g/2Tl9VkpfJ2jSYZJHfsjYF/xNukW8yVn97Z0Ym3Zmp74qVsG0LQdF4aFbUIeDV1Kdtk12lqbI2TUQLiviG5ZbY6e8lsc0j8UMZNAEuBQPnOQ2M0Tal3/Iv0LtOrPehgAgJN1RU+hopkP8SAl7XbFYFpcbnRwiy1U/6YZQKLH7lxnv/RPatxVsF3Ag5KluC5UaKcBNcUHVra3rFJP5YkjctrLUBpXGIqxetT8q4xXXSlbVpCPo5AM1zDTp7Wzk/xNbN0syp0CxpTuA5yca6Z92opR2y4UUCv1aER79vGbu0lGIMAZn4EYARcD9G/m90YNGshFUdcQD/LsKj33DLGdg3rAQZeh7AXzWbDQwOqv6xY0Jg4tN05waCZrlbT6mp4I9kvqI01gFACmWTV4EUSuM2zp2QYXDBzy2IMc/V8rWNxs57QRr2pXBICFIKMB+veXYwLynDK9wsRJEVceiXC9saPrKMQFMp+t55wHsUygb0/cDUv+1dijelRGA+gI8L+MiMYagWN0s3OXPsxyCar7l5nbi1nAlb/IcghnxHMzU1bKH+7HYVbZ9Vt5oYBauJwIyrSnXoREz1KFzy2pJ0mSgbKsmbZG2ama/ewiw5mFe6rxyS2igSup+5B1Zj74O0CUHZ2lWRF6dlwxtloaYGFepw8dNUm39+yfrN+AHKDVS6PqeM7M0AVm7WdtUVNeGWchBvWta9BpBWyQHbxpHahEDE+2lK8N5y0dEkfPcCvCb/9clX4braZEk6nbtVeAjKD4eWogRZzkoYZxHztQV40mfpVW33l4+IlVYWJ0FbDsff2qGiVgw/GZr5C7sThYlJWJ0SHX8pVZdNf/Yg5JnyrptQFawOHliqlyWNjj8D+VVlZqJ4OaXLJza0kvAwaD8nhKATk66SaH+tnLQ03+/LxPg95ISO0vWY90GZglUJ+y4ndBDjujz7e0s5yTeZzL4GvaQxgx0QAm+n8YIPSrs48kfn9+XnHDZvS6b9c0q8DeyBsgXvWdIFYmT+DAeXgDr7+nS6Mfx6WYn3dw3t0Euksp0eIUycHdDMLvyfclRTYnIUTUdEt+Cq2g0l7SvQp1zpoOR9l+M+J3Czo74K+mOZSllnDQa3VO1ps4TQe8D2eodATG3lKMKksdNtYNa+jJRV4q+l7itTwQrnlt4+AJX8enaW0/oWHMFKrmy/u0ylvEnn172R7dNlQtgEpfddnZS/HEXoxyffBpF23w2yv9MNE54uV0IAccnrOggEjnDAugH/jsHBZSplrXohm1Bldd1lkKFNOocUBOpbjhIUzBfCWaDPhZtL1V7cXVa0lSsfMGNTyeeW8GsndphhiPPLVMw6a9CGHNPedULIJZNs67qyYs9SL5D8/cz524Ep7LD1cDOaGF1SBVe8ulwJQTCVNOIvEG0+nqGd3OYL8mqAjJfXeU0uFHkPjRYbt5QwdmufHT/ReEEvU/5t93KSYcD2/QyA84IjTJeVsr820dvlSgjK4LdK6qEAl+fRvJdpc205ydfEkD0ArTOmlVt2tba465NerUU7+/2ycmsJZ+uZ7N8wokYHZUvJLhqRUEvL9ghBV5fyQC7RKx2dp3KcXVYCVupozQlZqk0IBPWGphDLJs4+IG/9NoCRejLcDEnY6vJS9Tkl65drWm1uwceWDL1fsvMKJWQBHvNdv2wZWjYS1l17yhEh0Kua3TqlZDHreWuNcW6Btr4fVEfih5aw54+XoXnwWKlelUvbpndlf8vnHlxfHucH8T5g/EiLD2jLa3uLhJAUeAx6eQN6mQFzrOsFOKbVIEa4UI9j4kjJeAxiYbnxATNaS/c2MbWAHW/4auk311q7ikKa5wfZdMr3hDYhQIY3ArxYbzfgiyEXufoCTmB45kQAOxVukdLJ1ZFESVKapVZtehB5XtwpMVanxM6PlOJFNTJxEJPeTrkN7BIYljnO1dId02qQXjl7APzM1qJsxTa0XTeRyBDTXlHnagtWOclrv9UEG2SDS5YqDOCbyocP+MZSpZbLKo6iwMljiNTZbpauOSxzNgCti2MEsdU1vVVCIIPj0M3sStQI2drLjQLsI1v7A+ygWC1tY8j4qT8S378UY/CLwGyg9IE+DrAxkBY3lEQmkZbhBJxaeD6j0/pOTvRz7dkBeLpmKxuCE44JISkbPgLwsOZLdwtwutGNMkyp9FjNS1tdZgyRq0hc/FWWKxN3hdvZgJgaN1wZWl+SkwOhoihOWnrT8vGZbpRvUGEWgJ31tjW+f1s5T8W2hc1z9ZUBE03ZfIzrlBRF/b5cG5jaXJJ7/5bwXwvgLRfzwdLk6raS3Br0y5ahYJyh266rWRZ141VK4irIptEM/Eq3nRK4eZvrfVs/6MB79zioEmNA0d+qL2v+lluEmIs94GJeSjJI0PSSDEbWpoVQ9bopuEt0bpASghtKlXFIKBVzYh1oHDaMLFkB2y6g5rKWgVAi7mDMS1N47968CSFXOZmcuAADVRUWbOnedcmtA2X8VLNJFtC+1l0bjLQcUYrxdMiGF5lxsevogOk3HbL+pZKYzTJxGKBtHXTk5laDdGw63RXCnTg7YFephdAsVtvp00Y7q6DnSQgAkrG62wh41cEyPNpUqb+65OLTTzTdngdZ/0SfmHTKiuV5JtJYfwMT/d41ZED8u1RjuGSp+FnxldCuzYbZYH5Yb1x6ulMs6Zr9+s8H8D0HjZckZV2XKliLruo5C7oAThLcg0KBaS2/69YDGBnfBYCeu2Dg1qqsuLZzR9HB9wPRllNKRgr07iUg/LXb9ZXo5tT0cMmqSlXL5tMAjNK1DqpIXUcG6abOHxm8fMGu3eryRuPXAnAS+KeIceGWbjc6JATAkqGnQOSotBUx/zYQbe62nUwp/qnmTtKWRObe9ll1qwmknVmZoK4pWYCWlMqaHvo5ilDKTIMMZlnT68Z3VenyxphWQymaqb/H0p/bZMNnybXr/gFgo5bHKbKndpd4zWnxKwh0kbO5wdxkY/iZLrtHWiyVwqUAVjnrF10UjCb+sLUyUkXTV2ibfPdBjrNyvpe42oGVsI9przynhCNkK1Y/mcBnEFDKXI+bCFxnTQ9dXjIyABAYlvo5NMsEAOgwMipnqV5/QQrQC7ojiNK7DVKKYDR+A9hxjcxPLcpofQ7XWpwbrgyth1AhaJeh7mRo8IUBe/BCXNQaLJVMe8uW7QE6Sm/y6fYvtUiOXQk4SOtN3Fjqy17JWP3tStGhABaV4HWPseBDkrH6BaVdJK29CDTNAWle2zGr/tOvbBJ3as7n0b2mtO5QsnFOnB0w1eAWBs5zahizwNmQ4z4vGiHkXIeGx0Hk2Dwlwulm79TDvWTTjqWQa8bm0wHoXFKxkpb14Nf+wkpdBUA3Y9GOZiBwEUqM1IzQu1YsPJrAdQDeLcIr3ibgZ1YsfFznlezSms8qdTG0T9l5jSX4a+dYSeG/D4Clc6qUrUqX5GyoRs4fZPbr/zgA50FRhBkpGdYNKnQW3WXRTtPAeCIPE/eorBJLctdViw3W+7oAPISrz/16aPDV525iYKaDSbmkRs4f1B1+ZzJWv8Ba5h9GTGMBfhJ6hTy+sdsAWETAzyyxfN9kLPz37hhTbhOh3+pbpjQ9d1nvq5ZGbRuBH9HUjaK7DUHZfKStfEuALddf7Ir1Zr3pjzlp6Myfl6Oyvqx9BoB80nrtwkRPBiLN5xfts+Sk1r4gaOU+ZOY7Nrvzrmr/s4Mdt5dSVdHuOozCwlo72Rj6mxWrPwY27cXMEzlnKnfF2lnFjDsYOJ+E2tOKhUcnY+G/d+VbdrGQZTEdgKYbRu+kVrXP3TxR6LkNTHx88fItMgWizReyoieQ323cZYE0jcHCWkdufV4L0ZzatCeEeBbAwPxkgYeFYYzr9NcLx7aRxM+YWMfHzfiFf1DnfYHNsHf8DFbQzUmQVSwOSjfWuSoFWt/JiX5pn/1tRdRHQGyXMwPU50KIDUmk39H1PYsNf6RluCD1CjTrWxL4jGSs/vbNni9NuXVAxmes0nkmgWqTsVBB81LUXNYyUFWpeYx8r2/zGhY4Mh9XLu+dOSgTh7HiR5B3dR5eQ8CvtjR5jghrWnweGOfoEJPVGD5xq8+Mxp8G8F3NrvzTioWOLuVJfGWByYwmHoN+3MFiKxY6YmtyN6PxRwEcq/HMv1ix8PjCbVrNtUx0I4Dt83kOARuI6diOxtCSfJ6T9yfApAw9L5hGA8jzZhvtwKDbgpH4P4KyabfC6JGmu0Cbdxe+1kuBi6EfoPU9M5IIeQvbIbFH4vUOyAAkxMXbImFdt0GTPLaIarlgp0AkfjsT/b0QZABWJ+ZLBgUhBADoaAwtIYGTCvENnAknsxJvBKOJizB+js/pczovpOyh0URView2y3glZfg5Zrrbwaz9DnL+dt7y1oScvx2IrtbWI6a7krLu6W39zhDGnZoEv5c5tcl58VrZ6g9GEhcrZb9NhLzvSDDwOTGOTzY2LC6EuAsWJJSU4edI8Gg4DFz6X/eOwb83B9W8Hog2O/OrlB6TM/jVdjmua31nNRl6+SYBYGCQ/Y3eCtc0qdk3E/pnVDYb3KWM2B1y7EoCdDOMO7ISAtGWU0yVfoOJrwFQiCRCKxXzMR2N4RcKJe+CRg12yPqXIIwjACwr0CP3IdC9ZiT+kG7eQoLmpGlkB07NqH8bBO0wbmb+decNPQ9dMasjiRHMmKBvjPHctAx3uRaE0s0MLfQ2m2rZ9B0zEn+EoO4BMKRA4nmDbOPwTGP9q4WUecHDiC059oNAmr6LQkbLEU5QxC8Eoonb/DK+7ZDVXHi0ns/JpJXi3MgIycDnuvJmxbO7I3y7/FwFKRTxTdALKgMDn4usoZeXgvlRTV0Z3ZVP5X7ZtF8gkrhTKfE8CIVL2Mp41BKZ7yVnjv240GIvimJuuDK03hI7n8DAtXB0Q3ILhhr4p0LhdTMab/FFmg/cIiPb+xyoeVCTTgn/P3U60z6rbjUAJzEGI017yM+9Fb8N89oe/EsATmpeTO2cmy4jZaWf0nQBd/TLBVvMoVkjEweZ0+J/F0q8SsSnoXDJXxmEK623/D8o1mfh4u1UclQ2FQtfTKAzoVE4tot9HmsQvWxGmu/bXDk1htL18RZD1mr3MSWW3wjgeX1q4ytKGhdfZugtW7YnQkx/teCl1DK/fj6GXGSqlh9uKP6GjpmR5u+Z0fj9tuKXwKgt8PraKASfbk0PT3EadNS9hNCJZCy0kIU9wtHC2eYxAZ3ESv3TjMafNyPxMCbODuQUgzUJgZxVF5JSCaHOg35YcP+sP32lt/Q3jwzztQAGaDZTQuA854tFVwc6dWzi7IAZaW4wo4kXQPQUgB+iwOngATzLquqQDll/V7FlX7pMRnJRlalWRgGeAs1oMw2sBtFfAP4tuOuVnUmI73XlE9WWYE5rngMm3WAVBvPRVmP9Pz0K+IosZfMxUPS4A92cY8XCv3T83kjL0SD1hI7XCKI/gvlc5Bupu2VkwWi0jJ1nlaq+RclTmwVl/HBWmAf9++zFQrsl/P0ha9NOH9BHtvZPq9RbAOm6Af+2hP8AJ+5KReLiphqzWrwCQDep6VqfEEM3ybr/ON+wWv2mSq+DXlm0YuINEnRuUoaeL+VLS37anZTh5yzhPxjgKPSunxYHzE/mQwZAZ60EJidJLPYMqvQsjwk6N4tqusYBGQBMF+dFBgA6deBpF4ghCebLrVXth5SaDLqFEL4QvhWrb2TFBwGlqw68hYOIgpjsVmNoPoBntHUZOM+NNSxK7ipE48cyyIHJz09bjXW3FmhzeKp7Nyc8zIIPsBrrZ5Uqjb07CKETqRn1b1ux8HEQdDyAN7ujD4ooWZjr18RKqF9CP4JRQNH8UmdXcpurAGCuAxc2azPOL9ilMaI13SSBdwlUazWGT+yOpDPdeoawNR8uqFIXKtBlBGxX4rd/DOBBEnjYB//jW7r+3BUEpsWvI8ZvHMzEn63p4V/1RD4wo/G5AH7hwLq6NhULO65N0XvKrQOyVeJYJpwA0IkAdinx0NcTMDMp/Nfn67ZWHiF8gUvn9Q6a5q8ZfBnyvlLtzGgA8DLAj0KIRy34ntKaLBnvYyosg36SC4agEywZerQnkUEgmjiRwA840MUVlpXa9xvZrbaGMa1G9dDMQUw4jpmPA+FoAL5uGHY7wDcE0uKqUtW/LF9C6EQv2bRjhsUUysWyB7uxK5uIsUgRHmahnkzj/Te3lTUoIOMnk8I/HLzrE0tk9nNbcpKiYVJrXzOQfh2Ads0DFvSjlAzdvy0C8A+3hpFNxwjCCQwahcJcKnKKDgbP8WUCV7RdUbvGjVNCbteZXlNad8j6UucBdAEAN5TmbgPwKhGWgOlpkaWnNhcqa0bjtwA4y4Efe7M1PfSLnsAH5rT4fLCTYqo8z4rV/3yzBBPMHAqljiKmEUw4EkB/Fwx1ExHmU4av/GrmZ48Q8txNgv70r5hwARzUtisy/g3gOQYvFoIWJ5F5BcmagOPdDzgpFQs/UMlkEIg2/4hA9zpo+kkgTftvMNPJIHwHKcUjCTQSwOEA9nTZMD8lxuykgT99I8mrRwgFwvg5vuCgXqcx8/hv3iBjNw3pUwavIuBgB3361MiKg3Uv6ZQLauT8QbbyvQL9CD8G4Z9gbA9gH2jehCwhloB5trW6Y0F3fT7sOYTwFVRH4ocqwnkAxgBdD1UuEyyylvmPL+ZFlm6BlMJUQx4E+PgKm692EBYKUjd2yIYXy3UQVBFTMam1byCQnknOq9y4dXLuA3g+hPiY0urjDv8ua0oV015Ii656++rt2eDdYIhdWeEc5C4AVQxYqOtTEFPLxS2ofEIAEIw0/5aJrkXlYxOAdQysJ6Z1TFhP4HVMWC+Y1jF4HYHXsRAbchPMbWRTBgBsI7uJUJUFAF8qu0FwlQKADVfWfQ4AfSe3bAcAirIiE6jqm7PRs1WGXdUbANhgH4N6dT53O1boR6D+irg/MfoxKPf/xP0pdwDcH9p1FMqQEJguTDWGZlfCWKoqZlIE9kHPSHLeG0BvAnYH8ZeMTgxwpwAYBCj+8lSFOwP5SBn4Il9NxvffP5vRBAAg9eUrjC/bEwyoLwIBFb5sw1869fxlnCCBAaqgXaaLEIL3qZixVA5N097w4KFbLARUjO5VUm6/3fQmUc0m8GsAvOIpHv67rYBfI+YbNNvt7hGC2+ZRLw59baqx4cJkrP7AKqEGEagWxHMBrPDWRI/jgDUAFoJpAgnslozVH5hsrJ+oWWNkt0qRRkW4ezWXtQy0q1SX60Ew+OVUrP6Qzf2bKRN7wcZxBD6Fc3EOpqvUFz3PRy8wLDCeJqJHifFoR2PdS5u7LRmMNr/KoAO6+tCqjH9Ht4Yj66AiDhXZn90VSsPYYfHhFrVFht5H7iruXMg51aaqOQJMRxB4JBOPdJAVyWPw7sVnBF7MjOdg8HPWBvNZXFeb/O8/b7HC3ocAukwIqiqzGwCPENwAG2KQzkIRgj/q0g/lhA4rl8DlyyQu1XLBTrbiEQT7uwAdBWCE26yIHowsgHdA/DQUnlEwlqQbx77pKF8CiQ/BXW9mkxpUCQKsCEIgRQO1zgYVHF8w6SxZvxLovM04cXYguN32hwBqJAscCMZwAEPRA76/dzM2AngLoKUM9aoQtDi5dt3LuP6C1Nd/VufM6mTWKklIoO09QnALITDvoJPziIHPCvby6y9IJYFnkfvfl+g7OdEvbdJwtnlfEjycFfYFYX8UL0NvRZ50ELCBgeUA3iTQUgV6kwQvtfDuB9u6hp7fEGiNjmFBTDt4hOASKEE7kIZ5xySK7ut1Jr54Gv+TuLNaLthJQe3LNg8mQbsyeCgYP6YKChJzQgYMygL8DwLeZPDHBFousvxmd10XJuI1rKWD7BGCe9SPte68C6G67fDnKy7Hl5mRgjJ+Biss7MHmPwtwbTIWvtM1PRJiDZTS0EHq7xGCW7RJoRdpbEoqy65KW5WU4duC0+J/YsavHTLiw0x8I9miP1HuLgGYfQRhMqnObFNUDUags0UvcGfqMEIf/PcasQ3Gxs6/z+CLEnyEFMAdOdNYJBnKAlGGmNYxY70irBcC50E5u8FIhOuT011EBgBsW20QOoYOc41HCO6xEKp1zFTBVR1uG0OSMv9nsm8EgJEO7O0TBIvHk42hq7qj72Y0PgUKTq8zP5tct+5St82HYNUGEjo62KsS1lJlRCqSXrUdn89od90Y5DhLCON0AJ84spLAs4IycXqpux2U8TMAzHDYfIUhMqd/88uAC3ZK29SqpsUsajxCcM8wtCZj49pV7W4cRYccu1IwfgJnFa0EK06UsuiLKZtGs+K4Qz1KCqbT2uW4VW6ci7bAej0dIfYIwTVnCGA918eFO9KXpNAYfoFADXB26cqEorurIwsOLnY//bLlAFbidoACTqaMwOd2NIaWuFapVjoouOMRgmsGUVERvclYaCHAVzts3kdR9qHA1MSQ4lkGib2EUg85LqhDdEUyVr/A1ZOw07dZd1AeIbjHRtA6Dy6HEVnivcuIca+z1rQDCfVAjZxf8HDaXlNad4DCAwCcPZvxoPWmL+r6CVi6houogx4heNCElCqZ9ocBLHNICnvbyndvQWtGynifjC/1EMDfdviENy0DZ1Zc4tjcLuMRgnsmg3T8PYJs9ZfFwK6q3QClfgTAaanzEaYZuBsTZwfyJ4NWv6noNgI5PZ9Yx4JPLZtEpLtbWhfWCEh7hOAeaJ0I97UyZXMibM1o+DeD65C7yecEo8x+/W/FmFbnNQzGtBoBlWnJI3V6FoLO7O7Kxlqukc/US+vP1OERgntMBK3JSBvZsqrhkIrVPwLQOXmcf5xpDksnIBdVOSEDc9/0LQT+aR7W9C/LrYhtVmS0dIQ6Izk9QnADHxBpWQg2UZ9yG6MVCzWDeWoejzjTVCtu0bIU5KIqc1g6AUbY6UsJNMWKheaVm7yVz9Y6e2EBjxDcAiLeoDXoKqMsb6ZZjfWziJBH/n8KmcPSzV2yFOSiKlN90gLgTOeGG1+XjHVPOHUBFsaOmoPd4BGCe6CV34BU+eYkSE4P/QZETXk8YmzA/mQBxs/xbdVNUJ80IVciz6lp0JIS711ctpuMLTQ/q9IqjxDcMnlMWoSguJzvrhNb5PsFQI84t6hwhjmoJrFZUhg/xxcYll4IYKxzHw4PWp+2n13UBCbFh5aFwKw+8wjBLWcIuhmQRJnn0Ze1aUu0nYb/ydKkiTHBgTV3fO2TpGz1Bwb2aiXgJ3k893nL8I8pt6rHm2HNPbRUyvAsBBcxAq3QZJAhZT9mOaGjKuM/FaB3nIsNJwe2G/A3TJwdgJxvBlXqNiI+LY9eLfNl7JMga9vKX6dYrxqTLT7xCMEtZK4yWt+3CRVACADarqhdA2X/AHCeNJaITwv26/+YqXyLGHRKHt1ZQUL9YNMVZ62tjD0Gg3V+b2SrllfEWqoICwFMZjSxCehqXgROWSLQB7K2IqLL/FObhgkhHofT+wX54xMW9uiUPOudilAnOd80lW8jAF8XW2y0YuG+noXgHl5jAt7X+H2g2raHo0KQntGwjIV9NBwmV8kTK1jwMRVDBgCCtnGgBhkAwLuVMvaKudzEwBs6v1fIjkAFISXPeocVjSoxKXzMgkeVU0hy13RD6OkG0VKPENzn++gl2yBxJCoMqRmhdztJoRRFaz+CoGMqjQxyqoEjtDYjVi95hOA2C0GwZvYdPg4ViBwpVB0D4OMivuZDKHVMZx3MCgMTGKO1FpEwlniE4DJYycDLAHQCYXb1y5ahlUkKP3sPgo4B8FERHv8BhHGMNaPh35UoO79MDAOwk0YTO9mWfdkjBLfhqtoNDLyi08Sw1Y9RobBk6H0S6nvQOmztkmUw2pJjP6hUuQlbOw7jRfyuod0jBHceJGhdsWVCLSoYSdnwEQQ1MpB/hiKGDVCkUi2DL1WIqFazwWMVRYiV5f6x7p37EcVMRtqtkIuqzGjzlVD8V/pvZaZ8yNYA+BYzGp/lKK9CWbgL8X0ZOFBPLrZHCK71nTcFnoZm9iQY+GWlKXZQxncx1YpFAE1CQYLP+Kv6MsVUKxYFZXyXSpObobR1YZMF+18eIbgV19UmQfwPTaviHFzcVFMxZBBNjGGFVwA6qpC+2P/891Gs8Epn1abKwKXzejNwliZR3gM5zvIIwc0+IFOrpqpvFwwavyr7gU9q7WtOa57D4FYAA0rwxgGssNCMxlv7Tk70K3fxmWbgfABambRY0N8qbf1UHCEkReYBAFqZfZl4MmS8T7mOOSCbf2AG0q+DaXw3vH5Mys+vBGT8hLJVGjl/OwCXaLZan1q77hGPEFw/ueMs0s8oNCDAHCm3ofaa0rqDGW2Ok6IHAOzajV3ZjRQeMqPxpt6yZfuyI1RVFQWgZeUw4VY3lwT0COErsIluhGaGYmL6TXUkUR73G6QUZrR5XNaXXgZQyEU9q88o+00z0txQLpWMgjJxGIEu0GymQHxjJa4dQoXCjMQfAkHXjH3TEv6Rbk7wEZTxw1nhjwAOK9Qzmfg2gAQxCllO/jnBuKCjMfyCa5Xk0nm9TTOwGMAwPYHx/VZj/Y8qcd1Ubik3QznJ9ruvqdJ/dePuZl6e2N2MxptY4V8FJAObmC5JTa8fk5oeOoMYU1CIIKYcDleE58xp8flB2bSb+xSEKRAI3KJNBgBgiKsqddlUrIXQaSU8AoL2JSYizE5OD1/ohjH0li3bZ5R9MUAXAjAL+OjPGBzOFYH5qsxajgapFujF828LaRDfYlB2Wrsc54rcg4FpzdcQk5Os0A9YsfBJHiGUIaoj8UMVYbGTcRLoj0nx7m+7K3Nw8PIFuyojexGBxqPLmaC6ujni4SpD1bfJhs0mp625rGWgbai4EzLdBtqYaK4gvi4pwyu6RSnGtBrBYenrGJjoRHKCjREdjWNf9gihXK2EaLwJQL0j4TDuTab9YVxVW7IiHNWy+RDF4kIwj4Ve1p6uIAum6Zbx7qxtEp2UwlR7Xw5QFEChQ5XTACVsVn/MNNa/WjJlmNTaNxhIJxhw6P/TfCsWOqeS10vFE0LO5FZLoVuJ579YwYImpGTo/qJ1Urb2MlXmTIAnADi0SG95WzDqdQ/5gjJxGCs051ECfltYDPAcSwQWFvMwNyATJ5HiOQCchlyv8gv/8I2ydp1HCGWOYCTxMyZekKeoHiHm6cnG8DOFIoGgyvxQAWcS+CQAwSINnwm4IbnJPwnX1Sad9XVOdZBrrmHGr4qoMx3MuF8Y+HsS/gcLRQ5B2XIU22pavu4PgWqTsdDCSl8rPYIQAMCclrgVzA0FeNQbBG6yhfFQWo59HaCuxTvI+duZMA6BbRwJ4uMBHFEEl+B/ueA9gCZYsXBBbuQFos3HE2gOgD2LPF1pgJ8F6BEI9awF+yXIcZ93Tc5S+Oy9968CnciEBgDDC7BKbrGmh8f1hHXSYwgBF7UGA73TTxNwSAGfug7g1wF6B4TVxNSWU2b4mdAHrAaCaXcQ9gKwVwlHm2XgupRol5ATCluV+OKmmkCNESPmC1GIa9VdZDYA/wbjfRB/CBKribHxS1mDe4NoIFgNAegAaEYdbmOJvGiJ9Pcq7RKTRwgATLlgD6js8wDtUMHDfEGwMaHYJ+HVkcQIRTwHwIgKluVqEuqwpGz4qKeskR5FCADgly0HCKUeR2luBJYSaxncmFoWuAELa+3SvJLJjMTrQXQ1UL4VtbdgknxuCD62Q9a/1JPWR48jBAColk3fYSUeZaACqu1wignXp4gaIcMbu6ULk1r7BsxMlJjPB+D3yMAjhDIkheZDlKK74fwzVHfDBqEZWZLWzNCHrnHJWE0Hc6iE5wuFxseCjVMrOfjII4QtkcJlzd9SVXQHgMPLqNuKGXcwq2h6RsMyV7plkZbhBBUjwmkor/syzxoic7pbwqs9QugOyPlmkH1XMeN8dysvpwDElTB+l5Z1b5WDaHNFaI1LAA653JVQBLo+uX7tpErMceARggMEZctRrHheESPynGI1gL8KYdzQIceuLE/ZxndRjInEPM6FX3jeJsa5BQs48wihgnBRazDYK3Mek7q0mxWXwbSIoOYkjcBdlVK2HrLVH7QzpzPxeADHdLP+fUZM1yTbfDc6juD0CKGH4OKmmmC1cT6DJwLYuWQkADxPzK1QVQuTM8d+XMkiDsqm3aDEGAZqUcBkL13ACmJcn0yqGyup4pJHCKXAmFYjMCxzHBE3gHEqCn0NGVjHjMeJ8DAJ9VBPCoD5Kky5YA9W2RMBcTyBR6OgkYYAgHaA72Lg1pR477HuutLuEUIlQbb6g8gexjYfA/D3QBiKXGLTLsqQ1wC0nICXmPGSYdBL7Ut9r5cuiKh8SLhmeGZ/W2EEER/CjEMADAbQ1eStCrnK12+B6WkCL0qubn8ecydkPOF6hFD0Mwd/X2tvAWOQUqgxmGuYUEOgz20gLcBtSuDTNNo/KPidgh7oxvl7id2FwrcUqJcB+JnRj8BtNlG7EGhXsFelYS/vKfcOPHjw4MGDBw8ePHjw4MGDBw8ePHjw4MGDBw8ePHjw4MGDBw8e3Iz/B49cs5nn4UBNAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDI0LTA2LTE5VDA2OjEyOjUzKzAwOjAwi6r/pQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyNC0wNi0xOVQwNjoxMjo1MyswMDowMPr3RxkAAAAASUVORK5CYII="

        image = FileUtils.imageFromString(url)
        XCTAssertNotNil(image)
    }
    
    func testImageFromUrl_WhenBase64NotFoundComma_ShouldBeNil() throws {
        let url = "data:image/png;base64fdafsadfsa"

        image = FileUtils.imageFromString(url)
        XCTAssertNil(image)
    }
    
    func testImageFromUrl_WhenBase64Data_ShouldBeNil() throws {
        let url = "data:image/png;base64,&#()$#"

        image = FileUtils.imageFromString(url)
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
