# typed: strict
# frozen_string_literal: true

# Reviewed source of the tap's Formula/dots.rb. For each release,
# packaging/build-release renders this file with the release's version and
# checksums into the dots.rb release asset. Nothing pushes it to the tap: copy
# that asset by hand to Formula/dots.rb in EzraCerpac/homebrew-tap. Keep the
# platform comment at the end of each sha256 line: the renderer matches on it.
class Dots < Formula
  desc "Keep machines in the state a mise configuration declares"
  homepage "https://github.com/EzraCerpac/dots"
  version "0.3.2"
  license "MIT"

  # The configuration sync needs Git 2.43 or newer, which macOS does not ship.
  # dots also needs mise, which is not a dependency: most users run mise's own
  # installer, which updates itself (see caveats). Node.js, uv, jq and the
  # other tools come from the user's mise configuration.
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.3.2/dots-0.3.2-darwin-arm64.tar.gz"
      sha256 "4da1ceb1c2a8cc4a6cf32430cf1ee7b2e4a0104f5d3633201100d2be014e225b" # darwin-arm64
    end
    on_intel do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.3.2/dots-0.3.2-darwin-amd64.tar.gz"
      sha256 "0018aa8f9b951ac4702d5636e20518f752505c793282425cfee93b39ec01a166" # darwin-amd64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.3.2/dots-0.3.2-linux-arm64.tar.gz"
      sha256 "a26432b62318276fcdf801eb02f19e82972d17dbaf9d01ead853ff51f669e4c4" # linux-arm64
    end
    on_intel do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.3.2/dots-0.3.2-linux-amd64.tar.gz"
      sha256 "e2af1cc7e292f4dc08838e5d98e7a953dca9f066002b2be9638f519d9a287aad" # linux-amd64
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/dots"
  end

  def caveats
    <<~EOS
      dots runs everything through mise, which this formula does not install.
      Install it from https://mise.jdx.dev, or with `brew install mise`.

      dots links its agent skill into ~/.claude/skills/dots and
      ~/.agents/skills/dots the first time it runs (set DOTS_SKILL_LINKS=0
      to opt out). After `brew uninstall dots`, remove those links:
        rm ~/.claude/skills/dots ~/.agents/skills/dots
    EOS
  end

  test do
    assert_match "dots #{version} (homebrew)", shell_output("#{bin}/dots --version")
    assert_predicate libexec/"bin/dots-up", :executable?
    assert_match "dots-shared-cli/2", shell_output("#{libexec}/bin/dots-up --capabilities")
  end
end
