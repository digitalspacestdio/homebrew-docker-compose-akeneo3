require 'formula'

class DockerVirtualbox < Formula
  url "https://github.com/digitalspacestdio/docker-compose-magento.git", :using => :git
  version "0.1.0"

  depends_on 'coreutils'
  depends_on 'mutagen-io/mutagen/mutagen'

  def install
    bin.install "docker-compose-magento"
  end

  def caveats
      s = <<~EOS
        docker-compose-magento was installed
      EOS
      s
    end
end
