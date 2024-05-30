import Foundation

extension Version4.Public: Module {
    public struct Payload {
        static let signatureLength = Sign.Bytes

        public let message: Bytes
        public let signature: Bytes
    }
}

extension Version4.Public.Payload: Paseto.Payload {
    public var bytes: Bytes { return message + signature }

    public init? (bytes: Bytes) {
        let signatureOffset = bytes.count - Version4.Public.Payload.signatureLength

        guard signatureOffset > 0 else { return nil }

        self.init(
            message:   bytes[..<signatureOffset].bytes,
            signature: bytes[signatureOffset...].bytes
        )
    }
}
