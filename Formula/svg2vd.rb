class Svg2vd < Formula
  desc "SVG → Android VectorDrawable XML converter — pure, no device, no Android SDK"
  homepage "https://github.com/YoannDev90/android-tools"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/svg2vd-aarch64-apple-darwin.tar.xz"
      sha256 "639af1aea1ffab29bb17cd8a21b5aa48ce884649aff8806bf1d35683a1254319"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/svg2vd-x86_64-apple-darwin.tar.xz"
      sha256 "ecc0d69e6d826b023a1bb4d292266ad7a09e6d7b1c3d0b3c8605c89b20b68271"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/svg2vd-aarch64-unknown-linux-musl.tar.xz"
      sha256 "b8206335bc03973a79ec48aa1ea1532114692dc985906e480c4ecc2e1c6a4f94"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/svg2vd-x86_64-unknown-linux-musl.tar.xz"
      sha256 "ec114db23c8f1bc5aa28bad3363eb9a8d7b6902c447de3fdaf0c51df58a3e9bb"
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
      bin.install "svg2vd"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "svg2vd"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "svg2vd"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "svg2vd"
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
