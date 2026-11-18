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
  version "0.4.0"
  license "MIT"

  # The configuration sync needs Git 2.43 or newer, which macOS does not ship.
  # dots also needs mise, which is not a dependency: most users run mise's own
  # installer, which updates itself (see caveats). Node.js, uv, jq and the
  # other tools come from the user's mise configuration.
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.4.0/dots-0.4.0-darwin-arm64.tar.gz"
      sha256 "d47df9ad63e84b8456fb9f0be61072846e4a14fd569b0e83a8d6d8ce2c1703cc" # darwin-arm64
    end
    on_intel do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.4.0/dots-0.4.0-darwin-amd64.tar.gz"
      sha256 "8b7b85b62a7e9cc682c8a6dbdd29eb2bbf9a920174c7e5d9f0b3620f68667378" # darwin-amd64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.4.0/dots-0.4.0-linux-arm64.tar.gz"
      sha256 "e64a21892d86697e68689fa221a8e7de0959f84828ddf35a454a63c013755131" # linux-arm64
    end
    on_intel do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.4.0/dots-0.4.0-linux-amd64.tar.gz"
      sha256 "c47595e614f0d0ddd3e918cedb9cd77e36bc86c9d27b56eb031c856723fa7026" # linux-amd64
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/dots"
    fish_completion.install_symlink libexec/"completions/dots.fish"
    zsh_completion.install_symlink libexec/"completions/_dots"
    bash_completion.install_symlink libexec/"completions/dots.bash" => "dots"
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
    assert_match "dots-shared-cli/3", shell_output("#{libexec}/bin/dots-up --capabilities")
  end
end
