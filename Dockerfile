FROM ubuntu:noble-20250127

WORKDIR /app

# https://github.com/pdm-project/pdm?tab=readme-ov-file#installation
ENV PATH="$PATH:/root/.local/bin"

COPY . .

# time zone
ENV TZ=Asia/Shanghai

# https://shaoguangleo.github.io/2019/01/20/docker-install-tzdata/
ARG DEBIAN_FRONTEND=noninteractive

# mirrors.ustc.edu.cn arm64 中国科学技术大学源
# https://mirrors.ustc.edu.cn/help/ubuntu-ports.html
#
RUN sed -i 's@//ports.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list.d/ubuntu.sources && \
  apt-get update -y && \
  apt-get install curl python3.12 python-is-python3 python3.12-venv -y && \
  (curl -sSL https://pdm-project.org/install-pdm.py | python3 -) && \
  pdm config pypi.url https://mirrors.aliyun.com/pypi/simple/ && \
  pdm install

CMD ["pdm", "run", "start"]
