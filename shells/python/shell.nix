{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # Native build dependencies
  nativeBuildInputs = with pkgs; [
    pkg-config
  ];
  
  # Runtime dependencies
  buildInputs = with pkgs; [
    python311
    python311Packages.pip
    python311Packages.virtualenv
    python311Packages.setuptools
    python311Packages.wheel
    
    # Common development tools
    python311Packages.black      # Code formatter
    python311Packages.pylint     # Linter
    python311Packages.mypy       # Static type checker
    python311Packages.pytest     # Testing framework
    
    # System dependencies (if needed)
    # gcc
    # openssl
    # postgresql
  ];
  
  # Environment variables
  shellHook = ''
    echo "Python development environment"
    echo "Python version: $(python --version)"
    
    # Create virtual environment if it doesn't exist
    if [ ! -d ".venv" ]; then
      echo "Creating virtual environment..."
      python -m venv .venv
    fi
    
    # Activate virtual environment
    source .venv/bin/activate
    
    # Upgrade pip in the virtual environment
    pip install --upgrade pip
    
    echo "Virtual environment activated: .venv"
    echo "Run 'pip install -r requirements.txt' to install dependencies"
  '';
  
  # Set environment variables
  env = {
    # PYTHONPATH = "${pkgs.python311}/lib/python3.11/site-packages";
  };
}
