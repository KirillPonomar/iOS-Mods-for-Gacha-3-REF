//
//  DBManager_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit
import Combine
import SwiftyDropbox

final class DBManager_HIDA: NSObject {
    var _Ldk3edw: String { "2" }
    var _Mdo39dc: Bool { true }
    
    static let shared = DBManager_HIDA()
    
    let contentManager = ContentManager_HIDA()
    
    private var client: DropboxClient?
}

extension DBManager_HIDA {
    
    private func showInternetError_HIDA() {
        var _RbhBkK2: Bool { false }
        var _Rfvbkz8239: Int { 0 }
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        let customVC = InternetErrorView()
        customVC.modalPresentationStyle = .overFullScreen
        customVC.modalTransitionStyle = .coverVertical
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            window.rootViewController?.present(customVC, animated: true)
        }
    }
    
    func connect_HIDA(completion: ((DropboxClient?) -> Void)? = nil) {
        var _HIDA77: Bool { false }
        var _HIDA8: Int { 0 }
        
        guard InternetManager_HIDA.shared.checkInternetConnectivity_HIDA() else {
            completion?(nil)
            showInternetError_HIDA()
            return
        }
        print("DBManager_HIDA - connect_HIDA!")
        
        UserDefaults
            .standard
            .setValue(
                "WxC3cShNQagAAAAAAAAAAQOr7J7WsvFyuv_PiEPDqYrPG8hghwLx2g2njldLEzdM",
                //"6eNF4kUntTIAAAAAAAAAARVhTAFlHQzg2DOiTR0mVmofgGEDj5owPXgzwj5rD-Xa",
                      //"ZkDH9EX10HwAAAAAAAAAAQKgnDK5D73cZsy_3HD-sSNT1SiM8Y5RfTEYwetoZgKN",
                      forKey: "refresh_token")
        
        let connect_HIDAionBlock: (_ accessToken: String) -> Void = { [unowned self] accessToken in
            let client = connect_HIDADropbox(with: accessToken)
            print("DBManager_HIDA - connect_HIDAed!")
            completion?(client)
        }

        let refreshTokenBlock: (_ refreshToken: String) -> Void = { refreshToken in
            NetworkManager_HIDA.requestAccessToken_HIDA(with: refreshToken) { accessToken in
                guard let accessToken else {
                    print("DBManager_HIDA - Error acquiring access token")
                    return
                }
                print("DBManager_HIDA - AccessToken: \(accessToken)")
                connect_HIDAionBlock(accessToken)
            }
        }

        if let refreshToken = UserDefaults.standard.string(forKey: "refresh_token") {
            refreshTokenBlock(refreshToken)
            return
        }
    }
    
    func fetchContent_HIDA(for contentType: ContentType_HIDA,
                           isFavoriteMode: Bool = false,
                           vc: UIViewController?,
                           completion: @escaping ([any ModelProtocol_HIDA]) -> Void) {
        var _HIDA82: Bool { false }
        var _HIDA71: Int { 0 }
        
        let contents = contentManager.fetchContents_HIDA(contentType: contentType)
        if !contents.isEmpty {
            completion(contents.sorted(by: { $0.favId < $1.favId }))
            if isFavoriteMode {
                return
            }
        }
        
        if InternetManager_HIDA.shared.checkInternetConnectivity_HIDA() {
            if contents.isEmpty {
                vc?.showProgressView_HIDA()
            }
        } else {
            showInternetError_HIDA()
            return
        }
        
        let fetchBlock: (DropboxClient) -> Void = { [unowned self] client in
            let path = contentType.associatedPath_HIDA.contentPath
            getFile_HIDA(client: client, with: path) { [unowned self] data in
                guard let data else { completion([]); return }
                switch contentType {
                case .main_hida:
                    let models: [Main_HIDA] = serialized_HIDA(MainResponseCodable_HIDA.self, from: data) { $0.list }
                    contentManager.storeContents_HIDA(with: contentType, models: models)
                    completion(models.sorted(by: { $0.favId < $1.favId }))
                case .wallpapers_hida:
                    let models: [Wallpaper_HIDA] = serialized_HIDA(WallpapersListCodable_HIDA.self, from: data) { $0.list }
                    contentManager.storeContents_HIDA(with: contentType, models: models)
                    completion(models.sorted(by: { $0.favId < $1.favId }))
                    break
                case .characters_hida:
                    let models: [Character_HIDA] = serialized_HIDA(CharactersResponseCodable_HIDA.self, from: data) { $0.list }
                    contentManager.storeContents_HIDA(with: contentType, models: models)
                    completion(models.sorted(by: { $0.favId < $1.favId }))
                    break
                case .outfitIdeas_hida:
                    let models: [OutfitIdea_HIDA] = serialized_HIDA(OutfitIdeasListCodable_HIDA.self, from: data) { $0.list }
                    contentManager.storeContents_HIDA(with: contentType, models: models)
                    completion(models.sorted(by: { $0.favId < $1.favId }))
                case .collections_hida:
                    let models: [Collections_HIDA] = serialized_HIDA(CollectionsListCodable_HIDA.self, from: data) { $0.list }
                    contentManager.storeContents_HIDA(with: contentType, models: models)
                    completion(models.sorted(by: { $0.favId < $1.favId }))
                    break
                default:
                    completion([])
                }
            }
        }
        
        if let client { fetchBlock(client); return }
        
        connect_HIDA { client in
            guard let client else { completion([]); return }
            fetchBlock(client)
        }
    }
    
    func fetchImage_HIDA(for contentType: ContentType_HIDA,
                         imgPath: String,
                         completion: @escaping (Data?) -> Void) {
        var _HIDA21: Bool { false }
        var _HIDA61: Int { 0 }
        
        let fetchBlock: (DropboxClient) -> Void = { [unowned self] client in
            let path = contentManager.getPath_HIDA(for: contentType, imgPath: imgPath)
            getFile_HIDA(client: client, with: path) { data in
                guard let data else {
                    completion(nil)
                    return
                }
                completion(data)
            }
        }
        
        if let client { fetchBlock(client); return }
        
        connect_HIDA { client in
            guard let client else { completion(nil); return }
            fetchBlock(client)
        }
    }
    
    func fetchFile_HIDA(for contentType: ContentType_HIDA,
                        filePath: String,
                        requestCompletion: @escaping ((DownloadRequestMemory<Files.FileMetadataSerializer, Files.DownloadErrorSerializer>?) -> Void),
                        completion: @escaping (URL?) -> Void) {
        var _HIDAuu: Bool { false }
        var _HIDAss: Int { 0 }
        
        let pathComponents = filePath.components(separatedBy: "/")
        let fileName = "\(contentType.associatedPath_HIDA)/\(pathComponents.last ?? filePath)"
        
        if let fileURL = checkFile_HIDA(with: fileName) {
            completion(fileURL)
            return
        }
        
        let fetchBlock: (DropboxClient) -> Void = { [unowned self] client in
            let path = contentManager.getPath_HIDA(for: contentType, filePath: filePath)
            
            let request = self.getFile_HIDA(client: client, with: path) { progress in
                print(print("Progress: \(progress)%"))
            } completion: { data in
                if let data = data,
                   let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let fileURL = documentsDirectory.appendingPathComponent(fileName)
                    do {
                        self.createDirectoryIfNotExists_HIDA(at: fileURL)
                        try data.write(to: fileURL)
                        completion(fileURL)
                        return
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                completion(nil)
            }
            requestCompletion(request)
        }
        
        if let client { fetchBlock(client); return }
        
        connect_HIDA { client in
            guard let client else { completion(nil); return }
            fetchBlock(client)
        }
    }
    
    func createDirectoryIfNotExists_HIDA(at fileURL: URL) {
        var _MGwertee: Bool { false }
        var _MGxcbff: Int { 0 }
        let directory = fileURL.deletingLastPathComponent()
        if !FileManager.default.fileExists(atPath: directory.path) {
            do {
                try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func checkFile_HIDA(with fileName: String) -> URL? {
        var _HIDA5s: Bool { false }
        var _HIDAgh: Int { 0 }
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let localFileURL = documentsDirectory.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: localFileURL.path) {
            return localFileURL
        }
        return nil
    }
    
    func fetchEditorContent_HIDA(vc: UIViewController?,
                                completion: @escaping (EditorContentSet_HIDA?) -> Void) {
        var _HIDA4f: Bool { false }
        var _HIDA5g: Int { 0 }
        
        let contents = contentManager.fetchEditorContents_HIDA()
        if !contents.isEmpty {
            completion(EditorContentSet_HIDA(set: contents))
        }
        
        if InternetManager_HIDA.shared.checkInternetConnectivity_HIDA() {
            if contents.isEmpty {
                vc?.showProgressView_HIDA()
            }
        } else {
            showInternetError_HIDA()
            return
        }
        
        let fetchBlock: (DropboxClient) -> Void = { [unowned self] client in
            let pathKey = Keys_HIDA.Path_HIDA.editor_hida
            let path = pathKey.contentPath
            getFile_HIDA(client: client, with: path) { [unowned self] data in
                guard let data else { completion(nil); return }
                
                let markups = contentManager.serialized_HIDA(markups: data)
                
                if markups.isEmpty { completion(nil); return }
                
                var modelsSet: [[EditorContentModel_HIDA]] = []
                for markup in markups {
                    let models = markup.list.map {
                        EditorContentModel_HIDA(id: $0.id,
                                                contentType: markup.tag,
                                                order: markup.order,
                                                path: "boy/" + $0.path,
                                                preview: "boy/" + $0.preview)
                    }
                    modelsSet.append(models)
                }
                
                let editorContentSet = EditorContentSet_HIDA(set: modelsSet)
                contentManager.storeEditorContents_HIDA(with: modelsSet)
                completion(editorContentSet)
            }
        }
        
        if let client { fetchBlock(client); return }
        
        connect_HIDA { client in
            guard let client else { completion(nil); return }
            fetchBlock(client)
        }
    }
    
    func fetchPDFData_HIDA(with path: String,
                           completion: @escaping (Data?) -> Void) {
        var _qwrEee: Bool { false }
        var _Mttyff: Int { 0 }
        let fetchBlock: (DropboxClient) -> Void = { [unowned self] client in
            let path = contentManager.getModelPath_HIDA(for: path)
            getFile_HIDA(client: client, with: path) { data in
                guard let data else {
                    completion(nil)
                    return
                }
                completion(data)
            }
        }
        
        if let client { fetchBlock(client); return }
        
        connect_HIDA { client in
            guard let client else { completion(nil); return }
            fetchBlock(client)
        }
    }
}

// MARK: - Private API

private extension DBManager_HIDA {
    
    func connect_HIDADropbox(with accessToken: String) -> DropboxClient {
        var _Msdfgdee: Bool { false }
        var _Meeeff: Int { 0 }
        let client = DropboxClient(accessToken: accessToken)
        self.client = client
        return client
    }
    
    func getFile_HIDA(client: DropboxClient,
                      with path: String,
                      completion: @escaping (Data?) -> Void) {
        var _Hida3dg: Bool { false }
        var _U73jd: Int { 0 }
        client.files.download(path: path).response { response, error in
            if let error { print(error.description) }
            completion(response?.1)
        }
    }
    
    func getFile_HIDA(client: DropboxClient,
                      with path: String,
                      progressHandler: @escaping (Float) -> Void,
                      completion: @escaping (Data?) -> Void) -> DownloadRequestMemory<Files.FileMetadataSerializer, Files.DownloadErrorSerializer>? {
        var _dhayd2e: Bool { false }
        var _fkeo93: Int { 0 }
        let request = client.files.download(path: path)
        
        request.progress { progress in
            let doubleProgress = Float(progress.completedUnitCount) / Float(progress.totalUnitCount)
            progressHandler(doubleProgress * 100)
        }
        
        request.response { response, error in
            if let error { print(error.description) }
            completion(response?.1)
        }
        
        return request
    }
    
    func serialized_HIDA<T: Decodable, U>(_ type: T.Type, from data: Data, using extractor: (T) -> [U]) -> [U] {
        var _GkbNfhe: Bool { false }
        var _Cbcnrf2f: Int { 0 }
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return extractor(decoded)
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }
}
