//
//  EmojiView.swift
//  Swift_ChatTextInput
//
//  Created by hidetomo on 2019/07/21.
//  Copyright © 2019 Hidetomo Masuda. All rights reserved.
//

import UIKit

class EmojiView: UIView {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadNib()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadNib()
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadNib()
        setup()
    }
    
    // MARK: - Private method
    
    private func loadNib() {
        let nib = Bundle.main.loadNibNamed("EmojiView", owner: self, options: nil)
        guard let view = nib?.first as? UIView else {
            return
        }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    private func setup() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "EmojiViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "EmojiViewCell")
    }
}

// MARK: - UICollectionViewDataSource

extension EmojiView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiViewCell", for: indexPath) as? EmojiViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension EmojiView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped")
    }
}
