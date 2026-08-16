class Gentlsa < Formula
  desc "Simple tool for dealing with DANE/TLSA records"
  homepage "https://github.com/BradKollmyer/gentlsa"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.3.2/gentlsa-aarch64-apple-darwin.tar.xz"
      sha256 "151cf2739582d60b4f47a39089a76ea087536f69f09f737be4e7726da8d2b0a0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.3.2/gentlsa-x86_64-apple-darwin.tar.xz"
      sha256 "9ff302a9563531938d783242a1b33d2ef7a177ec1704a1e95c547860e21c9c08"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.3.2/gentlsa-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2f63b1134fd31a32d5980e2daef75ed903dad55e6db11b8e8d5d3509ff16bca6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.3.2/gentlsa-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5bed32f5df15725ea3f54dcaf1fb330df48192ebb57c1fda43f172026bd76690"
    end
  end
  license "BSD-2-Clause"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "gentlsa"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gentlsa"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "gentlsa"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gentlsa"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
