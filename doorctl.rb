# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class Doorctl < Formula
  version "2.4.0"
  desc "An open source platform to onboard easily and securely organizational teams on multi-cloud Kubernetes clusters from a single console."
  homepage "https://www.cloudoor.com/"
  url "https://github.com/beopencloud/cno/releases/download/v2.4.0/doorctl_Darwin_x86_64.tar.gz"
  sha256 "b4120cf339a8f9e212855ad9451d154e2a624c2390294520427c4bb6a1f43f77"
  license "Apache License, Version 2.0"

  def install
    # Move cnoctl binary from the  unpack folder to /usr/local/bin folder and make it executable (chmod 0555 cnoctl)
    bin.install "doorctl"
  end

  # We are fine if the cnoctl --help does not output an error,
  # so we know that the installation was ok.
  test do
    system "#{bin}/doorctl", "--help"
  end
end
