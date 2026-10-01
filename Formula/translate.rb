class Translate < Formula
  desc "Native macOS command-line translator using Apple’s Translation framework"
  homepage "https://github.com/0xWDG/Translate"
  url "https://github.com/0xWDG/Translate/archive/refs/tags/0.1.0.tar.gz"
  sha256 "280774b5f737d6a4c1237cf7a38dd441cb0993851519229956a6789b27a40409"

  depends_on xcode: ["26.0", :build]
  depends_on :macos

  uses_from_macos "swift"

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release", "--product", "translate"
    bin.install ".build/release/translate"
  end

  test do
    output = shell_output("#{bin}/translate -available")
    assert_match "Supported translation languages", output
  end
end
