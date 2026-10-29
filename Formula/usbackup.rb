class Usbackup < Formula
  desc "Automated USB backup agent"
  homepage "https://github.com/YoannDev90/USBackup"
  version "1.0.0"
  if OS.mac?
    url "https://github.com/YoannDev90/USBackup/releases/download/v1.0.0/usbackup-macos-universal"
    sha256 "eb6fa6a4aefab1e4638bdefd347682eb31d36a957752bd67d30a9709cab28f30"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YoannDev90/USBackup/releases/download/v1.0.0/usbackup-linux-arm64"
      sha256 "9af0d8c7c941c0f6a4c8ebf020b03ffd6ad0e5f91a25e260f460654e59ae0779"
    else
      url "https://github.com/YoannDev90/USBackup/releases/download/v1.0.0/usbackup-linux-amd64"
      sha256 "90080673f559f37954e00128c880fcb31faeb4aacc994c6f1149665dda34faeb"
    end
  end
  license "MIT"

  def install
    if OS.mac?
      bin.install "usbackup-macos-universal" => "usbackup"
    elsif Hardware::CPU.arm?
      bin.install "usbackup-linux-arm64" => "usbackup"
    else
      bin.install "usbackup-linux-amd64" => "usbackup"
    end
  end
end
