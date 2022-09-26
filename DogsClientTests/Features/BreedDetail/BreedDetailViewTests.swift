//
//  BreedDetailViewTests.swift
//  DogsClientTests
//
//  Created by Petru Lutenco on 20.09.2022.
//

import XCTest
@testable import DogsClient
import ViewInspector


extension DogDetailView: Inspectable { }

final class BreedDetailViewTests: XCTestCase {
  
  private var breedDetailView: DogDetailView<DetailViewModelProtocolMock>!
  
  override func setUp() {
    let viewModel = DetailViewModelProtocolMock()
    breedDetailView = DogDetailView(viewModel: viewModel)
  }
  
  func testZoomInAndOut() throws {
    // Assuming the initial state is not scaled/ aspect fit
    let image = try breedDetailView.inspect().find(viewWithAccessibilityIdentifier: "dogDetailImage").image()
    let contentModeIsFit = try image.aspectRatio().contentMode == .fit
    XCTAssert(contentModeIsFit)
    breedDetailView.on(\.didAppear) { view in
      try image.callOnTapGesture()
      let contentModeIsFill = try image.aspectRatio().contentMode == .fill
      XCTAssert(contentModeIsFill)
      try image.callOnTapGesture()
      let contentModeIsBackToFit = try image.aspectRatio().contentMode == .fit
      XCTAssert(contentModeIsBackToFit)
    }
  }
}

fileprivate extension  BreedDetailViewTests {
  class DetailViewModelProtocolMock : DogDetailViewModelProtocol {
    
    convenience init() {
       guard let image = UIImage(named: "test-image") else {
         fatalError("Please supply an image in the asset catalog with the name 'test-image'")
       }
       
      self.init(image: image)
    }
    
    required init(image: UIImage) {
      self.image = image
    }
    
    var image: UIImage
  }
}
