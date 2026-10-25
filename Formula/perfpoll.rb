class Perfpoll < Formula
  desc "Per-app perf sampler over adb — CPU, RAM, battery drain, fps to CSV"
  homepage "https://github.com/YoannDev90/android-tools"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/perfpoll-aarch64-apple-darwin.tar.xz"
      sha256 "de288fa09871d948b1744a0ace1b78805d90a302e381135e9eb4e2f810e7d848"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/perfpoll-x86_64-apple-darwin.tar.xz"
      sha256 "4f7c73a51ff926cf18dc53bf062abd65c3bf7ec9cb0a5076ceb9723004c84414"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/perfpoll-aarch64-unknown-linux-musl.tar.xz"
      sha256 "30b6db50d1d9a8e367a7cb3bb4a3f7bdda11f220f3168a3f671f7f38e1d7a66a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/perfpoll-x86_64-unknown-linux-musl.tar.xz"
      sha256 "8b0c584903f8d9d8af192241230408eec02540b189997085239ac8c07c690990"
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
      bin.install "perfpoll"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "perfpoll"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "perfpoll"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "perfpoll"
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
