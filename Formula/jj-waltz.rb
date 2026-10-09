class JjWaltz < Formula
  desc "A Jujutsu workspace switcher inspired by Worktrunk"
  homepage "https://github.com/ezracerpac/jj-waltz"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.8.0/jj-waltz-aarch64-apple-darwin.tar.gz"
      sha256 "037cec4ffe875ffdf2ad9d09d98873d3362ddc4aad8cc7a8ffb781182d9168fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.8.0/jj-waltz-x86_64-apple-darwin.tar.gz"
      sha256 "706ac0782401172a885ad2493d1a2053192355807e6fb956984826ac75f77dda"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.8.0/jj-waltz-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b3cf9b62eb7a82e242555e52b9fe8316a5638b84fc3a376c739eb6b6cce4d43b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.8.0/jj-waltz-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3030dd17baf134e03a20bc54731c1852464f8a2cd72728dc2dd69d534050a6da"
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
