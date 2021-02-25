class Freerdp < Formula
  desc "X11 implementation of the Remote Desktop Protocol (RDP)"
  homepage "https://www.freerdp.com/"
  url "https://github.com/FreeRDP/FreeRDP/archive/2.3.0.tar.gz"
  sha256 "4537b9d2c10f4a249b471ab523bd58c47f8c88fa8da84feaafbe80fa44b335b2"
  license "Apache-2.0"

  bottle do
    sha256 arm64_big_sur: "8cfd66b03f01827edc1e2241478db3a22c62e4a1d12ae5d52591d4aa47df51b2"
    sha256 big_sur:       "e1d225ab20d2dddccfd79de4a0e4cb8c2f4be96eea05d3440f93351e616fe185"
    sha256 catalina:      "b98d3c21d6312c35a8c1807527badd41b43ec8c19fd1ad6307d52a134ab979c1"
    sha256 mojave:        "d63e808db517d0299636b514c940c4486aca8ce82bf927c5de420eceee08241b"
  end

  head do
    url "https://github.com/FreeRDP/FreeRDP.git"
    depends_on xcode: :build
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "jpeg"
  depends_on "libusb"
  depends_on "libx11"
  depends_on "libxcursor"
  depends_on "libxext"
  depends_on "libxfixes"
  depends_on "libxi"
  depends_on "libxinerama"
  depends_on "libxrandr"
  depends_on "libxrender"
  depends_on "libxv"
  depends_on "openssl@1.1"

  on_linux do
    depends_on "alsa-lib"
    depends_on "ffmpeg"
    depends_on "glib"
  end

  def install
    system "cmake", ".", *std_cmake_args, "-DWITH_X11=ON", "-DBUILD_SHARED_LIBS=ON", "-DWITH_JPEG=ON"
    system "make", "install"
  end

  test do
    success = `#{bin}/xfreerdp --version` # not using system as expected non-zero exit code
    details = $CHILD_STATUS
    raise "Unexpected exit code #{$CHILD_STATUS} while running xfreerdp" if !success && details.exitstatus != 128
  end
end
