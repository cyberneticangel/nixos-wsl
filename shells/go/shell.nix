{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # Go compiler and tools
  buildInputs = with pkgs; [
    go_1_22          # Go compiler (latest stable)
    gopls            # Go language server (for IDE support)
    go-tools         # Additional tools: goimports, gorename, etc.
    delve            # Go debugger
    golangci-lint    # Fast linter aggregator
    
    # Common build tools
    gnumake
    git
  ];
  
  # Environment variables
  env = {
    # Go workspace settings
    GOPATH = "${toString ./.}/.go";
    GO111MODULE = "on";
    GOPROXY = "https://proxy.golang.org,direct";
    GOSUMDB = "sum.golang.org";
    
    # Add Go binaries to PATH
    PATH = "${toString ./.}/.go/bin:${toString ./.}/bin:$PATH";
  };
  
  shellHook = ''
    echo "Go Development Environment"
    echo "Go version: $(go version)"
    echo ""
    echo "Go environment:"
    echo "  GOPATH: $GOPATH"
    echo "  GO111MODULE: $GO111MODULE"
    echo ""
    echo "Common commands:"
    echo "  go run main.go          # Run program"
    echo "  go build ./...          # Build all packages"
    echo "  go test ./...           # Run tests"
    echo "  go mod tidy             # Update dependencies"
    echo "  go mod download         # Download dependencies"
    echo "  golangci-lint run       # Run linter"
    echo "  dlv debug main.go       # Debug with delve"
    
    # Create GOPATH directory structure if it doesn't exist
    mkdir -p $GOPATH/{src,bin,pkg}
  '';
}
