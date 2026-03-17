class JjWaltz < Formula
  desc "A Jujutsu workspace switcher inspired by Worktrunk"
  homepage "https://github.com/ezracerpac/jj-waltz"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.3/jj-waltz-aarch64-apple-darwin.tar.gz"
      sha256 "50fb8e0403b9cb4bae9da9255ba9ebce4a27b2a8ec2c346f31461b9b30d932d5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.3/jj-waltz-x86_64-apple-darwin.tar.gz"
      sha256 "7174ec5786f66dcb56df82ab06360fcaf174acca79d34cdfe918a48d5b3b7c6f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.3/jj-waltz-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9ea78d6227b2ab6ec8874508b6acc8dd9b5907ce69d97749b3cad9138fb4c7fa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.3/jj-waltz-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "62347788af955f0fdbdd274ae9b5937d2e0d01efc4cfafe9ed3708e64063ef55"
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
