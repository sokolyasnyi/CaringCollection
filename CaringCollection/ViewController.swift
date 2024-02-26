//
//  ViewController.swift
//  CaringCollection
//
//  Created by Станислав Соколов on 25.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    lazy private var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()
    
    lazy private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 300, width: view.frame.width, height: 400),
                                              collectionViewLayout: layout)
//        collectionView.backgroundColor = .red
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var lastContentOffset = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Collection"
        self.title = "Collection"
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(collectionView)
//        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.delegate = self
        collectionView.dataSource = self
        layout.itemSize = CGSize(width: (collectionView.frame.width / 2) + 60, height: collectionView.frame.height - 20)
        
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
}

extension ViewController: UICollectionViewDelegate  {
    
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "cell"
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        if cell == nil {
            cell = UICollectionViewCell()
        }
        
        cell.backgroundColor = .lightGray
        cell.layer.cornerRadius = 12
        cell.layer.shouldRasterize = true
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == 10 - 1) {
            print(#function)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        print(#function)
        if section == 0 {
            return UIEdgeInsets(top: 0, left: collectionView.layoutMargins.left, bottom: 0, right: 0)
        }
        return .zero
    }
    
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print(#function)
        
        guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let cellWidthCludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthCludingSpacing
        let roundIndex = round(index)
        
        offset = CGPoint(x: roundIndex * cellWidthCludingSpacing - scrollView.contentInset.left,
                         y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
    }
}
                                
                                
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width / 2) + 60, height: collectionView.frame.height - 20)
    }
}

