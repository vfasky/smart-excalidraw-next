FROM oven/bun:1.1 AS runner
WORKDIR /app

# Runtime env
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1
ENV PORT=3000

# Copy prebuilt artifacts (built locally via pre-commit or CI)
COPY .next/standalone ./.next/standalone
COPY .next/static ./.next/static
COPY public ./public

# Expose and run server
EXPOSE 3000
USER bun
CMD ["bun", ".next/standalone/server.js"]