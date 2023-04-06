import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["fileName"] = "aviato.png"
    request["fileSize"] = 18843
    request["uploadId"] = "<RANDOM ID>"
    var content = Data(contentsOfFile: "aviato.png")
    client.uploadMedia(withRequest: request, content: content, handler: { (request, response, error) in
        let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
    })
  }
