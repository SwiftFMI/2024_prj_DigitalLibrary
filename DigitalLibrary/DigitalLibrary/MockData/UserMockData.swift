//
//  UserMockData.swift
//  DigitalLibrary
//
//  Created by Desislava D. Dimitrova on 25.01.24.
//

import Foundation

struct UserMockData {
    static let user: User = User(firstName: "Ivan",
                                 lastName: "Ivanov",
                                 email: "ivan.ivanov@gmail.com",
                                 phone: "+359 888 8888",
                                 password: "Pass1234!")

    static let users: [User] = [
        User(firstName: "Desislava",
             lastName: "Dimitrova",
             email: "desislava.dimitrova@gmail.com",
             phone: "+359 111 1111",
             password: "Pass1234!"),
        User(firstName: "Vasilka",
             lastName: "Terzieva",
             email: "vasilka.terzieva@gmail.com",
             phone: "+359 222 2222",
             password: "Pass1234!"),
        User(firstName: "Desislav",
             lastName: "Adamov",
             email: "desislav.adamov@gmail.com",
             phone: "+359 333 3333",
             password: "Pass1234!"),
        User(firstName: "Ognyan",
             lastName: "Yonchev",
             email: "ognyan.yonchev@gmail.com",
             phone: "+359 444 4444",
             password: "Pass1234!")
    ]
}
