# GitLab CI/CD Configuration Guide

This document explains the GitLab CI/CD setup for this project, which mirrors the functionality of the GitHub Actions workflows.

## Overview

The `.gitlab-ci.yml` file in the root directory contains all CI/CD pipeline definitions. It replaces the GitHub Actions
workflows found in `.github/workflows/`.

## Pipeline Jobs

### 1. Pages (Build & Deploy)

**Equivalent to:** `pages.yml` in GitHub Actions

**Purpose:** Builds the Hugo site and deploys it to GitLab Pages.

**Triggers:**

- Runs on all branches
- Only deploys to GitLab Pages on the default branch (usually `main` or `master`)

**Configuration:**

- Uses Hugo Extended version 0.150.0
- Builds to `./public` directory
- Automatically uses GitLab Pages URL for the base URL on default branch

**GitLab Pages URL:** Your site will be available at `https://<username>.gitlab.io/<project-name>/`

### 2. Auto Merge Request

**Equivalent to:** `auto-pr.yml` in GitHub Actions

**Purpose:** Automatically creates a Merge Request (MR) when you push to a non-default branch.

**Triggers:**

- Only on push events to non-default branches
- Only if an MR doesn't already exist for that branch

**Features:**

- Creates an MR with the latest commit message as title
- Adds the `auto-mr` label
- Assigns the MR to the person who pushed
- Comments on existing MRs when new commits are pushed

**Important:** This job requires proper API permissions. See the "Setup Requirements" section below.

### 3. Image Compression

**Equivalent to:** `compress-images.yml` in GitHub Actions

**Purpose:** Automatically compresses images (jpg, jpeg, png, webp, avif) when they're modified.

**Triggers:**

- Only on non-default branches
- Only when image files are changed

**Note:** Unlike the GitHub version, this doesn't automatically create an MR. To enable automatic commits, uncomment the
push line in the script section.

### 4. Stale Issues/MRs

**Equivalent to:** `stale.yml` in GitHub Actions

**Status:** Not implemented in CI/CD

**Alternative:** GitLab has built-in features for managing inactive issues and MRs:

- Go to **Settings > General > Merge requests**
- Enable "Delete source branch by default"
- Use GitLab's issue/MR closing patterns in commits

For custom stale handling, you can:

1. Create a scheduled pipeline in **CI/CD > Schedules**
2. Add a custom job that uses the GitLab API to check and close stale issues/MRs

## Setup Requirements

### 1. Enable GitLab Pages

1. Go to **Settings > Pages**
2. Ensure Pages is enabled for your project
3. The default deployment branch should be set to `main` or `master`

### 2. Configure CI/CD Variables (Optional)

If you need custom configuration, add variables in **Settings > CI/CD > Variables**:

- `HUGO_VERSION` - Override Hugo version (default: 0.150.0)
- `HUGO_ENVIRONMENT` - Hugo environment (default: production)

### 3. API Permissions for Auto MR

The auto-merge-request job uses `CI_JOB_TOKEN` which has limited permissions by default.

#### Option A: Use CI_JOB_TOKEN (Recommended)

1. Go to **Settings > CI/CD > Token Access**
2. Enable "Limit job token scope" if you want tighter security
3. Add required permissions for the job token

#### Option B: Use Project Access Token

1. Go to **Settings > Access Tokens**
2. Create a token with `api` and `write_repository` scopes
3. Add it as a CI/CD variable named `GITLAB_API_TOKEN`
4. Update the script to use `${GITLAB_API_TOKEN}` instead of `${CI_JOB_TOKEN}`

### 4. Configure Protected Branches

1. Go to **Settings > Repository > Protected branches**
2. Configure `main`/`master` as protected
3. Set "Allowed to merge" and "Allowed to push" according to your workflow

## Key Differences from GitHub Actions

### Terminology

- **GitHub Actions** → **GitLab CI/CD**
- **Workflow** → **Pipeline**
- **Job** → **Job** (same)
- **Step** → **Script section**
- **Pull Request** → **Merge Request**
- **Actions** → **CI/CD Jobs**

### File Structure

- **GitHub:** Multiple YAML files in `.github/workflows/`
- **GitLab:** Single `.gitlab-ci.yml` file in root directory

### Triggers

- **GitHub:** `on:` keyword
- **GitLab:** `rules:` or `only:`/`except:` keywords

### Secrets/Variables

- **GitHub:** `${{ secrets.SECRET_NAME }}`
- **GitLab:** `${SECRET_NAME}` or `$SECRET_NAME`

### Built-in Variables

| GitHub | GitLab |
|--------|--------|
| `${{ github.token }}` | `${CI_JOB_TOKEN}` |
| `${{ github.ref }}` | `${CI_COMMIT_REF_NAME}` |
| `${{ github.sha }}` | `${CI_COMMIT_SHA}` |
| `${{ github.actor }}` | `${GITLAB_USER_LOGIN}` |
| `${{ github.repository }}` | `${CI_PROJECT_PATH}` |

### Pages Deployment

- **GitHub:** Uses `actions/deploy-pages@v4`
- **GitLab:** Automatic when job is named `pages` and produces `public/` artifact

## Testing the Pipeline

1. Push to a non-default branch to test:
   - Auto MR creation
   - Image compression (if you've added/modified images)
   - Build job

2. Push to the default branch to test:
   - Full build and deploy to GitLab Pages

3. View pipeline status:
   - Go to **CI/CD > Pipelines**
   - Click on a pipeline to see job details
   - Click on a job to see logs

## Troubleshooting

### Pipeline Not Running

- Check if CI/CD is enabled: **Settings > General > Visibility, project features, permissions > CI/CD**
- Verify `.gitlab-ci.yml` syntax: **CI/CD > Editor** (has built-in validator)

### Pages Not Deploying

- Ensure the job is named `pages`
- Verify artifacts include `public/` directory
- Check Pages settings: **Settings > Pages**

### Auto MR Not Creating

- Verify API token has correct permissions
- Check job logs for API errors
- Ensure labels are created or job has permission to create them

### Image Compression Not Working

- Verify the job has write permissions if pushing back to repo
- Check that image paths match the `changes:` patterns
- Review job logs for compression errors

## Additional Resources

- [GitLab CI/CD Documentation](https://docs.gitlab.com/ee/ci/)
- [GitLab Pages Documentation](https://docs.gitlab.com/ee/user/project/pages/)
- [GitLab API Documentation](https://docs.gitlab.com/ee/api/)
- [Hugo Documentation](https://gohugo.io/documentation/)

## Migration Checklist

- [ ] Copy `.gitlab-ci.yml` to your repository root
- [ ] Enable GitLab Pages in project settings
- [ ] Configure CI/CD variables if needed
- [ ] Set up API tokens for auto MR feature
- [ ] Test pipeline on a non-default branch
- [ ] Test full deployment on default branch
- [ ] Configure protected branches
- [ ] Set up pipeline schedules if needed for stale issues
- [ ] Review and adjust job rules based on your workflow
