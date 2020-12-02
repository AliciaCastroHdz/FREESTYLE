//
//  GalleryManager.swift
//  FREESTYLE
//
//  Created by Alicia Monserrath Castro Hernandez on 30/10/20.
//

import Foundation
import ObjectMapper
import RxSwift
import SwiftyJSON

protocol IGalleryManager: class {
    func getPhotos(page: Int, count: Int) -> Observable<[ImageModel]>
}

class GalleryManager: IGalleryManager {
    func getPhotos(page: Int, count: Int) -> Observable<[ImageModel]> {
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
