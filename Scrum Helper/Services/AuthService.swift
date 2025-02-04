//
//  AuthService.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 01/02/2025.
//


import Foundation
import SwiftUICore


struct AuthService {
    static func login(email: String, password: String, completion: @escaping (String?, String?) -> Void) {
        guard let url = URL(string: "\(Constants.backendURL)/token") else {
            completion(nil, "Invalid URL")
            return
        }
        
        let parameters = ["email": email, "password": password, "device_name": "iOS"]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error?.localizedDescription ?? "Unknown error")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                print("Response: \(String(data: data, encoding: .utf8) ?? "")")
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let token = json["token"] as? String {
                        let trimmedToken = token.trimmingCharacters(in: .whitespacesAndNewlines)
                        let tokenParts = trimmedToken.split(separator: "|")
                        print(tokenParts[1])
                        DispatchQueue.main.async {
                            if tokenParts.count == 2 && tokenParts[1].count == 48 {
                                KeychainService.save(key: "authToken", value: String(tokenParts[1]))
                                completion(String(tokenParts[1]), nil)
                            } else {
                                completion(nil, "Invalid token format")
                            }
                        }
                    } else {
                        completion(nil, "Invalid response from server")
                    }
                } catch {
                    completion(nil, "Failed to parse response")
                }
            } else {
                completion(nil, "Invalid credentials")
            }
        }.resume()
    }
    
    
    static func logout(authState: AuthState, completion: @escaping (String?, String?) -> Void) {
        let token = KeychainService.retrieve(key: "authToken") ?? ""
        guard let url = URL(string: "\(Constants.backendURL)/revoke-token") else {
            completion(nil, "Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let parameters = ["token": token]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        print(String(data: request.httpBody!, encoding: .utf8) ?? "")
        print(request.allHTTPHeaderFields ?? "")
        print(request.httpMethod ?? "")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error?.localizedDescription ?? "Unknown error")
                return
            }
            print(String(data: data, encoding: .utf8) ?? "")
            if let httpResponse = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    if httpResponse.statusCode == 200 {
                        
                            authState.logout()
                            completion("Logged out", nil)
                        
                        print("Token revoked")
                    } else {
                        if httpResponse.statusCode == 401 {
                            
                                authState.logout()
                                completion("Already logged out", nil)
                            
                        }
                        print("Token revoke failed with status code: \(httpResponse.statusCode)")
                        completion(nil, "Token revoke failed. Status code: \(httpResponse.statusCode)")
                    }
                }
                
            } else {
                completion(nil, "Invalid response")
            }
        }.resume()
    }
    
    static func sendAuthenticatedRequest(url: String, params: [String: String] = [:], method: String? = "GET", completion: @escaping (String?, String?) -> Void) {
        let token = KeychainService.retrieve(key: "authToken") ?? ""
        guard let url = URL(string: "\(Constants.backendURL)\(url)") else {
            
                completion(nil, "Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
            request.httpMethod = method

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        if params != [:] {
            print(params)
            request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        }
        print(request)
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil, error?.localizedDescription ?? "Unknown error")
                }
                return
            }
            print(String(data: data, encoding: .utf8) ?? "")
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse {
                    DispatchQueue.main.async {
                        if httpResponse.statusCode == 200 {
                            
                            completion(String(data: data, encoding: .utf8), nil)
                            
                        } else {
                            
                            completion(nil, "Request failed with status code: \(httpResponse.statusCode)")
                            
                        }
                    }
                } else {
                    
                        completion(nil, "Invalid response")
                    
                }
            }
        }.resume()
    }
}
