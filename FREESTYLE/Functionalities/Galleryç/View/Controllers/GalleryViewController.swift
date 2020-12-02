//
//  GalleryViewController.swift
//  FREESTYLE
//
//  Created by Alicia Monserrath Castro Hernandez on 01/11/20.
//

import UIKit

class GalleryViewController: UIViewController, IGalleryPresenter {
    @IBOutlet weak var collectionView: UICollectionView!
    //MARK: - Properties
    var interactor: IGalleryInteractor?
    var router: IGalleryRouter?
    var images: [ImageModel] = []
    var presenter: GalleryPresenter?
    
    //MARK: - Properties
    private var currentPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = GalleryPresenter(view: self)
        self.presenter?.getPhotos(page: 1)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        let cell = UINib(nibName: "GalleryCollectionViewCell", bundle: nil)
        self.collectionView.register(cell, forCellWithReuseIdentifier: "GalleryCollectionViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func showErrorAlert(title: String, msg: String?) {
        
    }
    
    func showResponse(response: [ImageModel]) {
        print("response: ", response.count)
        self.images.append(contentsOf: response)
        self.collectionView.reloadData()
    }
    
}

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return self.images.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        let image = self.images[indexPath.row]
        cell.setImage(by: image, type: .gallery)
      return cell
    }
    
    func collectionView(_: UICollectionView, willDisplay _: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let validation = self.images.count - 1 == indexPath.row && self.images.count % 10 == 0
        guard validation else { return }
        self.currentPage += 1
        self.presenter?.getPhotos(page: self.currentPage)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = self.images[indexPath.row]
        let vc = ImageDetailViewController(nibName: "ImageDetailViewController", bundle: nil)
        vc.image = image
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
