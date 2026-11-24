class Mapterm < Formula
  desc "Map in your terminal: OpenStreetMap vector tiles drawn with braille"
  homepage "https://mapterm.com"
  url "https://github.com/tlpinney/mapterm/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "09dfdde303391986d2f2c6d3e1864dc906932658d376b47d70f9e1c2e152bd09"
  license "MIT"
  head "https://github.com/tlpinney/mapterm.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # Offline checks: the help text and the built-in raster provider list.
    assert_match "esri", shell_output("#{bin}/mapterm --raster-list")
    assert_match "mapterm", shell_output("#{bin}/mapterm --help")
  end
end
