# typed: strict
# frozen_string_literal: true

# Homebrew formula for Typst Time Machine release binaries.
class TypstTimeMachine < Formula
  desc "Browse rendered Typst documents through Git and Jujutsu history"
  homepage "https://github.com/EzraCerpac/typst-time-machine"
  version "0.1.0"
  license "MIT"

  depends_on "git"
  depends_on "typst"

  on_macos do
    on_arm do
      url "https://github.com/EzraCerpac/typst-time-machine/releases/download/v0.1.0/ttm-aarch64-apple-darwin.tar.gz"
      sha256 "dbed5fca597dda5b008df6f4c3e6a4f7641c08118e75310c25b1282b3e0ddb4f"
    end

    on_intel do
      url "https://github.com/EzraCerpac/typst-time-machine/releases/download/v0.1.0/ttm-x86_64-apple-darwin.tar.gz"
      sha256 "5f27883a8ccb267b7ce5fcebeff5c44a130334451ac6990bfb1335e4c8bebdf6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/EzraCerpac/typst-time-machine/releases/download/v0.1.0/ttm-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c01de5ac71558f1a55bcb59739cebda25369f7e1be98038ac2c18e40a8486cf9"
    end
  end

  def install
    bin.install "ttm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ttm --version")
  end
end
