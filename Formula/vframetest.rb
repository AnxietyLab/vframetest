class Vframetest < Formula
  desc "Professional media frame I/O benchmark and testing tool"
  homepage "https://github.com/ssotoa70/vframetest"
  url "https://github.com/ssotoa70/vframetest/archive/refs/tags/v25.11.22.tar.gz"
  sha256 "PLACEHOLDER"
  license "GPL-2.0-or-later"

  depends_on "make" => :build

  def install
    system "make", "clean"
    system "make"
    bin.install "build/vframetest"
  end

  test do
    assert_match "vframetest 25.11.22", shell_output("#{bin}/vframetest --version")
  end
end
