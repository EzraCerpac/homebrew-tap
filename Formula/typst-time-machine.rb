# typed: strict
# frozen_string_literal: true

# Homebrew formula for Typst Time Machine release binaries.
class TypstTimeMachine < Formula
  desc "Browse rendered Typst documents through Git and Jujutsu history"
  homepage "https://github.com/EzraCerpac/typst-time-machine"
  version "0.1.2"
  license "MIT"

  depends_on "git"
  depends_on "typst"

  on_macos do
    on_arm do
      url "https://github.com/EzraCerpac/typst-time-machine/releases/download/v0.1.2/ttm-aarch64-apple-darwin.tar.gz"
      sha256 "c797db4e409c27f2ac52f11e25fd0f8460d94e47f781631ae55c102d2ce4b6e0"
    end

    on_intel do
      url "https://github.com/EzraCerpac/typst-time-machine/releases/download/v0.1.2/ttm-x86_64-apple-darwin.tar.gz"
      sha256 "3ce535f06f463df346a7eeb2b113b19efb7419a334a308789f30dd980d21076a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/EzraCerpac/typst-time-machine/releases/download/v0.1.2/ttm-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1fb609f8e21924a65d034f9c6838d92c5245a8a9f46a48a3f846678027cbfeac"
    end
  end

  def install
    bin.install "ttm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ttm --version")
  end
end
