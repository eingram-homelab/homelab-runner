FROM ghcr.io/actions/actions-runner:2.334.0

RUN (type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
      && sudo mkdir -p -m 755 /etc/apt/keyrings \
      && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
      && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
      && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
      && sudo mkdir -p -m 755 /etc/apt/sources.list.d \
      && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
      && sudo apt update \
      && sudo apt install nodejs pipx wget gh apt-transport-https ca-certificates curl gnupg lsb-release -y

RUN sudo mkdir -p /etc/apt/keyrings /etc/apt/sources.list.d \
    && curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null \
    && sudo chmod 0644 /etc/apt/keyrings/microsoft.gpg \
    && AZ_DIST="$(lsb_release -cs)" \
    && printf '%s\n' \
      "Types: deb" \
      "URIs: https://packages.microsoft.com/repos/azure-cli/" \
      "Suites: ${AZ_DIST}" \
      "Components: main" \
      "Architectures: $(dpkg --print-architecture)" \
      "Signed-By: /etc/apt/keyrings/microsoft.gpg" \
      | sudo tee /etc/apt/sources.list.d/azure-cli.sources > /dev/null \
    && sudo apt-get update \
    && sudo apt-get install -y azure-cli