class Gentlsa < Formula
  desc "Simple tool for dealing with DANE/TLSA records"
  homepage "https://github.com/BradKollmyer/gentlsa"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.5.1/gentlsa-aarch64-apple-darwin.tar.xz"
      sha256 "431bc355a5ad8201d3365dff662295fd6a529f38c6e0b2e13587d484f83ea2c8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.5.1/gentlsa-x86_64-apple-darwin.tar.xz"
      sha256 "fd2e5a75e9a3ed4716e690f53bf89c38b72c64d34599380807f134b72aa2a593"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.5.1/gentlsa-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "aebc248bb5df6c97b0336efb80734a22858321fd8016f44d7da9491a103b3bcb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.5.1/gentlsa-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f259cc2055adc933a2502ea3d4b846041921d395bc264e54fcc8237b28557b3d"
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
