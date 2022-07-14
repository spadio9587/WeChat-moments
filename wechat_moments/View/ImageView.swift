//
//  ImageView.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/7/14.
//

import UIKit

class ImageView: UIView {
    private var imageContent = [UIImageView]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadImage(from imageUrl: String?, callback: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            guard let imageUrl = imageUrl,
                  let url = URL(string: imageUrl),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async {
                callback(image)
            }
        }
    }
    
    public func setImage(tweet: Tweet) {
        updateImages(tweet.images)
    }
    
    func updateImages(_ images: [Image]?) {
        guard let images = images else {
            return
        }
        for index in images.indices {
            let imageView = UIImageView()
            loadImage(from: images[index].url) {image in
                imageView.image = image
            }
            imageContent.append(imageView)
        }
    }
    
    func configureImageView() {
        for imageView in imageContent {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .blue
        addSubview(imageView)
        }
    }
}
