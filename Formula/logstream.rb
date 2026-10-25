class Logstream < Formula
  desc "Live Android log streamer - logcat, but actually nice"
  homepage "https://github.com/YoannDev90/android-tools"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/logstream-aarch64-apple-darwin.tar.xz"
      sha256 "c842c2269561a8e105f29ab56428333eec4821318943ad092e07a0433d992162"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/logstream-x86_64-apple-darwin.tar.xz"
      sha256 "9d617cbf7f68bd91243ad54666136eb600634fbf34fe782dec960af4151f9314"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/logstream-aarch64-unknown-linux-musl.tar.xz"
      sha256 "d2fe7e356eeacf2081764211d6baf4227894b6a588cb5a233993760eb5af99ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YoannDev90/android-tools/releases/download/v0.1.0/logstream-x86_64-unknown-linux-musl.tar.xz"
      sha256 "75859daaf3db909e7199269a3daff65f2c4d2293f5d55b2c6897cc3b137b2a9d"
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
      bin.install "logstream"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "logstream"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "logstream"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "logstream"
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
