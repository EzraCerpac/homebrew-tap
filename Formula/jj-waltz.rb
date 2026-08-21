class JjWaltz < Formula
  desc "A Jujutsu workspace switcher inspired by Worktrunk"
  homepage "https://github.com/ezracerpac/jj-waltz"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.5.0/jj-waltz-aarch64-apple-darwin.tar.gz"
      sha256 "ecb8650ebb4b5671629ad4cfe1b6637c1e7f43a36ac82ecc942201483be5065c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.5.0/jj-waltz-x86_64-apple-darwin.tar.gz"
      sha256 "e8bed81a66c447ef3f81fbb06fc03613a205ed84d69a18243918812e0439893c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.5.0/jj-waltz-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fa65084044a3da877911dfe5e45f0b78a4201037a30cdcf4ee98eb55b19fd0d5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.5.0/jj-waltz-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b6dae211988a4d381d9c53259fceda1905aa5815c725570e98a94f65b797b984"
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
