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
  version "0.3.0"
  license "MIT"

  # The configuration sync needs Git 2.43 or newer, which macOS does not ship.
  # dots also needs mise, which is not a dependency: most users run mise's own
  # installer, which updates itself (see caveats). Node.js, uv, jq and the
  # other tools come from the user's mise configuration.
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.3.0/dots-0.3.0-darwin-arm64.tar.gz"
      sha256 "6eba8dd2381c670291832345e250bf9216565fc3cc2b0439f2c34749483402b4" # darwin-arm64
    end
    on_intel do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.3.0/dots-0.3.0-darwin-amd64.tar.gz"
      sha256 "0711d4e26988c0d522847f0d405c2e9f697de785e3de648235956a898a1d7a55" # darwin-amd64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.3.0/dots-0.3.0-linux-arm64.tar.gz"
      sha256 "b7b170d10c369a1eb893b0af9cb4f1c1046625c7277b1484765306d78cddd55d" # linux-arm64
    end
    on_intel do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.3.0/dots-0.3.0-linux-amd64.tar.gz"
      sha256 "d2a313ede83a4266e3fb62551c9694e366cddcc997b10b7416276bf6117a47a5" # linux-amd64
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
