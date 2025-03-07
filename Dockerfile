FROM ubuntu:noble-20250127

WORKDIR /app

# https://github.com/pdm-project/pdm?tab=readme-ov-file#installation
ENV PATH="$PATH:/root/.local/bin"

COPY . .

# time zone
ENV TZ=Asia/Shanghai

# https://shaoguangleo.github.io/2019/01/20/docker-install-tzdata/
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
  apt-get install curl python3.12 python-is-python3 python3.12-venv -y && \
  (curl -sSL https://pdm-project.org/install-pdm.py | python3 -) && \
  pdm install

CMD ["pdm", "run", "start"]
