//
//  WIPhotosViewController.swift
//  Wardrobezz
//
//  Created by Sophia Blitz on 5/16/18.
//  Copyright © 2018 Maharishi School. All rights reserved.
//

import UIKit

final class WIPhotosViewController: UICollectionViewController {
    
    // MARK: - Properties
    fileprivate let reuseIdentifier = "WIPhotoCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0) //TODO Delete not using from tutorial
    fileprivate var searches = [WISearchResults]()
    fileprivate var dataSource: WISearchResults!
    fileprivate var allWIs = [WardrobeItem]()
    fileprivate let itemsPerRow: CGFloat = 3
    //TODO create function equivalent to Flickr()
    @IBOutlet weak var sortByCtrl: UISegmentedControl!
    
    
    @IBAction func changeSortBy(_ sender: UISegmentedControl) {
        if sortByCtrl.selectedSegmentIndex == 0 {
            // date added
            getSearchResults()
            
        }
        else if sortByCtrl.selectedSegmentIndex == 1 {
            // last used
            var byLastUsed: [WardrobeItem]
            var wiPhotosSorted = [WIPhoto]()
            var newResults: WISearchResults
            byLastUsed = allWIs
            byLastUsed.sort(by: { $0.lastUsed.compare($1.lastUsed) == .orderedDescending })
            
            for item in byLastUsed {
                wiPhotosSorted.append(WIPhoto(photoID: "hat", wardrobeItem: item))
            }
            
            newResults = WISearchResults(searchTerm:"last used", searchResults:wiPhotosSorted)
            searches.insert(newResults, at: 0)
            dataSource = newResults
            self.collectionView?.reloadData()
            
        }
        else if sortByCtrl.selectedSegmentIndex == 2 {
            // last used
        }
    }
    
    override func viewDidLoad() {
        
        var item1 = WardrobeItem()
        var item2 = WardrobeItem()
        var item3 = WardrobeItem()
        
        item1.SetLastUsed(newLastUsedDate: Date(timeIntervalSinceNow: 10000))
        item2.SetLastUsed(newLastUsedDate: Date(timeIntervalSinceNow: 100000000))
        item3.SetLastUsed(newLastUsedDate: Date())
        
        item2.SetImage(newImage: UIImage(named:"blue hat")!)
        item3.SetImage(newImage: UIImage(named:"green hat")!)
        allWIs.append(item1)
        allWIs.append(item2)
        allWIs.append(item3)
        getSearchResults()
        
        
        // "search" for all wardrobe items
    }
    func getSearchResults(){
        var wiPhoto1 = WIPhoto(photoID: "rad hat", wardrobeItem: allWIs[0])
        var wiPhoto2 = WIPhoto(photoID: "blue hat", wardrobeItem: allWIs[1])
        var wiPhoto3 = WIPhoto(photoID: "green hat", wardrobeItem: allWIs[2])
        
        var newResults = WISearchResults(searchTerm:"all", searchResults:[wiPhoto1,wiPhoto2,wiPhoto3])
        searches.insert(newResults, at: 0)
        dataSource = newResults
        self.collectionView?.reloadData()
    }
}
// MARK: - Private
private extension WIPhotosViewController {
    func photoForIndexPath(indexPath: IndexPath) -> WIPhoto {
        return dataSource.searchResults[(indexPath as IndexPath).row]
    }
}
// MARK: - UICollectionViewDataSource
extension WIPhotosViewController {
    //1
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return dataSource.searchResults.count
    }
    
    //3
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! WIPhotoCell
        //2
        let wiPhoto = photoForIndexPath(indexPath: indexPath)
        cell.backgroundColor = UIColor.white
        //3
        cell.imageView.image = wiPhoto.image
        
        return cell
    }
}
extension WIPhotosViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
