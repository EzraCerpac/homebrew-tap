class JjWaltz < Formula
  desc "A Jujutsu workspace switcher inspired by Worktrunk"
  homepage "https://github.com/ezracerpac/jj-waltz"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.5/jj-waltz-aarch64-apple-darwin.tar.gz"
      sha256 "487d04dfcfb876d73a3c01af43c0a86213484e17ca36c35c6f92b282a0b9b763"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.5/jj-waltz-x86_64-apple-darwin.tar.gz"
      sha256 "ac0de0ccdd1b25cf5e09525f74bbe5dd3d1a992bbbf3325b23ec1f865accf2bf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.5/jj-waltz-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "db7c786c6e62a7dbfb7e00cbe94b6ff438b602df43449fea74f2b92ebb6cec3b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.1.5/jj-waltz-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "23826bc29d47dfa6d3d51f7800d82ac15eb8646d3fdafd67b1e6c01ce9584ea6"
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
