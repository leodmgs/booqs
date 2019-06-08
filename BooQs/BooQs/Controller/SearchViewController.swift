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
    
    private var datasource: BQDatasource = {
        let datasource = BQDatasource()
        return datasource
    }()
    
    private var query: String? {
        didSet {
            guard let _ = query else { return }
            
            let user1 = BQUser(
                name: "José da Silva", phone: "9876-5432",
                address: BQAddress(
                    street: "Rua dois", number: 225,
                    district: "Centro",
                    city: "João Pessoa",
                    state: "PB", zipCode: "58012-345"), posts: Array<BQPost>())
            
            let user2 = BQUser(
                name: "Maria de Oliveira", phone: "9988-7766",
                address: BQAddress(
                    street: "Rua três", number: 1772,
                    district: "Jardim",
                    city: "João Pessoa",
                    state: "PB", zipCode: "58011-222"), posts: Array<BQPost>())
            
            var imagesBook1 = Array<UIImage>()
            imagesBook1.append(UIImage(named: "coding")!)
            
            var imagesBook2 = Array<UIImage>()
            imagesBook2.append(UIImage(named: "algorithms")!)
            
            let book1 = BQBook(
                title: "Cracking the Coding Interview",
                isbn: "817-6-817263-8-7", images: imagesBook1)
            
            let book2 = BQBook(
                title: "Algorihtms",
                isbn: "123-4-567890-1-2", images: imagesBook2)
            
            let post1 = BQPost(
                id: "1", user: user1, book: book1,
                category: BQPost.Category.sell)
            
            let post2 = BQPost(
                id: "2", user: user2, book: book2,
                category: BQPost.Category.donate)
            
            datasource.add(element: post1)
            datasource.add(element: post2)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
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
            UINib(nibName: "PostPreviewCell", bundle: nil),
            forCellWithReuseIdentifier: "PostPreviewCell.id")
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
    
    private func setupCell(_ cell: PostPreviewCell,
                           _ indexPath: IndexPath) {
        guard let post = datasource.index(at: indexPath.item) else {
            return
        }
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
