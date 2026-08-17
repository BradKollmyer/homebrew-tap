class Gentlsa < Formula
  desc "Simple tool for dealing with DANE/TLSA records"
  homepage "https://github.com/BradKollmyer/gentlsa"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.4.2/gentlsa-aarch64-apple-darwin.tar.xz"
      sha256 "0a69314e980d47456169764fff3a5b116bea99a7f4a17b22d9c171dfaab635a3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.4.2/gentlsa-x86_64-apple-darwin.tar.xz"
      sha256 "6ad4db65475db85fb354105875f04f6a3bb5b0fe981271739a03b73538d292c2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.4.2/gentlsa-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "69930bdd3b63404464020c73586fbd42087bc624ae93a902b14b6b5c84eeac36"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.4.2/gentlsa-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b6aae9e5d95cdf3b30c3c7f02370c3a24556a3093cecc5602fdb10c0a9cd8d6c"
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
