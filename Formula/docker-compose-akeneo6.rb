require 'formula'

class DockerComposeAkeneo6 < Formula
  url "https://github.com/digitalspacestdio/homebrew-docker-compose-akeneo6.git", :using => :git
  version "0.1.1"
  revision 3

  depends_on 'gpatch'
  depends_on 'coreutils'
  depends_on 'rsync'
  depends_on 'mutagen-io/mutagen/mutagen' if OS.mac?

  def install
    #bin.install "docker-compose-akeneo6"
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"docker-compose-akeneo6"
  end

  def caveats
      s = <<~EOS
        docker-compose-akeneo6 was installed
      EOS
      s
    end
end
