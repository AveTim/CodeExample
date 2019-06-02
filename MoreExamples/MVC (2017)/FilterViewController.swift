//
//  FilterViewController.swift
//  Code Example
//
//  Created by Tim on 13/2/17.
//  Copyright (c) 2017. All rights reserved.
//

import UIKit

/// DEMO
struct Item {
    var id: String
    var title: String
}

protocol FilterViewControllerOutput: class {
    func filterViewController(_ viewController: UIViewController, didSelect items: Set<String>)
}

class FilterViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet fileprivate weak var tableView: UITableView!

    // MARK: - Properties
    weak var output: FilterViewControllerOutput?

    fileprivate let searchController = UISearchController(searchResultsController: nil)

    fileprivate var items: [Item] = []
    fileprivate var itemsSearchResult: [Item] = []
    fileprivate var selectedItems: Set<String> = []

    fileprivate var isSearchActive: Bool = false

    // MARK: - Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupSearchController()
    }


    // MARK: - Public funcs
    func configure(_ items: [Item],
                   title: String,
                   selected: Set<String>?) {
        self.items = items
        self.selectedItems = selected ?? []
        self.title = title
    }

    // MARK: - Private funcs
    private func setup() {
        let cancelAction = UIBarButtonItem(title: L.strings.cancelAction,
                                           style: .plain,
                                           target: self,
                                           action: #selector(handleCloseAction))
        navigationItem.leftBarButtonItem = cancelAction

        let doneAction = UIBarButtonItem(title: L.strings.doneAction,
                                         style: .done,
                                         target: self,
                                         action: #selector(handleDoneAction))

        navigationItem.rightBarButtonItem = doneAction
    }

    fileprivate func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.setValue(L.strings.cancelAction, forKey:"_cancelButtonText")
        searchController.searchBar.placeholder = L.strings.search

        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
    }

    fileprivate func search(text: String) {
        guard text.count != 0 else {
            isSearchActive = false
            tableView.reloadData()
            return
        }
        let filteredArray = items.filter() {
            return $0.title.localizedCaseInsensitiveContains(text)
        }
        itemsSearchResult = filteredArray
        isSearchActive = true
        tableView.reloadData()
    }

    // MARK: Actions
    @objc private func handleCloseAction() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func handleDoneAction() {
        output?.filterViewController(self, didSelect: selectedItems)

        dismiss(animated: true, completion: nil)
    }
}


// MARK: - UITableViewDelegate
extension FilterViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterMultiSelectiveCell.identifier,
                                                 for: indexPath) as! FilterMultiSelectiveCell

        let selectedItem = isSearchActive ? itemsSearchResult[indexPath.row] : items[indexPath.row]
        cell.configure(title: selectedItem.title,
                       isSelected: selectedItems.contains(selectedItem.id))

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedID = isSearchActive ? itemsSearchResult[indexPath.row].id : items[indexPath.row].id
        if selectedItems.contains(selectedID) {
            selectedItems.remove(selectedID)
        } else {
            selectedItems.insert(selectedID)
        }

        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}


// MARK: - UITableViewDataSource
extension FilterViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? itemsSearchResult.count : items.count
    }
}


// MARK: - UISearchResultsUpdating, UISearchBarDelegate
extension FilterViewController: UISearchResultsUpdating, UISearchBarDelegate {

    func updateSearchResults(for searchController: UISearchController) {
        search(text: searchController.searchBar.text ?? "")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(text: searchController.searchBar.text ?? "")
    }
}
