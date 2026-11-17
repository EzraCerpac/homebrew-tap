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
  version "0.3.4"
  license "MIT"

  # The configuration sync needs Git 2.43 or newer, which macOS does not ship.
  # dots also needs mise, which is not a dependency: most users run mise's own
  # installer, which updates itself (see caveats). Node.js, uv, jq and the
  # other tools come from the user's mise configuration.
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.3.4/dots-0.3.4-darwin-arm64.tar.gz"
      sha256 "26168103c364e3ad120cedd46d789bdfa72c0d88917fe607af9ffa5e3ef9f443" # darwin-arm64
    end
    on_intel do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.3.4/dots-0.3.4-darwin-amd64.tar.gz"
      sha256 "62459462092b0c80dba8a9ee19dabb601cfa1abc9b38dff0dfe59e0a87e6b927" # darwin-amd64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.3.4/dots-0.3.4-linux-arm64.tar.gz"
      sha256 "a096f3e79656c09fdb42cb40b9ffb427e4f63620b1951f9beda5b2264370c113" # linux-arm64
    end
    on_intel do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.3.4/dots-0.3.4-linux-amd64.tar.gz"
      sha256 "335dfcc7d46f41709e9ea14b7d75ff049eb28c5856f22f08dc20cb23c4c7cf79" # linux-amd64
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
