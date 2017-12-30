//
//  CollectionViewController.swift
//  swift-app
//
//  Created by Hendrik Van Heuverswyn on 28/12/2017.
//  Copyright © 2017 Hendrik Van Heuverswyn. All rights reserved.
//

import Foundation
import UIKit

class OptionsViewController: UICollectionViewController {
    // for performance: use a reuseIdentifier to use a cell as "base"
    fileprivate let reuseIdentifier = "optionCell"
    fileprivate let items: Int = 4
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsetsMake(50.0, 20.0, 50.0, 20.0)
    
}

extension OptionsViewController {
    // could have additional methods for sections
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items
    }
    override func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 'base' cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! OptionCell
        // setup custom content for base cell
        cell.backgroundColor = UIColor.white
        // border
        cell.layer.cornerRadius = 8
        cell.contentView.layer.masksToBounds = true;
        // shadow backdrop
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath

        // setup each cell, depending on index path
        switch indexPath.item {
        case 0:
            cell.itemLabel.text = "Statistieken"
            cell.imageView.image = UIImage(named: "statistics")
        case 1:
            cell.itemLabel.text = "Competitie"
            cell.imageView.image = UIImage(named: "trophy")
        case 2:
            cell.itemLabel.text = "Uitrusting"
            cell.imageView.image = UIImage(named: "inventory")
        case 3:
            cell.itemLabel.text = "Schietingen"
            cell.imageView.image = UIImage(named: "calendar")
        default:
            fatalError("Unknown cell")
        }
        return cell
    }
}

extension OptionsViewController: UICollectionViewDelegateFlowLayout {
    //extension with custom layout
    
    // responsible for size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // calc padding space (one extra for last item, double padding)
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        // how much space is left after padding
        let availableWidth = view.frame.width - paddingSpace
        // distribute available space
        let widthPerItem = availableWidth / itemsPerRow
        // squares
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    // responsible for spacing between cells/headers
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // spacing between each line
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.left
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            print("selected cell at: \(indexPath.item)")
            // start segue
        case 1:
            print("selected cell at: \(indexPath.item)")
            //start segue
        case 2:
            print("selected cell at: \(indexPath.item)")
            //start segue
        case 3:
            print("selected cell at: \(indexPath.item)")
            //start segue
        default:
            print("selected cell at: \(indexPath.item)")
        }
    }
}
