# Custom download strategy that skips submodules (avoid circular homebrew-tap reference)
class OtGitDownloadStrategy < GitDownloadStrategy
  def submodules?
    false
  end
end

class Ot < Formula
  desc "Unofficial command-line interface for Otter.ai"
  homepage "https://github.com/Garyguo2011/otter-cli"
  url "git@github.com:Garyguo2011/otter-cli.git",
      tag: "v1.0.0",
      using: OtGitDownloadStrategy
  version "1.0.0"
  license "MIT"
  head "git@github.com:Garyguo2011/otter-cli.git",
       branch: "main",
       using: OtGitDownloadStrategy

  depends_on "go" => :build

  def install
    system "go", "mod", "download"

    ldflags = %W[
      -X github.com/garyguo/ot/cmd.Version=#{version}
      -X github.com/garyguo/ot/cmd.Commit=#{Utils.git_head}
      -X github.com/garyguo/ot/cmd.Date=#{time.iso8601}
    ]
    system "go", "build", *std_go_args(ldflags:)
  end

  def caveats
    <<~EOS
      Otter CLI requires your Otter.ai credentials.

      First-time setup:
        export OTTER_USERNAME="your_email@example.com"
        export OTTER_PASSWORD="your_password"

      Common commands:
        ot ls                     # List speeches
        ot get -r 1               # Get speech summary
        ot dl -b 1                # Download transcript
        ot ask -r 1               # Interactive Q&A mode

      For more information:
        ot --help
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ot --version")
  end
end
