//
//  PostEditorViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/29/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

fileprivate let textViewPlaceholder = "Deskripsikan foto kamu..."

protocol PostEditorDelegateViewController: class {
    func finishEditing(_ timelinePost: (image: UIImage, caption: String) )
}

class PostEditorViewController: UIViewController {
    
    @IBOutlet weak var viewOutlets: PostEditorView!
    
    weak var delegate: PostEditorDelegateViewController?
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtonItem()
        setupTextView()
        title = "Edit Post"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewOutlets.imageView.image = image
    }
    
    func setupBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Batal",
                                                           style: .plain,
                                                           target: self,
                                                           action: .cancel)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Kirim",
                                                            style: .done,
                                                            target: self,
                                                            action: .finishEdit)
    }
    
    func setupTextView() {
        let textView = viewOutlets.textView
        textView?.delegate = self
        textView?.text = textViewPlaceholder
        textView?.textColor = .lightGray
    }
    
    @objc func finishEdit() {
        let image = viewOutlets.imageView.image
        let caption = viewOutlets.textView.text
        delegate?.finishEditing((image!, caption!))
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
}

extension Selector {
    static let finishEdit = #selector(PostEditorViewController.finishEdit)
    static let cancel = #selector(PostEditorViewController.cancel)
}

class PostEditorView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
}

extension PostEditorViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == textViewPlaceholder)
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = textViewPlaceholder
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}
