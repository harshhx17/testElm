set -e
set -x
TERM=dumb

# NPM commands
ALEX=$(which alex || true)
# Delete 'alex' if it is not in a node_modules directory,
# which means it is ghc-alex.
if [[ -n "$ALEX" && "${ALEX/node_modules/}" == "${ALEX}" ]]; then
  echo "Removing $ALEX"
  sudo rm -rf $ALEX
fi
npm install
npm list --depth=0

# elm-format Installation
if [ ! -e ~/elm-format-0.18/elm-format ]; then
  mkdir -p ~/elm-format-0.18
  curl -fsSL -o elm-format.tgz https://github.com/avh4/elm-format/releases/download/0.5.2-alpha/elm-format-0.17-0.5.2-alpha-linux-x64.tgz
  tar -xvzf elm-format.tgz -C ~/elm-format-0.18
fi

# Julia commands
julia -e "Pkg.add(\"Lint\")"

# Lua commands
sudo luarocks install luacheck --deps-mode=none

# PHPMD installation
if [ ! -e ~/phpmd/phpmd ]; then
  mkdir -p ~/phpmd
  curl -fsSL -o phpmd.phar http://static.phpmd.org/php/latest/phpmd.phar
  sudo chmod +x phpmd.phar
  sudo mv phpmd.phar ~/phpmd/phpmd
fi

# astyle installation
wget "https://downloads.sourceforge.net/project/astyle/astyle/astyle%203.0.1/astyle_3.0.1_linux.tar.gz?r=&ts=1499017588&use_mirror=excellmedia" -O ~/astyle.tar.gz --no-check-certificate
tar -xvzf ~/astyle.tar.gz -C ~/
make -C ~/astyle/build/gcc
sudo make install -C ~/astyle/build/gcc
