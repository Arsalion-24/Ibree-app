# GitHub Push Instructions

## Repository Information

- **Repository URL**: https://github.com/Arsalion-24/Ibree-app
- **Owner**: Arsalion-24
- **Package**: com.ebeere.games

## Quick Push (for authorized users)

```bash
cd /project/workspace/Ibree-app

# Make sure you're authenticated with GitHub
git add .
git commit -m "Your commit message"
git push origin main
```

## First Time Setup

```bash
cd /project/workspace/Ibree-app

# Configure git user
git config user.name "Your Name"
git config user.email "your.email@example.com"

# Initialize repository (if needed)
git init

# Add all files
git add .

# Create commit
git commit -m "Initial commit"

# Add remote (use your GitHub credentials)
git remote add origin https://github.com/Arsalion-24/Ibree-app.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## Using Personal Access Token (PAT)

If you're using a PAT for authentication:

```bash
# Option 1: Enter PAT when prompted
git push origin main
# Username: Arsalion-24
# Password: [paste your PAT]

# Option 2: Use git credential helper
git config credential.helper store
git push origin main
# Enter credentials once, they'll be stored
```

## Important Notes

1. **Never commit PAT tokens** to the repository
2. **Use .gitignore** to exclude sensitive files:
   - `google-services.json`
   - `GoogleService-Info.plist`
   - `key.properties`

3. **Repository is currently public** - consider making it private for sensitive projects

## Troubleshooting

### Authentication Failed
- Verify your GitHub credentials
- Check PAT permissions (repo, workflow)
- Ensure PAT hasn't expired

### Push Rejected
- Pull latest changes first: `git pull origin main`
- Or force push (careful!): `git push origin main --force`

### Large Files
- Files over 100MB cannot be pushed
- Use Git LFS for large assets
- Check .gitignore excludes large files

## Repository Management

### Create New Branch
```bash
git checkout -b feature/new-feature
git push -u origin feature/new-feature
```

### Pull Latest Changes
```bash
git pull origin main
```

### Check Status
```bash
git status
git log --oneline -n 10
```

## CI/CD Integration

Consider setting up GitHub Actions for:
- Automated builds
- Testing
- Code quality checks
- Deployment

## Contact

For repository access or issues, contact the repository owner.

---

**Repository**: https://github.com/Arsalion-24/Ibree-app
