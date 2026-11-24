class Mapterm < Formula
  desc "Map in your terminal: OpenStreetMap vector tiles drawn with braille"
  homepage "https://mapterm.com"
  url "https://github.com/tlpinney/mapterm/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "d535ef6d09b476b040a1a4e40def444f05e8d2014e4ec1894bcf678bc41f44b7"
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
