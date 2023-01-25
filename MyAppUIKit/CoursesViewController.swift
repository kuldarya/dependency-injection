//
//  CoursesViewController.swift
//  APIKit
//

import UIKit

/// Bridging between APIKit and MyAppUIKit.
public protocol DataFetchable {
    func fetchCourseNames(completion: @escaping ([String]) -> Void)
}

public class CoursesViewController: UIViewController, UITableViewDataSource {
    let dataFetchable: DataFetchable

    var courses: [Course] = []

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "cell"
        )
        return table
    }()

    public init(dataFetchable: DataFetchable) {
        self.dataFetchable = dataFetchable
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        fatalError()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self

        /// `dataFetchable` is agnostic of APICaller, it's all good until we can provide its functionality.
        dataFetchable.fetchCourseNames { [weak self] names in
            self?.courses = names.map { Course(name: $0) }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = view.bounds
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = courses[indexPath.row].name
        return cell
    }
}
