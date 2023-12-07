//
//  CountryListTests.swift
//  CountryListTests
//
//  Created by DMonaghan on 12/1/23.
//

import XCTest
@testable import CountryList

final class CountryListTests: XCTestCase {

    let testCountries = [Country(name: "Pashto", region: "AS", code: "AF", capital: "Kabul"), Country(name: "Albania", region: "EU", code: "AL", capital: "Tirana"), Country(name: "Åland Islands", region: "EU", code: "AX", capital: "Mariehamn")]
    var testData: Data? = nil
    var viewModel: CountryListViewModel? = nil
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testData = try JSONEncoder().encode(testCountries)
        viewModel = CountryListViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        testData = nil
        viewModel = nil
    }

    func testGetCountries() throws {
        guard let safeData = testData else {
            XCTFail()
            return
        }
        viewModel?.getCountries(data: safeData, handler: { [weak self] in
            XCTAssertEqual(self?.testCountries[0].name, self?.viewModel?.countries[0].name)
            XCTAssertEqual(self?.testCountries[1].code, self?.viewModel?.countries[1].code)
            XCTAssertEqual(self?.testCountries[2].region, self?.viewModel?.countries[2].region)
        })
    }
    
    func testGetFilteredCountries() throws {
        viewModel?.countries = testCountries
        viewModel?.getFilteredCountries(text: "s")
        XCTAssertEqual(viewModel?.filteredCountries.count, 2)
        XCTAssertEqual(viewModel?.filteredCountries[1].name, "Åland Islands")
    }

}
