//
//  DetailViewController.swift
//  Challenge1
//
//  Created by Olha Pylypiv on 10.01.2024.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var flags = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = (selectedImage as? NSString)?.deletingPathExtension.uppercased()
        //title = selectedImage
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        
        if let imageToLoad = selectedImage {
            if let image = UIImage(named: imageToLoad) {
                imageView.image = image.stroked
                
            }
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else
        {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, title ?? "Flag"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

extension UIImage {
  var stroked: UIImage? {
     let rect = CGRect(origin: .zero, size: size)
     UIGraphicsBeginImageContextWithOptions(size, false, 0)
     defer { UIGraphicsEndImageContext() }
     let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 1)
     bezierPath.addClip()
     bezierPath.lineWidth = 1
     draw(in: rect)
     guard let context = UIGraphicsGetCurrentContext() else { return nil }
     context.setStrokeColor(UIColor.lightGray.cgColor)
     bezierPath.lineWidth = 1
     bezierPath.stroke()
     return UIGraphicsGetImageFromCurrentImageContext() }
}
