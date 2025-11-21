class Vframetest < Formula
  desc "Professional media frame I/O benchmark and testing tool"
  homepage "https://github.com/ssotoa70/vframetest"
  url "https://github.com/ssotoa70/vframetest/archive/refs/tags/v25.11.21.tar.gz"
  sha256 "e6a8a25a5e1b1010c576c40cf6d17eb4be77d7c314d9a938725ddd301cfb2af3"
  license "GPL-2.0-or-later"

  depends_on "make" => :build

  def install
    system "make", "clean"
    system "make"
    bin.install "build/vframetest"
  end

  test do
    assert_match "vframetest 25.11.21", shell_output("#{bin}/vframetest --version")
  end
end
