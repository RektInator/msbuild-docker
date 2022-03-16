# msbuild-docker
A docker container to run msbuild on linux!

## Usage
### Opening a vs dev shell
``docker run -v "$(pwd):/src" -i ghcr.io/rektinator/msbuild-docker:latest`` will open a vs dev shell to ``Z:\src\``. ``Z:\src\`` is the current working directory.

### Compiling a solution file directly
``docker run -v "$(pwd):/src" ghcr.io/rektinator/msbuild-docker:latest msbuild my-solution.sln -t:Build`` will build the ``my-solution.sln`` file in the current working directory.
