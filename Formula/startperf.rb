class Startperf < Formula
  desc "App cold/warm start benchmark over adb"
  homepage "https://github.com/YoannDev90/android-tools"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/startperf-aarch64-apple-darwin.tar.xz"
      sha256 "3f06da7cbb5784e52c40c175c72b999d10ef01545b72f147d8a0b5792e836999"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/startperf-x86_64-apple-darwin.tar.xz"
      sha256 "9198ba8f2a3a90a5640ea0a890c322e99594b117146cba680ed50846756d42a7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/startperf-aarch64-unknown-linux-musl.tar.xz"
      sha256 "712cfa3fd041989a50211efb638a557604e337880319f9304907a252c4528699"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/startperf-x86_64-unknown-linux-musl.tar.xz"
      sha256 "db0e5e60622b11ad764f356f0dd15f602a8962dd1ab1319cc449707e1576462c"
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
      bin.install "startperf"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "startperf"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "startperf"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "startperf"
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
