class Uitool < Formula
  desc "Practical Android UI driver — dump, find, tap, shot over adb"
  homepage "https://github.com/YoannDev90/android-tools"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/uitool-aarch64-apple-darwin.tar.xz"
      sha256 "505954a5f74ba8a6eef94fa5909f820f69dbc94c4775033d28d3afb1b66e9101"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/uitool-x86_64-apple-darwin.tar.xz"
      sha256 "81977c46bee2214b8adf7abd2b3c643e9597b7957f254a4d816802549fefca57"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/uitool-aarch64-unknown-linux-musl.tar.xz"
      sha256 "bafe69cb8a9f19b5d1befe0b610ec902ef8af36eb1737e5a53b0da95943bbfbf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/uitool-x86_64-unknown-linux-musl.tar.xz"
      sha256 "8f6ef9a9bbbd25d39f414e0435ede8938aac811b633ff2ce3f16530423ecf5b2"
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
      bin.install "uitool"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "uitool"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "uitool"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "uitool"
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
