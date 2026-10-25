class Iconkit < Formula
  desc "Material Symbols icon search and downloader — browse fonts.google.com/icons, fetch SVG or VectorDrawable"
  homepage "https://github.com/YoannDev90/android-tools"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/iconkit-aarch64-apple-darwin.tar.xz"
      sha256 "62c9cc2fd382be0921bbb127b16c7759951a0769d8dec2e823c9f220cc9ee99d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/iconkit-x86_64-apple-darwin.tar.xz"
      sha256 "9004c046e6fe448ac5b99fb102d3676c13502f806091b2ddfe7b13e01982665b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/iconkit-aarch64-unknown-linux-musl.tar.xz"
      sha256 "fcf2b2bfc675b37551e836532e8d881d7f96f57c322ed693fea6b5d19476a236"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/iconkit-x86_64-unknown-linux-musl.tar.xz"
      sha256 "2074545c914b853aa407a429cca944bfbac7d53b150f20660accd98752a36794"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "iconkit"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "iconkit"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "iconkit"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "iconkit"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
