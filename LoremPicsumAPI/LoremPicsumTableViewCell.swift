//
//  LoremPicsumTableViewCell.swift
//  LoremPicsumAPI
//
//  Created by Field Employee on 12/10/20.
//

import UIKit

class LoremPicsumTableViewCell: UITableViewCell {
    @IBOutlet weak var loremPicsumImageView: UIImageView!
    @IBOutlet weak var loremPicsumNameLabel: UILabel!
    func configure(with loremPicsum: LoremPicsum) {
        self.loremPicsumNameLabel.text = loremPicsum.id
        NetworkingManager.shared.getImageData(from:
        loremPicsum.download_url) { (data, error) in
        guard let data = data else { return }
            DispatchQueue.main.async {
                self.loremPicsumImageView.image = UIImage(data:data)
            }
        }
    }
}
