# Baldwyns Park Scouts and Guides Website

A modern, responsive website built with Hugo and the Blowfish theme for Baldwyns Park Scouts and Guides group.

## 🚀 Quick Start

### Prerequisites

- [Hugo](https://gohugo.io/installation/) (v0.150.0 or later)
- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org/) (for development tools)

### Local Development

1. **Clone the repository:**

   ```bash
   git clone <repository-url>
   cd website
   ```

2. **Start the development server:**

   ```bash
   hugo server --buildDrafts --buildFuture
   ```

3. **Open your browser:**
   Navigate to `http://localhost:1313`

## 🛠️ Development Environment

### DevContainer Setup

This project includes a complete development environment using DevContainers:

1. **Open in VS Code with DevContainer extension**
2. **Rebuild container** when prompted
3. **Everything is automatically configured:**
   - Hugo extended edition
   - Pre-commit hooks
   - Git configuration
   - Development server auto-start

### Manual Setup

If not using DevContainers:

```bash
# Install pre-commit hooks
pipx install pre-commit
pre-commit install

# Setup Git hooks
bash .githooks/setup.sh

# Start development server
hugo server --bind 0.0.0.0 --port 1313 --buildDrafts --buildFuture
```

## 📁 Project Structure

```text
├── .devcontainer/          # Development container configuration
├── .github/                # GitHub workflows and templates
├── .githooks/              # Git hooks for code quality
├── assets/                 # Images and static assets
├── config/                 # Hugo configuration files
│   └── _default/
├── content/                # Website content
│   ├── about/              # About page
│   └── posts/              # Blog posts
├── layouts/                # Custom Hugo layouts
│   └── shortcodes/         # Custom shortcodes
├── static/                 # Static files
└── themes/blowfish/        # Blowfish theme
```

## ✨ Features

- **Modern Design:** Built with the Blowfish Hugo theme
- **Responsive:** Mobile-first design that works on all devices
- **Fast:** Static site generation for optimal performance
- **SEO Optimized:** Built-in SEO features and meta tags
- **Contact Integration:** Clickable phone and email links
- **Maps Integration:** Embedded Google Maps for location
- **Code Quality:** Pre-commit hooks and automated testing

## 🔧 Configuration

### Site Configuration

Main configuration files are located in `config/_default/`:

- `hugo.toml` - Basic Hugo settings
- `params.toml` - Theme parameters and site features
- `menus.en.toml` - Navigation menu structure
- `languages.en.toml` - Language and localization settings

### Content Management

#### Adding New Posts

```bash
hugo new posts/my-new-post/index.md
```

#### Content Structure

All content uses Hugo's page bundles with frontmatter:

```yaml
---
title: "Page Title"
summary: "Brief description"
categories: ["Category"]
tags: ["tag1", "tag2"]
date: 2025-01-01
draft: false
---

Your content here...
```

## 🚀 Deployment & Automation

### GitHub Workflows

This project includes several automated workflows for streamlined development and deployment:

#### 1. **Site Deploy** (`pages.yml`)

- **Trigger:** Push to `main` branch or manual dispatch
- **Purpose:** Builds and deploys the Hugo site to GitHub Pages
- **Features:**
  - Uses Hugo v0.150.0 extended
  - Automatic baseURL configuration
  - Deploys to `https://baldwynsparkscoutsandguides.org/`
  - Concurrent deployment protection

#### 2. **Auto Pull Request** (`auto-pr.yml`)

- **Trigger:** Push to any branch except `main`/`master`
- **Purpose:** Automatically creates pull requests for feature branches
- **Features:**
  - Creates PR with commit message as title
  - Adds review checklist and branch information
  - Assigns PR to the person who pushed
  - Adds `auto-pr` label (creates label if missing)
  - Updates existing PRs with new push notifications

#### 3. **Labeler** (`label.yml`)

- **Trigger:** Pull request creation/updates
- **Purpose:** Automatically applies labels based on changed files
- **Features:**
  - Uses `.github/labeler.yml` configuration
  - Helps categorize PRs by affected areas

#### 4. **Stale Issues & PRs** (`stale.yml`)

- **Trigger:** Daily at 10:19 UTC
- **Purpose:** Manages inactive issues and pull requests
- **Features:**
  - Marks stale issues with `no-issue-activity` label
  - Marks stale PRs with `no-pr-activity` label
  - Helps maintain repository hygiene

### Manual Build

```bash
# Production build
hugo --minify

# The built site will be in the `public/` directory
```

## 🔍 Code Quality

### Pre-commit Hooks

This project uses pre-commit hooks to maintain code quality:

- **File formatting:** Removes trailing whitespace, ensures proper line endings
- **Markdown linting:** Validates markdown syntax and formatting
- **TOML formatting:** Auto-formats Hugo configuration files
- **Hugo build check:** Ensures the site builds successfully
- **Conventional commits:** Enforces proper commit message format

### Running Checks Manually

```bash
# Run all pre-commit hooks
pre-commit run --all-files

# Run specific hook
pre-commit run markdownlint --all-files
```

### Git Hooks

Git hooks are automatically configured to run quality checks:

```bash
# Setup hooks (done automatically in DevContainer)
bash .githooks/setup.sh
```

## 🤝 Contributing

### Workflow

1. **Create a feature branch:**

   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Follow the existing code style
   - Add appropriate frontmatter to new content
   - Test locally with `hugo server`

3. **Commit your changes:**

   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

4. **Push to your branch:**

   ```bash
   git push origin feature/your-feature-name
   ```

5. **Automatic PR Creation:**
   - A pull request is automatically created
   - Review and merge when ready

### Commit Message Format

This project uses [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` - New features
- `fix:` - Bug fixes
- `docs:` - Documentation changes
- `style:` - Code style changes
- `refactor:` - Code refactoring
- `test:` - Adding tests
- `chore:` - Maintenance tasks

## 📞 Contact Information

<!-- markdownlint-disable-next-line MD036 -->
**Baldwyns Park Scouts and Guides**

- **Address:** 58-64 Eden Rd, Joydens Wood, Bexley DA5 2EG
- **Phone:** [01322 557921](tel:01322557921)
- **Email:** [hello@baldwynsparkscoutsandguides.org](mailto:hello@baldwynsparkscoutsandguides.org)

## 📄 License

This project is licensed under the terms specified in the [LICENSE](LICENSE) file.

## 🛟 Support

For technical issues or questions about the website:

1. Check existing [Issues](../../issues)
2. Create a new issue with detailed description
3. Contact the development team

---

**Built with ❤️ using [Hugo](https://gohugo.io/) and [Blowfish](https://blowfish.page/) theme**
