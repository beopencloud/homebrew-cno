#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TAG="${1:-}"

if [ -z "$TAG" ]; then
  TAG="$(curl -fsSL https://api.github.com/repos/beopencloud/cno/releases/latest | jq -r .tag_name)"
fi

VERSION="${TAG#v}"
CHECKSUMS="$(curl -fsSL "https://github.com/beopencloud/cno/releases/download/${TAG}/checksums.txt")"

sha_for() {
  echo "$CHECKSUMS" | awk -v file="$1" '$2 == file { print $1; exit }'
}

DARWIN_ARM64="$(sha_for doorctl_Darwin_arm64.tar.gz)"
DARWIN_X86_64="$(sha_for doorctl_Darwin_x86_64.tar.gz)"
LINUX_ARM64="$(sha_for doorctl_Linux_arm64.tar.gz)"
LINUX_X86_64="$(sha_for doorctl_Linux_x86_64.tar.gz)"
LINUX_I386="$(sha_for doorctl_Linux_i386.tar.gz)"

for value in "$DARWIN_ARM64" "$DARWIN_X86_64" "$LINUX_ARM64" "$LINUX_X86_64" "$LINUX_I386"; do
  if [ -z "$value" ]; then
    echo "Missing checksum in ${TAG} checksums.txt" >&2
    exit 1
  fi
done

cat >"${ROOT}/doorctl.rb" <<EOF
# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class Doorctl < Formula
  desc "An open source platform to onboard easily and securely organizational teams on multi-cloud Kubernetes clusters from a single console."
  homepage "https://www.cloudoor.com/"
  license "Apache-2.0"

  version "${VERSION}"

  on_macos do
    on_arm do
      url "https://github.com/beopencloud/cno/releases/download/v#{version}/doorctl_Darwin_arm64.tar.gz"
      sha256 "${DARWIN_ARM64}"
    end
    on_intel do
      url "https://github.com/beopencloud/cno/releases/download/v#{version}/doorctl_Darwin_x86_64.tar.gz"
      sha256 "${DARWIN_X86_64}"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beopencloud/cno/releases/download/v#{version}/doorctl_Linux_arm64.tar.gz"
      sha256 "${LINUX_ARM64}"
    end
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/beopencloud/cno/releases/download/v#{version}/doorctl_Linux_x86_64.tar.gz"
        sha256 "${LINUX_X86_64}"
      else
        url "https://github.com/beopencloud/cno/releases/download/v#{version}/doorctl_Linux_i386.tar.gz"
        sha256 "${LINUX_I386}"
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
EOF

echo "Updated doorctl.rb to ${VERSION}"
