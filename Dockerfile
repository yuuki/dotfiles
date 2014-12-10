FROM ubuntu:14.04

RUN apt-get update -y
RUN apt-get install -y git perl ruby python curl vim strace diffstat pkg-config cmake build-essential tcpdump screen zsh
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp

# Install go
RUN curl https://go.googlecode.com/files/go1.3.3.linux-amd64.tar.gz | tar -C /usr/local -zx

ENV GOROOT /usr/local/go
ENV PATH /usr/local/go/bin:$PATH
# Setup home environment
RUN useradd dev
RUN mkdir /home/dev && chown -R dev:/home/dev
RUN mkdir -p /home/dev/go /home/dev/bin /home/dev/lib /home/dev/include
ENV PATH /home/dev/bin:$PATH
ENV PKG_CONFIG_PATH /home/dev/lib/pkgconfig
ENV LD_LIBRARY_PATH /home/dev/lib
ENV GOPATH /home/dev/go:$GOPATH

RUN go get github.com/dotcloud/gordon/pulls
# Create a shared data volume
# We need to create an empty file, otherwise the volume will
# belong to root.
# This is probably a Docker bug.
RUN mkdir /var/shared/RUN touch /var/shared/placeholder
RUN chown -R dev:dev /var/shared
VOLUME /var/shared
WORKDIR /home/dev
ENV HOME /home/dev
ADD .vimrc /home/dev/.vimrc
ADD .vim /home/dev/.vim
ADD .zshenv /home/dev/.bash_profile
ADD .zsh_profile /home/dev/.zsh_profile
ADD .zshrc /home/dev/.zshrc
ADD .gitconfig /home/dev/.gitconfig

# Link in shared parts of the home directory
RUN ln -s /var/shared/.ssh
RUN ln -s /var/shared/.bash_history
RUN ln -s /var/shared/.maintainercfg
RUN chown -R dev:/home/dev
USER dev
