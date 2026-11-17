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
  version "0.3.3"
  license "MIT"

  # The configuration sync needs Git 2.43 or newer, which macOS does not ship.
  # dots also needs mise, which is not a dependency: most users run mise's own
  # installer, which updates itself (see caveats). Node.js, uv, jq and the
  # other tools come from the user's mise configuration.
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.3.3/dots-0.3.3-darwin-arm64.tar.gz"
      sha256 "33df0a9fa56c894ce5ffb3a3cd8dbd2a957743a91c8f483d1d8486f97165652c" # darwin-arm64
    end
    on_intel do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.3.3/dots-0.3.3-darwin-amd64.tar.gz"
      sha256 "c146fca64b9c559578364eac80799246b15b9e775a1ec7bf625fb01c1283fb2d" # darwin-amd64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.3.3/dots-0.3.3-linux-arm64.tar.gz"
      sha256 "4b0641c3c8b8ff426f87d5d9180cdd812fd74f429a0373cf881473f5906a7bbc" # linux-arm64
    end
    on_intel do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.3.3/dots-0.3.3-linux-amd64.tar.gz"
      sha256 "4e07ab0513053c216caa334b55721e7df13841ff8fe5dc07709d6e3640d29589" # linux-amd64
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
