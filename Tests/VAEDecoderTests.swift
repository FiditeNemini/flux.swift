import MLX
import MLXFast
import MLXNN
import MLXRandom
import XCTest
import Hub

@testable import FluxSwift

final class VAEDecoderTests: XCTestCase {

    func testDecoder() async throws {
        let vaeConfig = VAEConfiguration()
        let vae = VAE(vaeConfig)
        let batchSize = 1
        let channels = 16
        let height = 128
        let width = 128
        let latents = MLXRandom.normal([batchSize, channels, height, width])

        let decodedOutput = vae.decode(latents: latents)

        XCTAssertEqual(
            decodedOutput.shape, [batchSize, 3, 1024, 1024], "Decoded output shape is incorrect")
    }

    func testEncoder() throws {
        let vaeConfig = VAEConfiguration()

        let vae = VAE(vaeConfig)

        let batchSize = 1
        let channels = 3
        let height = 1024
        let width = 1024
        let inputImage = MLXRandom.normal([batchSize, channels, height, width])

        let encodedOutput = vae.encode(latents: inputImage)

        XCTAssertEqual(
            encodedOutput.shape,
            [batchSize, 16, 128, 128],
            "Encoded output shape is incorrect"
        )
    }
}