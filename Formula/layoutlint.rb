class Layoutlint < Formula
  desc "UI hierarchy lint — touch targets, overlap, labels, from a uiautomator dump"
  homepage "https://github.com/YoannDev90/android-tools"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/layoutlint-aarch64-apple-darwin.tar.xz"
      sha256 "34ce6cc55068269de2fc843fb4e8a0846dc7d55e17f547309fe2bfdda65a7faa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/layoutlint-x86_64-apple-darwin.tar.xz"
      sha256 "59b539e649782605f968fed74dc3018a8ccdb4b77a63c84b8b513649848991fc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/layoutlint-aarch64-unknown-linux-musl.tar.xz"
      sha256 "90dc9955b894c0baba38c4e40fbe58607894ce4f63cc57fbf24c6e2d038605f5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/layoutlint-x86_64-unknown-linux-musl.tar.xz"
      sha256 "3d42d7581caa949db5bf58ddb1c27954423493d8b6794d40c2b3e236bf779ec7"
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
      bin.install "layoutlint"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "layoutlint"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "layoutlint"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "layoutlint"
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
