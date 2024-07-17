//
//  FolderViewController.swift
//  RemindEase
//
//  Created by MTPC-206 on 15/07/24.
//

import UIKit
import IGListKit
import RealmSwift

class FolderViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var folderViewModel = FolderViewModel()
    private var notificationToken: NotificationToken?
    var isLoading = false
    var hasMoreData = true
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObserver()
        
    }
    
    func setupUI() {
        self.title = "Folders"
        adapter.scrollViewDelegate = self
        adapter.collectionView = collectionView
        adapter.dataSource = self
        collectionView.register(UINib(nibName: "FolderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FolderCollectionViewCell")
    }
    
    func setupObserver() {
        Task {
            await loadData(with: 7)
        }
        folderViewModel.items = try? Realm().objects(Folder.self)
        notificationToken = folderViewModel.items?.observe { [weak self] changes in
            switch changes {
            case .initial, .update:
                self?.adapter.performUpdates(animated: true, completion: nil)
            case .error(let error):
                print(error)
            }
        }
    }
    
    private func loadData(with limit: Int) async {
        guard !isLoading && hasMoreData else { return }
        isLoading = true
        await folderViewModel.fetchFolders(with: limit)
        isLoading = false
        if (folderViewModel.items?.count ?? 0) % limit != 0 {
            hasMoreData = false
        }
        await adapter.performUpdates(animated: true)
        //adapter.performUpdates(animated: true, completion: nil)
    }
}


extension FolderViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        if folderViewModel.items == nil {
            return []
        } else {
            var objects: [ListDiffable] = Array(folderViewModel.items!) as [ListDiffable]
            if isLoading {
                objects.append(LoadingIndicator() as ListDiffable)
            }
            return objects
        }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        if object is LoadingIndicator {
            return LoadingSectionController()
        } else {
            return FolderSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height - 50 {
            Task { await loadData(with: 7) }
        }
    }
}

extension FolderViewController : UIScrollViewDelegate {
    
}
