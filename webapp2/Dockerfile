# Stage 1: Build the Rust application
FROM rust:latest AS builder

WORKDIR /usr/src/app

# Copy manifest files and cache dependencies
COPY Cargo.toml Cargo.lock ./
RUN mkdir src && echo "fn main() {}" > src/main.rs
RUN cargo build --release && rm -rf src

# Copy full source and build the app
COPY . .
RUN cargo build --release

# Stage 2: Create a minimal runtime image
FROM debian:bookworm-slim

# Install only required runtime libraries
RUN apt-get update && apt-get install -y \
    libssl-dev \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy binary from builder
COPY --from=builder /usr/src/app/target/release/webapp2 .

EXPOSE 8080

CMD ["./webapp2"]