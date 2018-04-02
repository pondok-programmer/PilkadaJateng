//
//  PostEditorViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/29/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

protocol PostEditorDelegate: class {
    func finishEditing(_ timelinePost: (image: UIImage, caption: String) )
}

class PostEditorViewController: UIViewController {
    
    @IBOutlet weak var viewOutlets: PostEditorView!
    
    weak var delegate: PostEditorDelegate?
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupFinishButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewOutlets.imageView.image = image
    }
    
    private func _setupFinishButton() {
        viewOutlets.finishButton
            .addTarget(self,
                       action: .finishEdit,
                       for: .touchUpInside)
    }
    
    @objc func finishEdit() {
        let image = viewOutlets.imageView.image
        let caption = viewOutlets.textField.text
        delegate?.finishEditing((image!, caption!))
        dismiss(animated: true, completion: nil)
    }
}

extension Selector {
    static let finishEdit = #selector(PostEditorViewController.finishEdit)
}

class PostEditorView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var finishButton: UIButton!
}
