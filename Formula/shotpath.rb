class Shotpath < Formula
  desc "Watch your macOS Desktop for screenshots and copy the path to clipboard"
  homepage "https://github.com/hboon/shotpath"
  url "https://github.com/hboon/shotpath.git", tag: "v0.1.0"
  head "https://github.com/hboon/shotpath.git", branch: "main"
  license "MIT"

  depends_on :macos

  def install
    system "swiftc", "-O", "-o", "shotpath", "Sources/main.swift",
           "-framework", "AppKit", "-framework", "CoreServices"
    bin.install "shotpath"
  end

  service do
    run [opt_bin/"shotpath"]
    keep_alive true
    log_path var/"log/shotpath.log"
    error_log_path var/"log/shotpath.log"
  end

  test do
    assert_match "Watching", shell_output("#{bin}/shotpath &; sleep 1; kill $!; wait 2>/dev/null; true", 0)
  end
end
