//
//  GalleryRouter.swift
//  FREESTYLE
//
//  Created by Alicia Monserrath Castro Hernandez on 30/10/20.
//

import UIKit

protocol IGalleryRouter: class {
    
}

class GalleryRouter: IGalleryRouter {
    weak var view: GalleryViewController?
    
    init(view: GalleryViewController?) {
        self.view = view
    }
}
