class Resclean < Formula
  desc "Dead res/ resource detector for Android projects — CI gate"
  homepage "https://github.com/YoannDev90/android-tools"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/resclean-aarch64-apple-darwin.tar.xz"
      sha256 "77fb766e0e7ecbaed4f3e79ce97230b62fd685ab67f554863c70a6023af47384"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/resclean-x86_64-apple-darwin.tar.xz"
      sha256 "4eec97325b541629421217bf6e6b3b9d20801240b309fa460a95f93312494e4a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/resclean-aarch64-unknown-linux-musl.tar.xz"
      sha256 "c0e723d6fd248e89ade7f7bc1e49e9ee4a6a776ddc24f7ce3856e125974c1d49"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/resclean-x86_64-unknown-linux-musl.tar.xz"
      sha256 "d891b0c974041671a134b90b398bf50de7a89c7e225257167143a2bc5c075a24"
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
      bin.install "resclean"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "resclean"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "resclean"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "resclean"
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
