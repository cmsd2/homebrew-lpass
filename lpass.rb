require 'formula'

class Lpass < Formula
  homepage 'https://github.com/lastpass/lastpass-cli'
  url 'https://github.com/lastpass/lastpass-cli/archive/v0.3.0.tar.gz'
  sha1 'a4491bc5d258899ead6c64d4f97d23af93e03ff9'

  # ssl and xml2 provided by osx
  depends_on 'curl'
  depends_on 'pinentry' => :optional

  depends_on 'xclip' => :optional
  # pbclip ??
  # xsel ??

  option "without-docs", "Don't build docs using asciidoc"

  unless build.without? "docs"
    depends_on "asciidoc"
  end

  head do
    url "https://github.com/lastpass/lastpass-cli.git"
  end

  def install
    system "make PREFIX=#{prefix} install"
    system "make PREFIX=#{prefix} install-doc" if build.with? "docs"
    bash_completion.install "contrib/tig-completion.bash"
  end

  test do
    system "#{bin}/lpass", "-v"
  end
end
