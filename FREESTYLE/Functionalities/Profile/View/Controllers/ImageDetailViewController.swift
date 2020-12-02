//
//  ImageDetailViewController.swift
//  FREESTYLE
//
//  Created by Alicia Monserrath Castro Hernandez on 01/11/20.
//

import UIKit

class ImageDetailViewController: UIViewController {
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var verticalDotsImage: UIImageView!
    @IBOutlet weak var collectionsCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var photosCountLabel: UILabel!
    @IBOutlet weak var userBioLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var image: ImageModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setDatas()
        self.collectionView.delegate = self
        self.collectionView.dataSource =  self
        let cell = UINib(nibName: "SectionCollectionViewCell", bundle: nil)
        self.collectionView.register(cell, forCellWithReuseIdentifier: "SectionCollectionViewCell")
        let header = UINib(nibName: "CollectionHeaderView", bundle: nil)
        self.collectionView.register(header, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView")
    }
    
    private func setupView() {
        self.followButton.layer.cornerRadius = 10
        self.userProfileImage.layer.cornerRadius = self.userProfileImage.frame.height / 2
        self.messageButton.layer.cornerRadius = 10
        let tintColor = UIColor(red: 63/255, green: 142/255, blue: 247/255, alpha: 1)
        self.backImage.image = UIImage(named: "ic_back")!.withRenderingMode(.alwaysTemplate)
        self.locationImage.image = UIImage(named: "ic_location")!.withRenderingMode(.alwaysTemplate)
        self.userProfileImage.image = UIImage(named: "ic_avatar")!.withRenderingMode(.alwaysTemplate)
        self.verticalDotsImage.image = UIImage(named: "ic_vertical_dots")!.withRenderingMode(.alwaysTemplate)
        self.backImage.tintColor = tintColor
        self.locationImage.tintColor = tintColor
        self.userProfileImage.tintColor = tintColor
        self.verticalDotsImage.tintColor = tintColor
    }
    
    private func setDatas() {
        print("self.image.debugDescription", self.image.debugDescription)
        if let userPicture = self.image.user.picture, let imageURL = userPicture.medium {
            self.userProfileImage.sd_setImage(with: URL(string: imageURL))
        }
        let name = self.image.user.name
        let firstName = self.image.user.firstName
        self.userNameLabel.text = (name == nil ? "" : name! + " ") +  (firstName == nil ? "" : firstName!)
        let location = self.image.user.location
        self.locationImage.isHidden = location == nil
        self.locationLabel.isHidden = location == nil
        self.locationLabel.text = location
        self.collectionsCountLabel.text = "\(self.image.user.totalCollections!)"
        self.likesCountLabel.text = "\(self.image.user.totalLikes!)"
        self.photosCountLabel.text = "\(self.image.user.totalPhotos!)"
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ImageDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 2
//            self.images.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionCollectionViewCell", for: indexPath) as! SectionCollectionViewCell
//        let image = self.images[indexPath.row]
//        cell.setImage(by: image, type: .gallery)
      return cell
    }
    
    func collectionView(_: UICollectionView, willDisplay _: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionView - didSelectItemAt: ", indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "CollectionHeaderView",
                    for: indexPath) as? CollectionHeaderView
            else {
                fatalError("Invalid view type")
            }

//            let searchTerm = searches[indexPath.section].searchTerm
//            headerView.label.text = searchTerm
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }
}
