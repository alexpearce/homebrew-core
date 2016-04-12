class Tmux < Formula
  desc "Terminal multiplexer"
  homepage "https://tmux.github.io/"
  url "https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz"
  sha256 "bc28541b64f99929fe8e3ae7a02291263f3c97730781201824c0f05d7c8e19e4"

  bottle do
    cellar :any
    sha256 "815920cd38a8102360f7d667271d9c724f41087dd79be433db29259390ef8011" => :el_capitan
    sha256 "93e2156c3c7e1c9f3f4b86dd84617e7519e9bee630f1e8769e00a91aa341d274" => :yosemite
    sha256 "03c4ca001f72a1623393c0ec9406dfd82b7e449d745762a6e761da6a95d0fbd9" => :mavericks
  end

  head do
    url "https://github.com/tmux/tmux.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libevent"

  def install
    system "sh", "autogen.sh" if build.head?

    ENV.append "LDFLAGS", "-lresolv"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}"

    system "make", "install"

    pkgshare.install "example_tmux.conf"
  end

  def caveats; <<-EOS.undent
    Example configuration has been installed to:
      #{opt_pkgshare}
    EOS
  end

  test do
    system "#{bin}/tmux", "-V"
  end
end
