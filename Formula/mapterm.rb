class Mapterm < Formula
  desc "Map in your terminal: OpenStreetMap vector tiles drawn with braille"
  homepage "https://mapterm.com"
  url "https://github.com/tlpinney/mapterm/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "f0ce03edf576893f7161d371b283dbe0e828ccc91312a62d88fbb3a6f7cd0fda"
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
