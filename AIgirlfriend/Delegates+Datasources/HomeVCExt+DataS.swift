//
//  HomeVCExt+DataS.swift
//  AIgirlfriend
//
//  Created by netset on 12/07/23.
//

import Foundation
import UIKit
import SDWebImage

//MARK: - CollectionView DataSources
class HomeDataSource:NSObject,UICollectionViewDataSource {
    
    
    private var viewModel: HomeVM! = nil
    init(viewModel:HomeVM!) {self.viewModel = viewModel}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.homeBaseData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath) as HomeCVC
        let data = viewModel.homeBaseData?[indexPath.item]
        if let imageNameOrURL = data?.image {
            if let imageUrl = URL(string: "https://onlyfantasy-ai.ecomempire.in/media/characters/\(data?.image ?? "")") {
                cell.ImgVwAiUser.sd_setImage(with: imageUrl, completed: nil)
            } else if let image = UIImage(named: imageNameOrURL) {
                cell.ImgVwAiUser.image = image
            }
        }
        cell.lblAiUsername.text = "@\(data?.name ?? "")"
        cell.lblAiName.text = data?.name ?? ""
        cell.lblAiAssistant.text = "Your AI Assistant"
        return cell
    }
}

//MARK: - CollectionView Delegates
class HomeDelegate:NSObject,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    private var viewModel: HomeVM! = nil
    init(viewModel:HomeVM!) {self.viewModel = viewModel}
    var callBackDidSeclect:((_ detailDict:HomeBaseModel?)->())?
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        return CGSize(width: ((width/2) - 6), height: ((width/2) + 22))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = viewModel.homeBaseData?[indexPath.item]
        self.callBackDidSeclect?(selectedItem)
    }
}
