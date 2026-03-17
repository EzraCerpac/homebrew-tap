class JjWaltz < Formula
  desc "A Jujutsu workspace switcher inspired by Worktrunk"
  homepage "https://github.com/ezracerpac/jj-waltz"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.1/jj-waltz-aarch64-apple-darwin.tar.gz"
      sha256 "816e5a0c092989b726d7c4156ec16b3ab97e2b68760095068a09c0a2fadf567a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.1/jj-waltz-x86_64-apple-darwin.tar.gz"
      sha256 "a69bbd57242e657e0f05e23614880d75269dc1987f2b6ba693e047d3afca605b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.1/jj-waltz-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5111e08e56752379ad1678322186a4adadde3f141c6f26c7d2c7d97d7caa9afa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.1/jj-waltz-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a4e703609255b50db4fef7b59d9168edda67a18390eb4f4009fb2bffd279e0fb"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
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
    bin.install "jw" if OS.mac? && Hardware::CPU.arm?
    bin.install "jw" if OS.mac? && Hardware::CPU.intel?
    bin.install "jw" if OS.linux? && Hardware::CPU.arm?
    bin.install "jw" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
