class Skycast < Formula
  desc "Weather in your terminal: forecast, alerts, radar, sun and moon, and tides"
  homepage "https://github.com/tlpinney/skycast"
  # macOS uses the release's universal binary, signed with the maintainer's Developer ID and
  # notarized by Apple; Linux x86-64 uses the release's binary. Both SHA-256s match the
  # maintainer-signed SHA256SUMS on the GitHub release. Linux ARM builds from the tagged source.
  url "https://github.com/tlpinney/skycast/releases/download/v0.2.0/skycast-0.2.0-universal-apple-darwin.tar.gz"
  sha256 "85dcbb8929d79a4d669047bc785d42e0ae66250dadf92984150f4f940f113e85"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  head do
    url "https://github.com/tlpinney/skycast.git", branch: "main"
    depends_on "rust" => :build
  end

  on_linux do
    on_arm do
      url "https://github.com/tlpinney/skycast/archive/refs/tags/v0.2.0.tar.gz"
      sha256 "c5950a6e71a4ddb1c8a591c674002058428a9b3cd2d647d78a6102b6bbd8f635"
      depends_on "rust" => :build
    end
    on_intel do
      url "https://github.com/tlpinney/skycast/releases/download/v0.2.0/skycast-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "70fd9067a93f26f9869578188314b0bc4a5435b17a04dbf64b06d14b027069b9"
    end
  end

  def install
    if build.head? || (OS.linux? && Hardware::CPU.arm?)
      system "cargo", "install", *std_cargo_args
    else
      bin.install "skycast"
    end
  end

  test do
    # Offline check: the help text (everything else needs the network).
    assert_match "skycast - weather", shell_output("#{bin}/skycast --help")
  end
end
