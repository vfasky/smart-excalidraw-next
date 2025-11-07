FROM oven/bun:1.1 AS builder
WORKDIR /app

COPY package.json ./
RUN bun install

COPY . .
ENV NEXT_TELEMETRY_DISABLED=1
ENV NODE_ENV=production
RUN bun run build

FROM oven/bun:1.1 AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000

COPY package.json ./
RUN bun install --production

COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/next.config.mjs ./next.config.mjs

EXPOSE 3000
USER bun
CMD ["bun", "run", "start"]