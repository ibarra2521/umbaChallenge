//
//  HomeViewController+TableView.swift
//  Umba
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import UIKit

// MARK: - Data Source and Delegate TableView
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel.numberCategories
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: categoryID, for: indexPath) as? CategoryCell else { return UITableViewCell() }
        let category = viewModel.categories[indexPath.section]
        cell.updateCell(category: category)
        cell.didSelectMovie = { [weak self] (categoryCell, index) in
            guard let self = self else { return }
            if let idxPathSection = self.mainTableView.indexPath(for: categoryCell) {
                let idxPath = IndexPath(row: index, section: idxPathSection.section)
                self.selectMovie(indexPath: idxPath)
            }
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: CategoryHeader.self)) as? CategoryHeader else { return UIView() }
        let category = viewModel.categories[section]
        header.setTitle(category.title)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
}
