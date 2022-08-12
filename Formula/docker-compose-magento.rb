require 'formula'

class DockerComposeMagento < Formula
  url "https://github.com/digitalspacestdio/homebrew-docker-compose-magento.git", :using => :git
  version "0.2.5"
  revision 1

  depends_on 'gpatch'
  depends_on 'coreutils'
  depends_on 'rsync'
  depends_on 'mutagen-io/mutagen/mutagen' if OS.mac?

  def install
    #bin.install "docker-compose-magento"
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"docker-compose-magento"
  end

  def caveats
      s = <<~EOS
        docker-compose-magento was installed
      EOS
      s
    end
end
