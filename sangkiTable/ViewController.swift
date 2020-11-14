//
//  ViewController.swift
//  sangkiTable
//
//  Created by キム・サンギ on 2020/11/11.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    //위에 뒤에있는 두 개는 무언가를 구현해야 한다 - 밑에 두 함수
    
    @IBOutlet weak var TableViewMain: UITableView!
    
    //데이터 몇개?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //데이터가 무엇?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //반복 10번?
        //셀을 만드는 방법은 두 가지
        //1번 방법 - 임의의 셀 만들기
        
        //특정한 셀을 효율적으로 반복해서 사용한다
        //let cell = UITableViewCell.init(style: .default, reuseIdentifier: "TableCelType1")
        
        //2번 방법 - 스토리보드 + id
        //as? as!  as=부모와 자식간의 친자확인
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        
            
        //셀에 무엇을 보여준다
        //cell.textLabel?.text = "\(indexPath.row)"
        
        cell.LabelText.text = "\(indexPath.row)"
        
        return cell
    }
    
    //클릭시 함수 실행
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Click\(indexPath.row)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //셀프가 의미하는거는 클래스 안의 func을 의미
        TableViewMain.delegate = self
        TableViewMain.dataSource = self
    }

    
    //tableView 테이블로 된 뷰 - 여려개의 행이 모여있는 목록 뷰(화면)
    //목적 : 정갈하게 보여주려고 ex)전화번호부
    
    //1. 데이터가 무엇? - ex)전화번호부 목록
    //2. 데이터 몇개? - ex)100개
    //3. (옵션) 데이터 행 눌렀다 - ex)전화번호 클릭
    
    
}

