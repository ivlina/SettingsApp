//
//  ViewController.swift
//  SettingsApp
//
//  Created by Ivlina Moroshkina on 25.07.2021.
//

import UIKit

struct Section {
    let title: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    var isOn: Bool
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self,
                       forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self,
                       forCellReuseIdentifier: SwitchTableViewCell.identifier)
        
        return table
    }()
    
    var models = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        view.backgroundColor = UIColor.white
        navigationController?.title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configure() {
        models.append(Section(title: "General", options: [
            .switchCell(model: SettingsSwitchOption(title: "Авиарежим", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemOrange, handler: {
                                    
            }, isOn: true)),
            .staticCell(model: SettingsOption(title: "Wi-Fi", icon: UIImage(systemName: "wifi"), iconBackgroundColor: .systemBlue) {
                print("Нажата ячейка \("Wi-Fi")")
            }),
            .staticCell(model: SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "triangle"), iconBackgroundColor: .systemBlue) {
                print("Нажата ячейка \("Bluetooth")")
            }),
            .staticCell(model: SettingsOption(title: "Сотовая связь", icon: UIImage(systemName: "antenna.radiowaves.left.and.right"), iconBackgroundColor: .systemGreen) {
                print("Нажата ячейка \("Сотовая связь")")
            }),
            .staticCell(model: SettingsOption(title: "Режим модема", icon: UIImage(systemName: "personalhotspot"), iconBackgroundColor: .systemGreen) {
                print("Нажата ячейка \("Режим модема")")
            }),
            .switchCell(model: SettingsSwitchOption(title: "VPN", icon: UIImage(systemName: "triangle"), iconBackgroundColor: .systemBlue, handler: {
                                    
            }, isOn: true))
        ]))
        
        models.append(Section(title: "General", options: [
            .staticCell(model: SettingsOption(title: "Уведомления", icon: UIImage(systemName: "app.badge"), iconBackgroundColor: .systemRed) {
                print("Нажата ячейка \("Уведомления")")
            }),
            .staticCell(model:SettingsOption(title: "Звуки, тактильные сигналы", icon: UIImage(systemName: "speaker.wave.2.fill"), iconBackgroundColor: .systemPink) {
                print("Нажата ячейка \("Звуки, тактильные сигналы")")
            }),
            .staticCell(model:SettingsOption(title: "Не беспокоить", icon: UIImage(systemName: "moon.fill"), iconBackgroundColor: .systemIndigo) {
                print("Нажата ячейка \("Не беспокоить")")
            }),
            .staticCell(model:SettingsOption(title: "Экранное время", icon: UIImage(systemName: "hourglass"), iconBackgroundColor: .systemIndigo) {
                print("Нажата ячейка \("Экранное время")")
            })
        ]))
        
        models.append(Section(title: "Information", options: [
            .staticCell(model: SettingsOption(title: "Основные", icon: UIImage(systemName: "gear"), iconBackgroundColor: .systemGray) {
                print("Нажата ячейка \("Основные")")
            }),
            .staticCell(model:SettingsOption(title: "Пункт управления", icon: UIImage(systemName: "switch.2"), iconBackgroundColor: .systemGray) {
                print("Нажата ячейка \("Пункт управления")")
            }),
            .staticCell(model:SettingsOption(title: "Экран и яркость", icon: UIImage(systemName: "textformat.size"), iconBackgroundColor: .systemBlue) {
                print("Нажата ячейка \("Экран и яркость")")
            }),
            .staticCell(model:SettingsOption(title: "Экран \("Домой")", icon: UIImage(systemName: "apps.ipad"), iconBackgroundColor: .systemIndigo) {
                print("Нажата ячейка \("Домой")")
            }),
            .staticCell(model:SettingsOption(title: "Универсальный доступ", icon: UIImage(systemName: "figure.walk.circle"), iconBackgroundColor: .systemBlue) {
                print("Нажата ячейка \("Универсальный доступ")")
            })
        ]))
    }
    
    // i dont need these titles
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let section = models[section]
//        return section.title
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingTableViewCell.identifier,
                for: indexPath
            ) as? SettingTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        
        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell(let model):
            model.handler()
        }
    }

}


