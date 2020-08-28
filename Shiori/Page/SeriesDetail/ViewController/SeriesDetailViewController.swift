//
//  SeriesDetailViewController.swift
//  Shiori
//
//  Created by hikinit on 26/08/20.
//

import UIKit

class SeriesDetailViewController: UITableViewController, ViewControllerWithStoryboard {
  private var headerView: SeriesDetailHeaderView!
  @IBAction func trashDidTap(_ sender: UIBarButtonItem) {
    deleteSeries()
  }

  @IBAction func addDidTap(_ sender: UIBarButtonItem) {
    addBookmark()
  }

  var series: Series!
  var viewModel: SeriesDetailViewModel!
  var kindPickerDataSource: PickerDataSource!

  lazy var imagePicker: UIImagePickerController  = {
    let imagePicker = UIImagePickerController()
    imagePicker.allowsEditing = false
    imagePicker.delegate = self
    imagePicker.sourceType = .photoLibrary

    return imagePicker
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViewModel()
    setupView()
  }

  // MARK: - Setup View
  private func setupView() {
    let headerViewSize = CGSize(width: tableView.bounds.width, height: 220)
    headerView = SeriesDetailHeaderView(frame: CGRect(origin: .zero, size: headerViewSize))

    tableView.tableHeaderView = headerView
    tableView.register(BookmarkCellView.self, forCellReuseIdentifier: viewModel.cellId)

    navigationItem.largeTitleDisplayMode = .never
    addCoverImageGesture()
  }

  override func viewWillAppear(_ animated: Bool) {
    viewModel.reloadDataSource()

    fillUI()
  }

  private func fillUI() {
    headerView.setup(with: viewModel.headerViewModel)
  }

  // MARK: - Actions
  private func deleteSeries() {
    let deleteAlert = AlertBuilder(style: .alert)
      .setTitle("Delete Confirmation")
      .setMessage("Are you sure you want to delete \(viewModel.headerViewModel.title)?")
      .addDestructiveAction("I want to Delete") { [weak self] _ in
        self?.viewModel.deleteThisSeries {
          guard $0 else { return }
          self?.navigationController?.popViewController(animated: true)
        }
      }
      .build()

    present(deleteAlert, animated: true)
  }

  private func addCoverImageGesture() {
    let gesture = UITapGestureRecognizer(target: self, action: #selector(imageDidTap))
    headerView.coverImageView.isUserInteractionEnabled = true
    headerView.coverImageView.addGestureRecognizer(gesture)
  }

  @objc private func imageDidTap() {
    let alert = AlertBuilder(style: .actionSheet)
      .setTitle("Cover for \(viewModel.headerViewModel.title)")
      .addDefaultAction("Change") { _ in
        self.headerView.coverImageActivityView.startAnimating()
        self.present(self.imagePicker, animated: true)
      }
      .addDestructiveAction("Delete") { _ in
        self.viewModel.deleteCover()
        self.fillUI()
      }
      .build()

    present(alert, animated: true)
  }

  // MARK: - View Model
  func setupViewModel() {
    viewModel = SeriesDetailViewModel(library: Library.shared, series: series)
  }
}

// MARK: - Segue
extension SeriesDetailViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "SeriesFormViewController":
      guard let nav = segue.destination as? UINavigationController,
            let vc = nav.topViewController as? SeriesFormViewController
      else { return }

      vc.series = viewModel.series
    default:
      break
    }
  }
}

extension SeriesDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.originalImage] as? UIImage else { return }

    headerView.coverImageView.image = image
    headerView.backgroundImageView.image = image

    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let id = viewModel.series.id!.uuidString
    let fileURL = documentsDirectory.appendingPathComponent("\(id).jpg")

    if let data = image.jpegData(compressionQuality: 0.9) {
      do {
        try data.write(to: fileURL)
        viewModel.saveSeriesCover(url: fileURL)
      } catch {
        return
      }
    }

    headerView.coverImageActivityView.stopAnimating()
    dismiss(animated: true)
  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    headerView.coverImageActivityView.stopAnimating()
    dismiss(animated: true)
  }
}
