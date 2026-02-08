class Mygem < Formula
  desc "Command-line client for Google Gemini"
  homepage "https://github.com/Garyguo2011/mygem"
  version "0.1.0"

  on_macos do
    on_arm do
      url "https://github.com/Garyguo2011/mygem/releases/download/v0.1.0/mygem-0.1.0-darwin-arm64.tar.gz"
      sha256 "0b62121dbd167a7d6e4abe4e2e8edce93374a24ef4b3890a59f1fbf464586e43"
    end
    on_intel do
      url "https://github.com/Garyguo2011/mygem/releases/download/v0.1.0/mygem-0.1.0-darwin-amd64.tar.gz"
      sha256 "bf4430bff6491b28f698ddae3f5072b88fee2c76b8f23bc9b170ace56a0334dd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Garyguo2011/mygem/releases/download/v0.1.0/mygem-0.1.0-linux-arm64.tar.gz"
      sha256 "6be7eb387e474fd9b1d4f5bcf5fecf5a655256fb5bf84ac13fbf5d4df442a7bd"
    end
    on_intel do
      url "https://github.com/Garyguo2011/mygem/releases/download/v0.1.0/mygem-0.1.0-linux-amd64.tar.gz"
      sha256 "787b616f89d396eba90f381852cf29a851aed6f1da6d6098336da1636c04fc1f"
    end
  end

  def install
    bin.install "mygem"
  end

  test do
    assert_match "mygem", shell_output("#{bin}/mygem version")
  end
end
