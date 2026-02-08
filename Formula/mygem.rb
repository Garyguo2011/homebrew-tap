class MygemGitDownloadStrategy < GitDownloadStrategy
  def submodules?
    false
  end
end

class Mygem < Formula
  desc "Command-line client for Google Gemini"
  homepage "https://github.com/Garyguo2011/mygem"
  url "git@github.com:Garyguo2011/mygem.git",
      tag: "v0.1.0",
      using: MygemGitDownloadStrategy
  version "0.1.0"
  head "git@github.com:Garyguo2011/mygem.git",
       branch: "main",
       using: MygemGitDownloadStrategy

  depends_on "go" => :build

  def install
    system "go", "mod", "download"

    ldflags = %W[
      -X github.com/garyguo/mygem/cmd.Version=#{version}
      -X github.com/garyguo/mygem/cmd.Commit=#{Utils.git_head}
      -X github.com/garyguo/mygem/cmd.Date=#{time.iso8601}
    ]
    system "go", "build", *std_go_args(ldflags:)
  end

  def caveats
    <<~EOS
      First-time setup:
        mygem auth login    # Opens Chrome, log in to Google manually

      Common commands:
        mygem chat list --table   # List recent chats
        mygem chat list --json    # JSON output
        mygem auth status         # Check auth status
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mygem version")
  end
end
