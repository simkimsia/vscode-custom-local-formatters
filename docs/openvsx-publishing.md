# Publishing to Open VSX

Guide for publishing this extension to the [Open VSX Registry](https://open-vsx.org/).

## Prerequisites

- Node.js and pnpm (or npm/yarn) installed
- Extension built and tested locally

---

## Step 1: Create Open VSX Account

1. Go to [open-vsx.org](https://open-vsx.org/)
2. Click **"Log in"** → Sign in with Eclipse Foundation account (or create one)
3. You can also use GitHub OAuth if linked to Eclipse

## Step 2: Create Namespace

1. After logging in, go to your **profile page**
2. Navigate to **"Namespaces"**
3. Create namespace: `simkimsia`
4. This must match the `publisher` field in `package.json`

## Step 3: Generate Access Token

1. In your profile, go to **"Access Tokens"**
2. Click **"Generate Token"**
3. Copy and save the token securely (shown only once)

## Step 4: Build the Extension

```bash
# Ensure you're on the right branch
git checkout openvsx-release

# Install dependencies (pnpm, npm, or yarn all work)
pnpm install

# Compile TypeScript
pnpm run compile

# Package as .vsix
pnpm exec vsce package
```

This creates `custom-local-formatters-<version>.vsix`

## Step 5: Publish

```bash
# Publish using npx (no global install needed)
npx ovsx publish custom-local-formatters-*.vsix -p <TOKEN>
```

Or publish directly without packaging first:

```bash
npx ovsx publish -p <TOKEN>
```

## Step 6: Verify

1. Go to [open-vsx.org/extension/simkimsia/custom-local-formatters](https://open-vsx.org/extension/simkimsia/custom-local-formatters)
2. Confirm your extension appears

---

## Checklist for `simkimsia/custom-local-formatters`

- [x] Create Eclipse Foundation account at [accounts.eclipse.org](https://accounts.eclipse.org/)
- [x] Log in to [open-vsx.org](https://open-vsx.org/) using Github
- [x] Link Eclipse Foundation account to Github
- [x] Create namespace `simkimsia`
- [ ] Claim namespace `simkimsia` on [open-vsx.org](https://open-vsx.org/) as seen on [here](https://github.com/eclipse/openvsx/wiki/Namespace-Access)
- [x] Generate access token and save it
- [x] Run `pnpm install`
- [x] Run `pnpm run compile`
- [x] Run `pnpm exec vsce package`
- [x] Run `npx ovsx publish custom-local-formatters-*.vsix -p <TOKEN>`
- [x] Verify extension at [open-vsx.org](https://open-vsx.org/extension/simkimsia/custom-local-formatters)
