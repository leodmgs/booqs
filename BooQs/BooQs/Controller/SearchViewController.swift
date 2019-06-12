//
//  SearchViewController.swift
//  BooQs
//
//  Created by Leonardo Domingues on 5/31/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var isSearching: Bool = false
    var searchInputTrailingConstraint: NSLayoutConstraint?
    
    private var sellDatasource: BQDatasource = {
        let datasource = BQDatasource()
        return datasource
    }()
    
    private var borrowDatasource: BQDatasource = {
        let datasource = BQDatasource()
        return datasource
    }()
    
    private var donateDatasource: BQDatasource = {
        let datasource = BQDatasource()
        return datasource
    }()
    
    private var query: String? {
        didSet {
            guard let _ = query else { return }
            print("This feature isn't available at this moment.")
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
        }
    }
    
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var searchTextField: SearchTextField!
    @IBOutlet var searchViewContainer: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDatasource()
    }
    
    private func setupView() {
        searchInputTrailingConstraint =
            searchTextField.trailingAnchor.constraint(
                equalTo: cancelButton.trailingAnchor)
        searchInputTrailingConstraint?.constant = 0
        searchInputTrailingConstraint?.isActive = true
        
        searchViewContainer.layer.masksToBounds = false
        searchViewContainer.layer.shadowColor = UIColor.black.cgColor
        searchViewContainer.layer.shadowOpacity = 0.2
        searchViewContainer.layer.shadowOffset = .zero
        searchViewContainer.layer.shadowRadius = 5
        
        searchTextField.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(
            UINib(nibName: "PostPreviewCell", bundle: nil),
            forCellWithReuseIdentifier: "PostPreviewCell.id")
        
        collectionView.register(
            UINib(nibName: "PostGroupHeaderView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "PostGroupHeaderView.id")
    }
    
    private func setupDatasource() {
        let staticDatasource = StaticData()
        DispatchQueue.main.async {
            self.sellDatasource.add(collection: staticDatasource.postsToSell)
            self.donateDatasource.add(collection: staticDatasource.postsToDonate)
            self.borrowDatasource.add(collection: staticDatasource.postsToBorrow)
            self.collectionView.reloadData()
        }
    }

    @IBAction func onSearch(_ sender: Any) {
        isSearching = true
        updateSearchBarAspect(isEditing: isSearching)
        searchTextField.activateEditingPlaceholder()
    }
    
    
    @IBAction func onCancel(_ sender: Any) {
        isSearching = false
        updateSearchBarAspect(isEditing: isSearching)
        searchTextField.activateBasePlaceholder()
        searchTextField.endEditing(true)
    }
    
    private func setupCell(_ cell: PostPreviewCell,
                           _ indexPath: IndexPath) {
        var postObject: BQPost?
        switch indexPath.section {
        case 0:
            postObject = sellDatasource.index(at: indexPath.item)
        case 1:
            postObject = donateDatasource.index(at: indexPath.item)
        case 2:
            postObject = borrowDatasource.index(at: indexPath.item)
        default:
            print("Post doesn't recognized")
            return
        }
        guard let post = postObject else { return }
        if let bookPreview = post.imagePreview() {
            cell.postImageView.image = bookPreview
        }
        let postDesc = "\(post.book.title)\n\(String(describing: post.category))"
        cell.postTextView.text = postDesc
    }
    
    private func updateSearchBarAspect(isEditing: Bool) {
        searchInputTrailingConstraint?.constant = isEditing ? -70 : 0
        UIView.animate(
            withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}

extension SearchViewController:
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // (1) to sell; (2) to donate; and (3) to borrow.
        return 3
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return sellDatasource.count
        case 1:
            return donateDatasource.count
        case 2:
            return borrowDatasource.count
        default:
            return 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath)
        let postPreviewCell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: "PostPreviewCell.id", for: indexPath) as! PostPreviewCell
        setupCell(postPreviewCell, indexPath)
        return postPreviewCell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = (UIScreen.main.bounds.width / 2) - 26
        return CGSize(width: screenWidth, height: 220)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width - 26
        return CGSize(width: screenWidth, height: 120)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let reusableViewCell = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: "PostGroupHeaderView.id",
                for: indexPath) as! PostGroupHeaderView
            switch indexPath.section {
            case 0: // to sell
                reusableViewCell.headerTitleLabel.text = "You have a change to buy that book"
            case 1: // to donate
                reusableViewCell.headerTitleLabel.text = "It's time to be the next reading an amazing book"
            case 2: // to borrow
                reusableViewCell.headerTitleLabel.text = "Someone wants to share amazing books"
            default:
                reusableViewCell.headerTitleLabel.text = "A reader lives a thousand lives before he dies."
            }
            return reusableViewCell
        }
        return UICollectionReusableView()
    }
    
}


extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return isSearching
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
        return isSearching
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let searchToText = textField.text, searchToText.count > 0 {
            textField.resignFirstResponder()
            updateSearchBarAspect(isEditing: false)
            searchTextField.activateBasePlaceholder()
            self.query = searchToText
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
}
