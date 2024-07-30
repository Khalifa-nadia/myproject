FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && apt-get install -y \
    wget \
    build-essential \
    g++ \
    python3-dev \
    autotools-dev \
    libicu-dev \
    libbz2-dev \
    cmake \
    libssl-dev \
    libpcap-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Boost 1.71.0
RUN wget https://boostorg.jfrog.io/artifactory/main/release/1.71.0/source/boost_1_71_0.tar.gz && \
    tar -xf boost_1_71_0.tar.gz && \
    cd boost_1_71_0 && \
    ./bootstrap.sh && ./b2 install && cd .. && \
    rm -rf boost_1_71_0 boost_1_71_0.tar.gz


# Install jsoncpp 1.7.4
RUN cd /tmp && \
    wget https://github.com/open-source-parsers/jsoncpp/archive/refs/tags/1.7.4.tar.gz && \
    tar -xf 1.7.4.tar.gz && \
    cd jsoncpp-1.7.4 && \
    mkdir -p build/release && \
    cd build/release && \
    cmake -DCMAKE_BUILD_TYPE=release -DBUILD_STATIC_LIBS=OFF -DBUILD_SHARED_LIBS=ON -DARCHIVE_INSTALL_DIR=. -G "Unix Makefiles" ../.. && \
    make && \
    make install

# Install libssl.so.1.1
RUN apt-get update && apt-get install -y libssl1.1 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install libpcap
# Install xerces 3.2.2
RUN wget https://archive.apache.org/dist/xerces/c/3/sources/xerces-c-3.2.2.tar.gz && \
    tar -xf xerces-c-3.2.2.tar.gz && \
    cd xerces-c-3.2.2 && \
    ./configure && make && make install && cd .. && \
    rm -rf xerces-c-3.2.2 xerces-c-3.2.2.tar.gz



CMD ["bash"]
