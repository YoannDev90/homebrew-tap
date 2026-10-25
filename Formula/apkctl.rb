class Apkctl < Formula
  desc "App lifecycle over adb — clear data/cache, restart, kill, uninstall, deep links, one or every device"
  homepage "https://github.com/YoannDev90/android-tools"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/apkctl-aarch64-apple-darwin.tar.xz"
      sha256 "677723e41cdadcdacd2176566212f0f059aa8832d36b90452edbdeec06857d07"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/apkctl-x86_64-apple-darwin.tar.xz"
      sha256 "00e7483cdf9d9ea655a98407dc72e5720bbf333bbf02a158f2a790fb6be256c7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/apkctl-aarch64-unknown-linux-musl.tar.xz"
      sha256 "2089d5a94a23889ddb39dff6f0986864ddf26de9fd3f114914dd1c675139718e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/apkctl-x86_64-unknown-linux-musl.tar.xz"
      sha256 "a8a4d519b3e4e97d8ed9d11a1f113dfce2d25fe46c3564fc7870db004e057f69"
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
      bin.install "apkctl"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "apkctl"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "apkctl"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "apkctl"
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
