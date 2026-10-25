class Assetgen < Formula
  desc "Android density asset generator — launcher, notification, adaptive, 9-patch, debug badges from one source PNG"
  homepage "https://github.com/YoannDev90/android-tools"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/assetgen-aarch64-apple-darwin.tar.xz"
      sha256 "bde86ed1647cbb816f791c3d15470fe3a7e5e942c2f4c52d7244aca3e832e458"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/assetgen-x86_64-apple-darwin.tar.xz"
      sha256 "81b31e471ecda45730c1c583a6a51ae6465ad68c0eca358b1b1b20397533986c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/assetgen-aarch64-unknown-linux-musl.tar.xz"
      sha256 "ad763a80e1cdd0633ce5d92a3e9f4cca1cc2c785cc51a57ffcd3b1cb3597888a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/assetgen-x86_64-unknown-linux-musl.tar.xz"
      sha256 "224b394b69a581aa6824b9ea52543290827519ee7ae0b0d78d8bdd6ec52ac61f"
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
      bin.install "assetgen"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "assetgen"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "assetgen"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "assetgen"
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
