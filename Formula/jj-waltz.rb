class JjWaltz < Formula
  desc "A Jujutsu workspace switcher inspired by Worktrunk"
  homepage "https://github.com/ezracerpac/jj-waltz"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.7.0/jj-waltz-aarch64-apple-darwin.tar.gz"
      sha256 "3ca8280ab3ac91ca926e5bcd031ede6795bcc5d27f30311a85f80e456d6b6ae6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.7.0/jj-waltz-x86_64-apple-darwin.tar.gz"
      sha256 "d5b5c36c54a90b4fdd8882ab7ed24a099bf0bde684e75c4bce7516f2b9fd7c13"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.7.0/jj-waltz-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "da6732805e44e2b26a9088dad6d32b9841aec9afc8e9a2c818ae4729ce6bf706"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.7.0/jj-waltz-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3962278009983ea10cc86be1a0f4927f450689d7477fb3b1f41406db6d0d8b09"
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
