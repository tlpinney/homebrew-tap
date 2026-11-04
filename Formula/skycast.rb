class Skycast < Formula
  desc "Weather in your terminal: forecast, alerts, radar, sun and moon, and tides"
  homepage "https://github.com/tlpinney/skycast"
  # macOS uses the release's universal binary, signed with the maintainer's Developer ID and
  # notarized by Apple; Linux x86-64 uses the release's binary. Both SHA-256s match the
  # maintainer-signed SHA256SUMS on the GitHub release. Linux ARM builds from the tagged source.
  url "https://github.com/tlpinney/skycast/releases/download/v0.1.0/skycast-0.1.0-universal-apple-darwin.tar.gz"
  sha256 "e70242ecef9111510842f867d7870c7fa348d2bd4d5c87302fcac66329de1aab"
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
      url "https://github.com/tlpinney/skycast/archive/refs/tags/v0.1.0.tar.gz"
      sha256 "f76f649fb65cc75d988a08d749901044bc326978d5e6d933b096e6a19aa733c4"
      depends_on "rust" => :build
    end
    on_intel do
      url "https://github.com/tlpinney/skycast/releases/download/v0.1.0/skycast-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3783ec24648e43f9ade9b53dc4b2484d91ca397530d6b80cb841deadd8b1c006"
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
