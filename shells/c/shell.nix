{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # Build tools and compilers
  buildInputs = with pkgs; [
    gcc14          # GNU Compiler Collection (or use clang)
    clang19        # Alternative: LLVM Clang compiler
    gnumake        # GNU Make build system
    cmake          # CMake build system (alternative to Make)
    pkg-config     # Helper tool for compiler flags
    gdb            # GNU Debugger
    valgrind       # Memory debugging tool
    bear           # Generate compilation database for clangd
  ];
  
  # Development tools
  nativeBuildInputs = with pkgs; [
    clang-tools    # clangd, clang-format, clang-tidy
    cmake-format   # CMake formatter
    cppcheck       # Static analysis tool
  ];
  
  # Environment variables
  env = {
    # Set C/C++ compilers
    CC = "gcc";
    CXX = "g++";
    # Alternative for Clang:
    # CC = "clang";
    # CXX = "clang++";
    
    # Build flags
    CFLAGS = "-Wall -Wextra -Wpedantic -O2";
    CXXFLAGS = "-Wall -Wextra -Wpedantic -O2 -std=c++17";
    
    # Debug build flags (uncomment for debugging)
    # CFLAGS = "-Wall -Wextra -Wpedantic -O0 -g";
    # CXXFLAGS = "-Wall -Wextra -Wpedantic -O0 -g -std=c++17";
  };
  
  shellHook = ''
    echo "C/C++ Development Environment"
    echo "Compiler: $(cc --version | head -n1)"
    echo "Make: $(make --version | head -n1)"
    echo "CMake: $(cmake --version | head -n1)"
    echo ""
    echo "Common commands:"
    echo "  make          # Build with Make"
    echo "  cmake -B build && cmake --build build  # Build with CMake"
    echo "  gdb ./program # Debug with GDB"
    echo "  valgrind ./program # Memory check"
  '';
}
