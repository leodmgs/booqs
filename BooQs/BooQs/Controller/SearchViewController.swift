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
    
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var searchTextField: SearchTextField!
    @IBOutlet var searchViewContainer: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
            UINib(nibName: "SmallerPostPreviewCell", bundle: nil),
            forCellWithReuseIdentifier: "SmallerPostPreviewCell.id")
        collectionView.register(
            UINib(nibName: "PostPreviewHeaderCell", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "PostPreviewHeaderCell.id")
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
    
    private func updateSearchBarAspect(isEditing: Bool) {
        searchInputTrailingConstraint?.constant = isEditing ? -70 : 0
        UIView.animate(
            withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func performSearch(for query: String) {
        // TODO
        print("searching...")
    }
    
}

extension SearchViewController:
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postPreviewCell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: "SmallerPostPreviewCell.id", for: indexPath)
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
        return CGSize(width: screenWidth, height: 100)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableViewCell: UICollectionReusableView?
        if kind == UICollectionView.elementKindSectionHeader {
            reusableViewCell = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: "PostPreviewHeaderCell.id",
                for: indexPath)
        }
        if let cell = reusableViewCell {
            return cell
        }
        // FIXME
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
        if let searchText = textField.text, searchText.count > 0 {
            textField.resignFirstResponder()
            updateSearchBarAspect(isEditing: false)
            searchTextField.activateBasePlaceholder()
            performSearch(for: searchText)
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
}
