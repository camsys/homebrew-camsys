class Zeromq22 < Formula
  desc "High-performance, asynchronous messaging library"
  homepage "http://www.zeromq.org/"
  url "http://download.zeromq.org/zeromq-2.2.0.tar.gz"
  sha256 "43904aeb9ea6844f72ca02e4e53bf1d481a1a0264e64979da761464e88604637"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
 
  conflicts_with "zeromq"

  deprecated_option "with-pgm" => "with-libpgm"

  depends_on "pkg-config" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <assert.h>
      #include <zmq.h>

      int main()
      {
        zmq_msg_t query;
        assert(0 == zmq_msg_init_size(&query, 1));
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lzmq", "-o", "test"
    system "./test"
  end
end
