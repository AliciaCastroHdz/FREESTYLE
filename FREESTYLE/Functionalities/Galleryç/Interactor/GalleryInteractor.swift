//
//  GalleryInteractor.swift
//  FREESTYLE
//
//  Created by Alicia Monserrath Castro Hernandez on 30/10/20.
//

import Foundation
import UIKit

protocol IGalleryInteractor: class {
    var params: Json { get set }
    func getMostPopularArticles(period: Int)
}

//class GalleryInteractor: IGalleryInteractor {
//    var presenter: IArticlesPresenter?
//    var manager: IArticlesManager?
//    var parameters: [String: Any]?
//
//    init(presenter: IArticlesPresenter, manager: IArticlesManager) {
//        self.presenter = presenter
//        self.manager = manager
//    }
//    
//    
//    func getMostPopularArticles(period: Int) {
//        manager?.mostPopularFromApi(period: period ,complition: { (error, success, response) in
//            if(success == true){
//                print("getMostPopularArticles Done.....")
//                self.presenter?.showResponse(response: response)
//            } else {
//                self.presenter?.showErrorAlert(title: "Error", msg: error?.localizedDescription )
//            }
//        })
//    }
//}
