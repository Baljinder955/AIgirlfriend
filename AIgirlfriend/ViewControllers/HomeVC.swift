//
//  HomeVC.swift
//  AIgirlfriend
//
//  Created by netset on 07/07/23.
//

import UIKit

class HomeVC: UIViewController,UITabBarDelegate {
    
    //MARK: IBOutlet's
    @IBOutlet var vwProperties: HomeProperties!
    
    //MARK: Variable Declaration
    var objHomeVM = HomeVM()
    private var delegate:HomeDelegate!
    private var dataSource:HomeDataSource!
    private let refreshControl = UIRefreshControl()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        initializeViewDataSource()
        prepareUIMethod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        vwProperties.collectionView.refreshControl = refreshControl
        refreshControl.tintColor = .orange
        vwProperties.updateGreeting()
    }
    
    //MARK: DataSource + Delegates
    private func initializeViewDataSource(){
        dataSource = HomeDataSource(viewModel: objHomeVM)
        delegate = HomeDelegate(viewModel: objHomeVM)
        vwProperties.collectionView.delegate = delegate
        vwProperties.collectionView.dataSource = dataSource
        vwProperties.collectionView.reloadData()
        delegate.callBackDidSeclect = { (detailDict) in
            let viewController = getStoryboard(.main).instantiateViewController(withIdentifier: ViewControllers.profileVC) as! ProfileVC
            viewController.objHomeDataModel = detailDict
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    //MARK: - Custom Function
    private func prepareUIMethod() {
        vwProperties.objHomeDelegate = self
        callApi()
    }
    
    @objc func refreshData(_ sender: Any) {
        callApi()
        refreshControl.endRefreshing()
    }
}
