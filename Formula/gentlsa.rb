class Gentlsa < Formula
  desc "Simple tool for dealing with DANE/TLSA records"
  homepage "https://github.com/BradKollmyer/gentlsa"
  version "0.3.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.3.3/gentlsa-aarch64-apple-darwin.tar.xz"
      sha256 "e287634db162e8a6c696b88343ab9ff2bf7eadcfc0059b7a0b8e690f4605432c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.3.3/gentlsa-x86_64-apple-darwin.tar.xz"
      sha256 "6dc102596bb64e9b449e74f6c44d647fa60d4aa815eb0efb9cc2cd1e89778ff8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.3.3/gentlsa-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2180dff1237ff6d47a59e9afa82f927b129221f76937e89ab5406481b4010676"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BradKollmyer/gentlsa/releases/download/v0.3.3/gentlsa-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eb803768cb9d35810e7e2104851e90fe2894471b4cb25a9a9035650be6056a23"
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
