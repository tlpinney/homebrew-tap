class Skycast < Formula
  desc "Weather in your terminal: forecast, alerts, radar, sun and moon, and tides"
  homepage "https://github.com/tlpinney/skycast"
  # Linux x86-64 uses the release's prebuilt binary (its SHA-256 matches the maintainer-signed
  # SHA256SUMS on the GitHub release); everything else builds from the tagged source.
  url "https://github.com/tlpinney/skycast/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f76f649fb65cc75d988a08d749901044bc326978d5e6d933b096e6a19aa733c4"
  license "MIT"
  head "https://github.com/tlpinney/skycast.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    depends_on "rust" => :build
  end

  on_linux do
    on_arm do
      depends_on "rust" => :build
    end
    on_intel do
      url "https://github.com/tlpinney/skycast/releases/download/v0.1.0/skycast-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3783ec24648e43f9ade9b53dc4b2484d91ca397530d6b80cb841deadd8b1c006"
    end
  end

  def install
    if OS.linux? && Hardware::CPU.intel? && !build.head?
      bin.install "skycast"
    else
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    # Offline check: the help text (everything else needs the network).
    assert_match "skycast - weather", shell_output("#{bin}/skycast --help")
  end
end
