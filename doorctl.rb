# Linux formula. macOS clients should install the cask: brew install --cask doorctl
class Doorctl < Formula
  desc "Door CLI to manage Kubernetes clusters, projects, and environments."
  homepage "https://www.cloudoor.com/"
  license "Apache-2.0"

  version "2.4.2"

  on_macos do
    disable! date: "2026-07-20", because: "macOS installs are distributed as a cask (brew install --cask doorctl)"
  end

  on_linux do
    on_arm do
      url "https://github.com/beopencloud/cno/releases/download/v#{version}/doorctl_Linux_arm64.tar.gz"
      sha256 "a57422f82297f347b032b0d9fe2a694bcde8097a3a0e0774042209e656250cca"
    end
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/beopencloud/cno/releases/download/v#{version}/doorctl_Linux_x86_64.tar.gz"
        sha256 "5497a1d24a11acc5dbcc2a54dc3b670d30b2125f8e75c2cfb37400053ed31c55"
      else
        url "https://github.com/beopencloud/cno/releases/download/v#{version}/doorctl_Linux_i386.tar.gz"
        sha256 "26a824ccbac8f1b331ef0bdb14cdc545c4120098bcefa4f8f6661559774842fa"
      end
    end
  end

  livecheck do
    url "https://github.com/beopencloud/cno/releases/latest"
    strategy :github_latest
  end

  def install
    bin.install "doorctl"
  end

  test do
    system "#{bin}/doorctl", "--help"
  end
end
