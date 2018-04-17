set -e
set -x

TERM=dumb

# Choose the python versions to install deps for
pyenv install 3.4.3
  pip install pip==9.0.1
  pip install -U setuptools
  pip install -r test-requirements.txt
  pip install -r requirements.txt