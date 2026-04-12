# Build stage
FROM docker.io/library/node:25-alpine@sha256:ad82ecad30371c43f4057aaa4800a8ed88f9446553a2d21323710c7b937177fc AS builder

# Enable corepack for pnpm (corepack unbundled in Node 25+)
RUN npm install -g corepack && corepack enable && corepack prepare pnpm@9 --activate

WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml* ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy source
COPY . .

# Build with version info
ARG VERSION=dev
ARG COMMIT=unknown
ARG BUILD_TIME=unknown

ENV PUBLIC_VERSION=${VERSION}
ENV PUBLIC_COMMIT=${COMMIT}
ENV PUBLIC_BUILD_TIME=${BUILD_TIME}

RUN pnpm build

# Prune dev dependencies
RUN pnpm prune --prod

# Runtime stage
FROM docker.io/library/node:25-alpine@sha256:ad82ecad30371c43f4057aaa4800a8ed88f9446553a2d21323710c7b937177fc

# Install ca-certificates for HTTPS
RUN apk --no-cache add ca-certificates

# Build info — propagated from builder stage for $env/dynamic/public
ARG VERSION=dev
ARG COMMIT=unknown
ARG BUILD_TIME=unknown
ENV PUBLIC_VERSION=${VERSION}
ENV PUBLIC_COMMIT=${COMMIT}
ENV PUBLIC_BUILD_TIME=${BUILD_TIME}

WORKDIR /app

# Copy built app and production dependencies
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./

# Non-root user (node:22-alpine already has 'node' user at uid 1000)
USER node

EXPOSE 3000

ENV NODE_ENV=production
ENV PORT=3000

CMD ["node", "build"]
