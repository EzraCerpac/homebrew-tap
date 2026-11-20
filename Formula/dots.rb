# typed: strict
# frozen_string_literal: true

# Reviewed source of the tap's Formula/dots.rb. For each release,
# packaging/build-release renders this file with the release's version and
# checksums into the dots.rb release asset. The release workflow copies that
# asset to Formula/dots.rb in EzraCerpac/homebrew-tap after publication. Keep the
# platform comment at the end of each sha256 line: the renderer matches on it.
class Dots < Formula
  desc "Keep machines in the state a mise configuration declares"
  homepage "https://github.com/EzraCerpac/dots"
  version "0.5.2"
  license "MIT"

  # The configuration sync needs Git 2.43 or newer, which macOS does not ship.
  # dots also needs mise, which is not a dependency: most users run mise's own
  # installer, which updates itself (see caveats).
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.5.2/dots-0.5.2-darwin-arm64.tar.gz"
      sha256 "c333c1756f62ec1c443b2bdf5641fb9630400dd3a92c9afe8a02aaea2a97ba77" # darwin-arm64
    end
    on_intel do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.5.2/dots-0.5.2-darwin-amd64.tar.gz"
      sha256 "ea9a873877634267f001b67d100e81c077f7457f20a4a9b67b1f6f810add31b0" # darwin-amd64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.5.2/dots-0.5.2-linux-arm64.tar.gz"
      sha256 "589cee255a57a55594b1ae6581c921473022f510c44e0a82d3c64feb28fabfd5" # linux-arm64
    end
    on_intel do
      url "https://github.com/EzraCerpac/dots/releases/download/v0.5.2/dots-0.5.2-linux-amd64.tar.gz"
      sha256 "1b69abf34b85240826590aa725c2a74a5715daa522401ed6bb60851cfaae32ae" # linux-amd64
    end
  end

  def install
    # Homebrew stages the archive from its sole top-level directory, bin/.
    bin.install "dots"
    generate_completions_from_executable(bin/"dots", "completions")
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
    assert_equal "dots #{version} (homebrew)\n", shell_output("#{bin}/dots --version")
    { bash: bash_completion/"dots", zsh: zsh_completion/"_dots", fish: fish_completion/"dots.fish" }.each do |shell, path|
      assert_predicate path, :file?
      assert_equal shell_output("#{bin}/dots completions #{shell}").b, path.binread
    end
  end
end
