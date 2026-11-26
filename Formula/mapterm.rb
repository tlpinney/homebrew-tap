class Mapterm < Formula
  desc "Map in your terminal: vector tiles, imagery, live aircraft, ships, weather"
  homepage "https://mapterm.com"
  # The release's binaries: on macOS one universal binary, signed with the maintainer's
  # Developer ID and notarized by Apple; on Linux, x86-64 and ARM64. Their SHA-256s are the
  # ones in the release's maintainer-signed SHA256SUMS.
  url "https://github.com/tlpinney/mapterm/releases/download/v0.5.0/mapterm-0.5.0-universal-apple-darwin.tar.gz"
  sha256 "21c0e4b84cfd5e801b571846f0d819d202f488b2404687419a6101e62e9ce04a"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  head do
    url "https://github.com/tlpinney/mapterm.git", branch: "main"
    depends_on "rust" => :build
  end

  on_linux do
    on_arm do
      url "https://github.com/tlpinney/mapterm/releases/download/v0.5.0/mapterm-0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "032928d612e9d27cb4a02675bb5516add1bd9853b25668102d08aaa15e22c915"
    end
    on_intel do
      url "https://github.com/tlpinney/mapterm/releases/download/v0.5.0/mapterm-0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a113df2ec335fd62482a665853aabcab73cbfb83f9154d6e3a618522cfaef8ba"
    end
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args
    else
      bin.install "mapterm"
      doc.install "THIRD_PARTY_LICENSES.txt", "JetBrainsMono-OFL.txt"
    end
  end

  test do
    # Offline checks: the version, the help text and the built-in raster provider list.
    assert_match "mapterm 0.5.0", shell_output("#{bin}/mapterm --version")
    assert_match "esri", shell_output("#{bin}/mapterm --raster-list")
  end
end
