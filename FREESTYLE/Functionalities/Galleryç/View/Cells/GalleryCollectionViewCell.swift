//
//  GalleryCollectionViewCell.swift
//  FREESTYLE
//
//  Created by Alicia Monserrath Castro Hernandez on 30/10/20.
//

import Foundation
import SDWebImage
import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var favoriteIconShadow: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    
    var image: ImageModel?
    var type: ImageTypes = .gallery
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.layer.cornerRadius = 20
        self.imageView.clipsToBounds = true
        self.overlayView.layer.cornerRadius = 20
        self.overlayView.clipsToBounds = true
        self.loadingIndicator.startAnimating()
        self.loadingView.alpha = 1
        self.setup(isEnable: false)
    }
    
    override func prepareForReuse() {
        self.imageView.image = nil
        self.image = nil
        self.setup(isEnable: false)
    }
    
    func setImage(by model: ImageModel, type: ImageTypes) {
        self.image = model
        self.type = type
        self.imageView.sd_setImage(with: URL(string: model.urls.full!)) { (image,_,_,_) in
            if image != nil {
                self.loadingView.isHidden = true
                self.setup(isEnable: true)
            }
        }
    }
    
    private func setup(isEnable: Bool) {
        self.titleLabel.isHidden = !self.type.hasTitle
        self.overlayView.isHidden = !isEnable
        self.favoriteButton.isHidden = !isEnable
        self.favoriteIcon.isHidden = !isEnable
        self.favoriteIconShadow.isHidden = !isEnable
        self.setupFavoriteButton()
    }
    
    private func setupFavoriteButton() {
        guard let image = self.image else { return }
        let favoriteImage = image.isFavorite ? "ic_favourites_white_fill" : "ic_favourites_white_empty"
        let favoriteImageShadow = image.isFavorite ? "ic_favourites_shadow_fill" : "ic_favourites_shadow_empty"
        self.favoriteIcon.image = UIImage(named: favoriteImage)
        self.favoriteIconShadow.image = UIImage(named: favoriteImageShadow)
    }
    
    @IBAction func setAsFavorite(_ sender: Any) {
        self.image?.isFavorite = true
        self.setupFavoriteButton()
    }
}
