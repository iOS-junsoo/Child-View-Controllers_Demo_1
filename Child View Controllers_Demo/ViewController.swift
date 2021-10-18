//
//  ViewController.swift
//  Child View Controllers_Demo
//
//  Created by 준수김 on 2021/10/18.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var firstChildVC = FirstChildViewController()
    private lazy var secondChildVC = SecondChildViewController()
    //lazy var: 처음 사용되기 전까지 연산되지 않다가 사용되는 순간 연산되는 변수
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true //스크롤 보기에 페이징이 활성화되었는지 여부를 결정하는 부울 값
        return scrollView
    }()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: view.frame.size.width*2, height: 0) //좌우 스크롤의 크기를 결정하는 부분
        view.addSubview(scrollView)
    }
    
    override func viewDidLayoutSubviews() {
        //래아어웃이 결정되고 나서 수행하는 메서드
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        addChildVCs()
    }
    
    private func addChildVCs() {
        addChild(firstChildVC)
        addChild(secondChildVC)
        //addChild: 해당 ViewController 내에 자식 ViewController를 추가해서 사용할 때 이용하는 메서드
        //즉, ViewController에 FirstChildViewController/SecondChildViewController를 자식으로 추가
        
        scrollView.addSubview(firstChildVC.view)
        scrollView.addSubview(secondChildVC.view)
        //ViewController의 View에 firstChildVC.view, secondChildVC.view 추가한다.
        
        //addChild VS addSubview: 전자는 각각의 ViewController에서 자신을 소유하고 있는 View에서 event를 관리한다. 후자는 하나의 ViewController에서 event를 관리한다.
        
        firstChildVC.view.frame = CGRect(x: 0,
                                         y: 0,
                                         width: scrollView.frame.size.width,
                                         height: scrollView.frame.size.height)
        secondChildVC.view.frame = CGRect(x: scrollView.frame.size.width,
                                          y: 0,
                                          width: scrollView.frame.size.width,
                                          height: scrollView.frame.size.height)
        
        firstChildVC.didMove(toParent: self)
        secondChildVC.didMove(toParent: self)
        //자식ViewController입장에서는 언제 부모ViewController추가 되는지 모르게 때문에 자식VC에 추가 및 제거 되는 시점을 알려주는 것 (willMove, didMove)
    }

    //MARK: 세그먼트 컨트롤러가 작동되면 이 메서드가 작동되어 어느 View를 선택했는지 알 수 있다.
    @IBAction func didChangeSegmentControlValue(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            //first
            scrollView.setContentOffset(.zero, animated: true) //스크롤이 되기 전 화면 기준으로 0이 시작 기준점이라는 뜻
        } else {
            //second
            scrollView.setContentOffset(CGPoint(x: view.frame.size.width, y: 0), animated: true) //스크롤 되기 전 이전 View 끝이 시작 기준점이라는 뜻
        }
    }
    
}

