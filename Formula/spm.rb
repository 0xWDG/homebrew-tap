class Spm < Formula
  desc "Command-line companion for Swift Package Manager projects"
  homepage "https://github.com/0xWDG/spm"
  url "https://github.com/0xWDG/spm/archive/refs/tags/0.0.2.tar.gz"
  sha256 "2688da1ff1c7ca6a5700dda0c14c241b9b3d1f19401957371d79b18e3eb1aea3"
  license "MIT"

  depends_on xcode: ["16.0", :build]
  depends_on :macos

  uses_from_macos "swift"

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release", "--product", "spm"
    bin.install ".build/release/spm"

    generate_completions_from_executable bin/"spm", "completion"
  end

  test do
    system bin/"spm", "config", "init", "--no-color"
    assert_path_exists testpath/".spm/config.json"
    assert_match version.to_s, shell_output("#{bin}/spm --version")
  end
end
