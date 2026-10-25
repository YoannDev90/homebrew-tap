class Dp2px < Formula
  desc "px ↔ dp ↔ sp converter — offline, or against the device's real density"
  homepage "https://github.com/YoannDev90/android-tools"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/dp2px-aarch64-apple-darwin.tar.xz"
      sha256 "1e404b0e397cb0700d0273d688913fe4d816268dedd0490fd40cae1bb88cbc2c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/dp2px-x86_64-apple-darwin.tar.xz"
      sha256 "01ef59af659cfdd7329cf53f35a630e5f70b912679bd45920b740554287383a1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/dp2px-aarch64-unknown-linux-musl.tar.xz"
      sha256 "73d26fb196809e1ac00305fe1bb77f64035a66a10d298fad8dc47c50ff085d4e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/dp2px-x86_64-unknown-linux-musl.tar.xz"
      sha256 "2f1d4f0ee8c979b37d6ba380358751f6e50fdf3001ffc9ef27ed5edb86cb20e7"
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
      bin.install "dp2px"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dp2px"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dp2px"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dp2px"
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
