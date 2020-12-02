//
//  GalleryPresenter.swift
//  FREESTYLE
//
//  Created by Alicia Monserrath Castro Hernandez on 30/10/20.
//

import Foundation
import RxSwift
import SwiftyJSON
import ObjectMapper

protocol IGalleryPresenter: class {
    func showErrorAlert(title: String, msg: String?)
    func showResponse(response: [ImageModel])
}

class GalleryPresenter: IGalleryPresenter {
    weak var view: IGalleryPresenter?

    init(view: IGalleryPresenter?) {
        self.view = view
    }
    func showErrorAlert(title: String, msg: String?) {
        self.view?.showErrorAlert(title: title, msg: msg)
    }
    func showResponse(response:  [ImageModel]) {
        self.view?.showResponse(response: response)
    }
    
    func getPhotos(page: Int) {
        let _ = self.getPhotosResponse(page: page, count: 10)
            .subscribe(
                onNext: { [weak self] response in
                    print("GalleryPresenter - NEXT OBSERVER")
                    guard let weakSelf = self else { return }
                    weakSelf.showResponse(response: response)
                }
            )
    }
    
    func getPhotosResponse(page: Int, count: Int) -> Observable<[ImageModel]> {
        let observer: Observable<JSON> = NetworkService.share.getResponse(endpoint: GalleryServices.getPhotos(page: page, count: count))
        return observer
            .flatMap { json -> Observable<[ImageModel]> in
                guard let response = json.array else {
                    return Observable.error(HttpNetworkingError.jsonSerializationFailed(HttpRequestError.mappingError.error))
                }
                var images: [ImageModel] = []
                for element in response  {
                    if let json = element.dictionaryObject,
                       let value = Mapper<ImageModel>().map(JSON: json) {
                        images.append(value)
                    }
                }
                return Observable.just(images)
            }
            .catchError { _ in
                return Observable.just([])
            }
    }
}

