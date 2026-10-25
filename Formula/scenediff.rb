class Scenediff < Formula
  desc "Visual regression diff of two screenshots, files or device captures"
  homepage "https://github.com/YoannDev90/android-tools"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/scenediff-aarch64-apple-darwin.tar.xz"
      sha256 "f0d25fa19d9baad598716dd016d94f840e20117e7ad773495e26a0e0136187b0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/scenediff-x86_64-apple-darwin.tar.xz"
      sha256 "be939beb68a4575347d9320cc77f9c201534fe35c4fda4c09cab2ef8b3e13c03"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/scenediff-aarch64-unknown-linux-musl.tar.xz"
      sha256 "af36a60a8f761f22221924eb9ab788cf6025346425c71119e4f4f4c271dac4c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/scenediff-x86_64-unknown-linux-musl.tar.xz"
      sha256 "946299df4041717c33efea952d9155214c5b7ee514df8090509ebf8efe4f8b36"
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
      bin.install "scenediff"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "scenediff"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "scenediff"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "scenediff"
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
