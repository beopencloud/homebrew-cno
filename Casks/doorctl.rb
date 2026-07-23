cask "doorctl" do
  version "2.4.2"

  on_arm do
    url "https://github.com/beopencloud/cno/releases/download/v#{version}/doorctl_Darwin_arm64.tar.gz"
    sha256 "b86911050b952e8b0df775469e79866f8d0cfd99e9dfd7b1da9a0dbfe45acfa2"
  end
  on_intel do
    url "https://github.com/beopencloud/cno/releases/download/v#{version}/doorctl_Darwin_x86_64.tar.gz"
    sha256 "d48b005df817aa6240b0d659e9b52a1311d51fa1a3572e79d3284b8d1cf4aa02"
  end

  name "doorctl"
  desc "Door CLI to manage Kubernetes clusters, projects, and environments."
  homepage "https://www.cloudoor.com/"

  binary "doorctl"

  livecheck do
    url "https://github.com/beopencloud/cno/releases/latest"
    strategy :github_latest
  end
end
