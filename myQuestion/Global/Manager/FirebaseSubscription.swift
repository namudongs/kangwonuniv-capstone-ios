//
//  FirebaseSubscription.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/26.
//

import Foundation
import FirebaseFirestore
import Combine


class FirestoreSubscription<S: Subscriber, Model: Codable>: Subscription {
    private var subscriber: S?
    private var listener: ListenerRegistration? = nil
    init(subscriber: S) {
        self.subscriber = subscriber
        self.listener = nil
    }
    deinit {
        listener?.remove()
    }

    func request(_ demand: Subscribers.Demand) {
    }
    
    func cancel() {
        subscriber = nil
        listener?.remove()
        listener = nil
    }
}

extension FirestoreSubscription where S.Input == [Document<Model>], S.Failure == Error {
    convenience init(query: Query, subscriber: S) {
        self.init(subscriber: subscriber)
        self.listener = query.addSnapshotListener { snapshot, error in
            if let error = error {
                self.subscriber?.receive(completion: Subscribers.Completion.failure(error))
            } else {
                do {
                    let data = try snapshot!.documents.map { document -> Document<Model> in
                        let data = try document.data(as: Model.self, decoder: Firestore.Decoder())
                        return .init(ref: document.reference, data: data)
                    }
                    _ = self.subscriber?.receive(data)
                } catch {
                    self.subscriber?.receive(completion: Subscribers.Completion.failure(error))
                }
            }
        }
    }
}

extension FirestoreSubscription where S.Input == Document<Model>, S.Failure == Error {
    convenience init(documentRef: DocumentReference, subscriber: S) {
        self.init(subscriber: subscriber)
        self.listener = documentRef.addSnapshotListener { snapshot, error in
            if let error = error {
                self.subscriber?.receive(completion: Subscribers.Completion.failure(error))
            } else {
                do {
                    let data = try snapshot!.data(as: Model.self, decoder: Firestore.Decoder())
                    _ = self.subscriber?.receive(.init(ref: documentRef, data: data))
                } catch {
                    self.subscriber?.receive(completion: Subscribers.Completion.failure(error))
                }
            }
        }
    }
}
