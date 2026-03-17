class JjWaltz < Formula
  desc "A Jujutsu workspace switcher inspired by Worktrunk"
  homepage "https://github.com/ezracerpac/jj-waltz"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.2/jj-waltz-aarch64-apple-darwin.tar.gz"
      sha256 "bc0ee1eb30c15d2e5b617fd5ad3b9ec8a11c37fd3321b5dcaf40d9abb54938b6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.2/jj-waltz-x86_64-apple-darwin.tar.gz"
      sha256 "570b6a1936275ee585b7ae0e3c295ba166ea9bc4549c5b3ee645cf0da2faef94"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.2/jj-waltz-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c82f2804bcac8515623c164f1815bde5ce907f56ef4410261cf5b32f10dfeb82"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.2/jj-waltz-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1960df25ac8a8266de2468aeb15b80510f12a5ad0f9843616c3e822f2056f937"
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
