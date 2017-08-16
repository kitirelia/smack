//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by kitiwat chanluthin on 8/16/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController{

    var avatarType = AvatarType.dark
    
    //Outlet
    @IBOutlet weak var segmentControll: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    @IBAction func segmentControlChange(_ sender: Any) {
        let selected = sender as! UISegmentedControl
        switch selected.selectedSegmentIndex {
        case 0:
            avatarType = AvatarType.dark
        case 1:
            avatarType = AvatarType.light
        default:
            avatarType = AvatarType.dark
        }
        collectionView.reloadData()
    }
    
    
    
}

extension AvatarPickerVC:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell{
            cell.configueCell(indexPath: indexPath.item, type: avatarType)
            
            return cell
        }
        return AvatarCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension AvatarPickerVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numberOfColumns :CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numberOfColumns = 4
        }
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 40
        let cellDimension = ((collectionView.bounds.width-padding)-(numberOfColumns-1)*spaceBetweenCells)/numberOfColumns
        
        return CGSize(width:cellDimension,height:cellDimension)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension AvatarPickerVC:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select at \(indexPath.item)")
        if avatarType == .dark{
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        }else{
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
}
