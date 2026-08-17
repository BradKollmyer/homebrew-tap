class Gentlsa < Formula
  desc "Simple tool for dealing with DANE/TLSA records"
  homepage "https://github.com/BradKollmyer/gentlsa"
  version "0.3.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.3.4/gentlsa-aarch64-apple-darwin.tar.xz"
      sha256 "4494ae1e72aa0317d1614fe7473d5c26dd3f724d2321f1120a65e84b949de775"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.3.4/gentlsa-x86_64-apple-darwin.tar.xz"
      sha256 "68a96fe00c920f1626b025bb8c7ada7644bd40876b69c2a88e2fe35b9af8de7a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.3.4/gentlsa-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0029b7913a02a9d2124f0c4e8eecea9bc2ea7f42cc962ec59cee2c31d3321507"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.3.4/gentlsa-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1bfb435f277a881a4607b33badf136d49c92c5bd4203f410d7a5beba5e6064bd"
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
