# typed: strict
# frozen_string_literal: true

# Homebrew formula for Typst Time Machine release binaries.
class TypstTimeMachine < Formula
  desc "Browse rendered Typst documents through Git and Jujutsu history"
  homepage "https://github.com/EzraCerpac/typst-time-machine"
  version "0.1.1"
  license "MIT"

  depends_on "git"
  depends_on "typst"

  on_macos do
    on_arm do
      url "https://github.com/EzraCerpac/typst-time-machine/releases/download/v0.1.1/ttm-aarch64-apple-darwin.tar.gz"
      sha256 "64d945149c3304ac64567f1d71f66c13acd11700eb390b439ecca2656ec2abf6"
    end

    on_intel do
      url "https://github.com/EzraCerpac/typst-time-machine/releases/download/v0.1.1/ttm-x86_64-apple-darwin.tar.gz"
      sha256 "56a7c45321f5284191e3e587390eb4779cd03e7276dde3bf2553b1bf8dfb8066"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/EzraCerpac/typst-time-machine/releases/download/v0.1.1/ttm-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "546c04d1407585aaf7a111902179f899b4b18f97c6bc4039d0aaa373e88bd548"
    end
  end

  def install
    bin.install "ttm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ttm --version")
  end
end
