import { defineConfig } from "@playwright/test";

export default defineConfig({
  testDir: "e2e",
  use: { baseURL: "http://localhost:4173" },
  // Смоук идёт по собранному бандлу: конфликт версий ловится только в нём.
  webServer: {
    command: "npm run build && npm run serve -- --port 4173 --strictPort",
    url: "http://localhost:4173",
    reuseExistingServer: !process.env.CI,
  },
});
