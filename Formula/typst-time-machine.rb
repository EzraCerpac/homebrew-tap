# typed: strict
# frozen_string_literal: true

# Homebrew formula for Typst Time Machine release binaries.
class TypstTimeMachine < Formula
  desc "Browse rendered Typst documents through Git and Jujutsu history"
  homepage "https://github.com/EzraCerpac/typst-time-machine"
  version "0.1.3"
  license "MIT"

  depends_on "git"
  depends_on "typst"

  on_macos do
    on_arm do
      url "https://github.com/EzraCerpac/typst-time-machine/releases/download/v0.1.3/ttm-aarch64-apple-darwin.tar.gz"
      sha256 "5c8873e56f2ed01ac4bb3df2ccce6970cea6e44065f7912ebb3ed48853e1bcbc"
    end

    on_intel do
      url "https://github.com/EzraCerpac/typst-time-machine/releases/download/v0.1.3/ttm-x86_64-apple-darwin.tar.gz"
      sha256 "12aa9e3e17247d89c6d18e05131d0948a0331e1bf3cb7a1843a02b76937c6d65"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/EzraCerpac/typst-time-machine/releases/download/v0.1.3/ttm-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "110f12e132763cbbdf57057c319787b000409d5f4cbc4e30d8088b17094be7b5"
    end
  end

  def install
    bin.install "ttm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ttm --version")
  end
end
