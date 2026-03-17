class JjWaltz < Formula
  desc "A Jujutsu workspace switcher inspired by Worktrunk"
  homepage "https://github.com/ezracerpac/jj-waltz"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.4/jj-waltz-aarch64-apple-darwin.tar.gz"
      sha256 "2486c128afa64f2dba6d2cee2c25a308a238f632f46c8070d4b487a18c15ca5d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.4/jj-waltz-x86_64-apple-darwin.tar.gz"
      sha256 "8a772ad1b9022ab6356e61678bd05e39dbf0fe9d026c40459d58869bd897f205"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.4/jj-waltz-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ed110c7b852ac42d7b7844c8d33467d5e3e7d2994face7295af44830b7964df7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.4/jj-waltz-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4be6738c22e92725a75b127d16c968f70ae61c479bfec4c937521742380403ef"
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
