class Jzmq < Formula
  desc "Java bindings for zeromq"
  homepage "https://gitjub.com/zeromq/jzmq"
  head "https://github.com/zeromq/jzmq.git", :revision => "d8d8b03a7f86f7738"

  # needs older version of zmq, see https://github.com/zeromq/jzmq/issues/318
  depends_on "zeromq22"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  
  def install
    ENV.deparallelize
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    # Test that we can import the JZMQ library.
    (testpath/"Test.java").write("import org.zeromq.*;")
    system "javac", "-classpath", "/usr/local/share/java/zmq.jar", "Test.java"
  end
end
