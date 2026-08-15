class JjWaltz < Formula
  desc "A Jujutsu workspace switcher inspired by Worktrunk"
  homepage "https://github.com/ezracerpac/jj-waltz"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.4.0/jj-waltz-aarch64-apple-darwin.tar.gz"
      sha256 "8ad05d4ccde1af3e03751f18f68019587f82ead4f2863b1dbca41c9996de4016"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.4.0/jj-waltz-x86_64-apple-darwin.tar.gz"
      sha256 "226c2062769ae85238771a26940a1104ac4f2ea786eac8bb93369c86b934f65e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.4.0/jj-waltz-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d25a59a5a70a5bd93bb1233f4734fb95bf1ad8ca7ad17a2244c1f069b80fc9cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.4.0/jj-waltz-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "80fca27e5826444563e79705ea7f6a0441e4fba7a6a2d0975b14c5d7f3bc8c2d"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "jw"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "jw"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "jw"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "jw"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
