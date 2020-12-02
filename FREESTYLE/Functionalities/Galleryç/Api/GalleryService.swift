//
//  GalleryService.swift
//  FREESTYLE
//
//  Created by Alicia Monserrath Castro Hernandez on 30/10/20.
//

import Foundation
import Alamofire
import ObjectMapper
import RxSwift
import SwiftyJSON

public enum GalleryServices: IEndpoint {
    case getPhotos(page: Int, count: Int = 10)
    
    public var description: String {
        return "GalleryServices"
    }
    
    public var isAuth: Bool {
        switch self {
        case .getPhotos:
            return true
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPhotos:
            return .get
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .getPhotos(let page, let count):
            return ["client_id": Strings.apiPublicKey,
                    "page": page,
                    "per_page": count]
        }
    }
    
    var header: HTTPHeaders? {
        return nil
    }
    
    var encoding: ParameterEncoding  {
        switch self {
        case .getPhotos:
            return URLEncoding.default
        }
    }
    
    var path: String {
        switch self {
        case .getPhotos:
            return Strings.apiBaseURL + "photos"
        }
    }
}
