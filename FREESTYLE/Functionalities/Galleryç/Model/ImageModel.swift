//
//  ImageModel.swift
//  FREESTYLE
//
//  Created by Alicia Monserrath Castro Hernandez on 30/10/20.
//

import Foundation
import ObjectMapper

public struct ImageModel: IModel {
    var id: String!
    var isFavorite = false
    var user: UserModel!
    var urls: ImageSizeModel!
    
    public init?(map: Map) { }
    
    public mutating func mapping(map: Map) {
        self.id             <-          map["id"]
        self.user           <-          map["user"]
        self.urls           <-          map["urls"]
    }
}


public struct UserModel: IModel {
    var id: String!
    var name: String?
    var firstName: String?
    var lastName: String?
    var bio: String?
    var location: String?
    var instagram: String?
    var twitter: String?
    var picture: ImageSizeModel!
    var totalCollections: Int!
    var totalLikes: Int!
    var totalPhotos: Int!
    
    public init?(map: Map) { }
    
    public mutating func mapping(map: Map) {
        self.id                     <-          map["id"]
        self.name                   <-          map["name"]
        self.firstName              <-          map["first_name"]
        self.bio                    <-          map["bio"]
        self.lastName               <-          map["last_name"]
        self.location               <-          map["location"]
        self.twitter                <-          map["twitter_username"]
        self.instagram              <-          map["instagram_username"]
        self.picture                <-          map["profile_image"]
        self.totalCollections       <-          map["total_collections"]
        self.totalLikes             <-          map["total_likes"]
        self.totalPhotos            <-          map["total_photos"]
    }
}

public struct ImageSizeModel: IModel {
//    var raw: String?
//    var small: String?
    var medium: String?
//    var large: String?
    var full: String?
//    var regular: String?
//    var thumb: String?
    
    public init?(map: Map) { }
    
    public mutating func mapping(map: Map) {
        self.medium         <-      map["medium"]
        self.full           <-      map["full"]
    }
}


public enum ImageTypes {
    case collections
    case gallery
    case photos
    
    var hasTitle: Bool {
        switch self {
        case .collections:
            return true
        default:
            return false
        }
    }
    
    var hasOverlay: Bool {
        switch self {
        case .collections:
            return true
        default:
            return false
        }
    }
}

