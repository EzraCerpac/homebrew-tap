class JjWaltz < Formula
  desc "A Jujutsu workspace switcher inspired by Worktrunk"
  homepage "https://github.com/ezracerpac/jj-waltz"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.6.1/jj-waltz-aarch64-apple-darwin.tar.gz"
      sha256 "5fcde045b24f4b6a57b42a9f7b818cb094c41591023f7dcd09023ad39e1546bf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.6.1/jj-waltz-x86_64-apple-darwin.tar.gz"
      sha256 "579d990dd88521affe8466bea4be05e090afe7a814ff7c09831b838419f067a5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.6.1/jj-waltz-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "85a4775a6d6743d4c009ceaac7771c13617c040936948a06a15fd80920ed0b3c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ezracerpac/jj-waltz/releases/download/v0.6.1/jj-waltz-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "caa771f39858ad7bac67362a65fe07fb75c5ce3a83abf345d776d0c88b3d67a3"
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
