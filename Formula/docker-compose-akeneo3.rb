require 'formula'

class DockerComposeAkeneo3 < Formula
  url "https://github.com/digitalspacestdio/homebrew-docker-compose-akeneo3.git", :using => :git
  version "0.1.2"
  revision 19

  depends_on 'gpatch'
  depends_on 'coreutils'
  depends_on 'rsync'
  depends_on 'mutagen-io/mutagen/mutagen' if OS.mac?

  def install
    #bin.install "docker-compose-akeneo3"
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"docker-compose-akeneo3"
  end

  def caveats
      s = <<~EOS
        docker-compose-akeneo3 was installed
      EOS
      s
    end
end
