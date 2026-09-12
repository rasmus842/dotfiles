import type { Plugin } from "@opencode-ai/plugin"
import { readdirSync } from "node:fs"
import { fileURLToPath } from "node:url"

const skillsPaths = readdirSync(new URL("./plugins", import.meta.url), {
  withFileTypes: true,
})
  .filter((entry) => entry.isDirectory() && entry.name !== "work-in-progress")
  .map((entry) => fileURLToPath(new URL(`./plugins/${entry.name}`, import.meta.url)))

export default (async () => ({
  config: async (config) => {
    const paths = config.skills?.paths ?? []

    config.skills = {
      ...config.skills,
      paths: [...new Set([...paths, ...skillsPaths])],
    }
  },
})) satisfies Plugin
