//
//  CustomVerticalCollectionViewLayout.swift
//  FREESTYLE
//
//  Created by Alicia Monserrath Castro Hernandez on 06/11/20.
//

import Foundation
import UIKit

class CustomVerticalCollectionViewLayout: UICollectionViewFlowLayout {
    var maxWidth: CGFloat?
    var minWidth: CGFloat = 0
    var maxHeight: CGFloat = 0
    var minHeight: CGFloat = 0
    var standardHeight: CGFloat = 0
    let itemSpacing: CGFloat = 20
    var layoutInfo = [IndexPath: UICollectionViewLayoutAttributes]()
    var xPosition: CGFloat = 20
    var maxYPosition: CGFloat = 0
    var minYPosition: CGFloat = 0
    var maxColumn: CGFloat = 2
    var currentColumn: CGFloat = 0
    var currentRow: CGFloat = 0
    var spacingFactor: CGFloat = 0
    
    override var collectionViewContentSize: CGSize {
        let collectionViewWidth = self.collectionView!.frame.width
        let contentHeight: CGFloat = self.maxYPosition > self.minYPosition ? self.maxYPosition : self.minYPosition
        return CGSize(width: collectionViewWidth, height: contentHeight + self.minimumInteritemSpacing)
    }

    override init() {
        super.init()
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        self.estimatedItemSize = CGSize(width: self.maxWidth ?? 250, height: (self.maxWidth ?? 250) * 0.6)
        self.minimumInteritemSpacing = self.itemSpacing
        self.minimumLineSpacing = self.itemSpacing
        self.scrollDirection = .vertical
        self.spacingFactor = self.minimumInteritemSpacing / self.maxColumn
    }
    
    override func prepare() {
        self.calculateValues()
        let numberOfItems = self.collectionView?.numberOfItems(inSection: 0) ?? 0
        for i in 0 ..< numberOfItems {
            let indexPath = IndexPath(row: i, section: 0)
            if self.layoutInfo[indexPath] == nil {
                let itemAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                itemAttributes.frame = self.frameForItemAtIndexPath(indexPath)
                self.layoutInfo[indexPath] = itemAttributes
            }
        }
    }
    
    private func calculateValues() {
        guard self.maxWidth == nil else { return }
        let frameWidth = self.collectionView!.frame.width
        self.maxWidth = frameWidth - self.itemSpacing * 2
        let height = self.maxWidth! * 3 / 8
        self.minWidth = (self.maxWidth! / self.maxColumn) - self.spacingFactor
        self.maxHeight = (2 * height) - self.spacingFactor
        self.minHeight = height + self.spacingFactor
        self.standardHeight = (self.maxWidth! * 5 / 8) - self.spacingFactor
    }

    func frameForItemAtIndexPath(_ indexPath: IndexPath) -> CGRect {
        let validation = indexPath.row % 2 == 0
        var frame: CGRect
        if validation {
            if self.currentRow == 0 {
                frame = CGRect(x: self.xPosition, y: self.minYPosition, width: self.maxWidth!, height: self.standardHeight)
                self.maxYPosition = self.standardHeight
                self.minYPosition = self.standardHeight
            } else {
                let yPosition = self.minYPosition + self.minimumInteritemSpacing
                frame = CGRect(x: self.xPosition, y: yPosition, width: self.minWidth , height: self.minHeight)
                self.minYPosition = yPosition + self.minHeight
            }
        } else {
            let yPosition = self.maxYPosition + self.minimumInteritemSpacing
            frame = CGRect(x: self.xPosition, y: yPosition, width: self.minWidth , height: self.maxHeight)
            self.maxYPosition = yPosition + self.maxHeight
        }
        
        self.currentColumn = (self.currentColumn + 1) < self.maxColumn ? self.currentColumn + 1 : 0
        self.xPosition = validation ? 20 : (self.maxWidth! / 2) + (self.minimumInteritemSpacing * 1.5)
        if validation {
            if self.currentRow == 0 {
                self.currentColumn = 0
            }
            self.currentRow += 1
        }
        return frame
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.layoutInfo[indexPath]
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var allAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
        for (_, attributes) in self.layoutInfo {
            if rect.intersects(attributes.frame) {
                allAttributes.append(attributes)
            }
        }
        return allAttributes
    }
}

