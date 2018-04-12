//
//  WacanaSubjectsViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/11/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class DaftarMateriViewController: UIPageViewController {
    
    private var daftarMateri: [DaftarMateri] {
        return materiWacana.daftarMateri
    }
    
    var materiWacana: MateriWacana!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        setupBarButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = materiWacana.judul
    }
    
    func setupBarButtonItem() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "open_link"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(openWebLink)),]
    }
    
    @objc func openWebLink() {
        if let _ = URL(string: materiWacana.sumberUrl) {
            let vc = WebViewController(nibName: "WebViewController", bundle: nil)
            vc.title = materiWacana.judul
            vc.urlString = materiWacana.sumberUrl
            show(vc, sender: nil)
        } else {
            showError(title: "URL Tidak Sah", message: "Tidak dapat membuka situs dengan alamat \(materiWacana.sumberUrl)")
        }
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return daftarMateri.enumerated().map({ (materi) -> UIViewController in
            return self.newMateriViewController(materi.element, number: materi.offset)
        })
    }()
    
    private func newMateriViewController(_ materi: DaftarMateri, number: Int) -> UIViewController {
        let vc = MateriViewController(nibName: "MateriViewController", bundle: nil)
        vc.materi = materi
        vc.number = number
        return vc
    }
    
}

extension DaftarMateriViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}
