class Mapterm < Formula
  desc "Map in your terminal: OpenStreetMap vector tiles drawn with braille"
  homepage "https://mapterm.com"
  url "https://github.com/tlpinney/mapterm/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "be5144d57d1a10d2a2ed8371f557de5c7f554c2ee94fd05b9a32982665ab7c84"
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
