# FuelPay Git Workflow & Branching Strategy

## 🌳 Branch Structure

### Main Branches

**`main`** - Production-ready branch
- Protected branch (no direct commits)
- Only receives merged PRs after verification
- Always in working state
- Tags for releases

**`develop`** - Integration branch
- Development features are merged here
- Should be stable but may have incomplete features
- Base for creating feature branches

### Feature Branches

**Naming Convention**: `feat/<feature-name>`

Examples:
```
feat/phase-1-setup
feat/phase-2-theme-system
feat/phase-3-authentication
feat/auth-otp-login
feat/payment-razorpay-integration
```

**Lifecycle**:
1. Create from `develop`
2. Work on feature
3. Make meaningful commits
4. Open PR for review
5. Merge back to `develop`
6. Delete after merge

### Bug Fix Branches

**Naming Convention**: `fix/<bug-name>`

Examples:
```
fix/auth-token-refresh
fix/payment-webhook-signature
```

### Hotfix Branches

**Naming Convention**: `hotfix/<issue-name>`

- Created from `main` when urgent fix needed
- Merged back to both `main` and `develop`

## 📝 Commit Message Convention

### Format
```
<type>: <short description>

<optional detailed description>
```

### Types
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation
- `style` - Code style (formatting, missing semicolons, etc)
- `refactor` - Code refactoring
- `perf` - Performance improvement
- `test` - Test addition/modification
- `chore` - Build, dependencies, CI/CD
- `ci` - CI/CD pipeline changes

### Examples

**Good commits** ✅:
```
feat: core configuration layer (constants, env, logger, exceptions, router)
feat: premium dark fintech theme (neon green + electric blue)
feat: utility extensions (30+ dart/flutter helpers)
feat: app entry point and production dependencies
docs: comprehensive project documentation and architecture guide
fix: auth token refresh race condition
test: add unit tests for payment validation
chore: update flutter dependencies to latest versions
```

**Bad commits** ❌:
```
update files
fix
working on stuff
temporary commit
asdf
```

## 🔄 Development Workflow

### 1. Starting a New Phase

```bash
# Update develop branch
git checkout develop
git pull origin develop

# Create feature branch from develop
git checkout -b feat/phase-N-description

# Work on feature...
```

### 2. Committing Changes

```bash
# Stage specific files
git add path/to/file1 path/to/file2

# Commit with meaningful message
git commit -m "feat: brief description"

# Or add more context
git commit -m "feat: short description

- Added X component
- Implemented Y functionality
- Fixed Z issue"
```

### 3. Pushing to Remote

```bash
# First time pushing branch
git push -u origin feat/phase-N-description

# Subsequent pushes
git push origin feat/phase-N-description
```

### 4. Creating Pull Request

- Push to feature branch
- Create PR on GitHub
- Request review
- Wait for approval
- Merge to develop after review

### 5. Merging to Main

After feature is complete and tested:

```bash
# Merge develop to main (only after verification)
git checkout main
git pull origin main
git merge develop
git push origin main
git tag -a v1.N.0 -m "Release version 1.N.0"
git push origin v1.N.0
```

## 📊 Current Phase Workflow

### Phase 1: Project Setup & Architecture ✅

**Branch**: `feat/phase-1-setup`

**Commits**:
1. ✅ `feat: core configuration layer`
2. ✅ `feat: premium dark fintech theme`
3. ✅ `feat: utility extensions`
4. ✅ `feat: app entry point and dependencies`
5. ✅ `chore: environment configuration`
6. ✅ `docs: comprehensive documentation`

**Status**: Ready for review

**Next Action**: Verify working → Merge to develop → Tag release

---

### Phase 2: Theme System (Next)

**Branch**: `feat/phase-2-theme-system` (to be created)

**Expected Commits**:
1. `feat: reusable ui components (buttons, cards, appbars)`
2. `feat: glassmorphic design system`
3. `feat: shared widgets library`
4. `feat: lottie animations setup`
5. `feat: typography system`
6. `test: add widget tests for components`

---

## ✅ Verification Checklist Before Merging

Before merging feature branch to develop/main:

- [ ] Code compiles without errors
- [ ] All tests pass (unit, widget, integration)
- [ ] No console warnings or errors
- [ ] Code follows project conventions
- [ ] Documentation is updated
- [ ] Meaningful commit messages
- [ ] No debug prints left
- [ ] No hardcoded values
- [ ] Security review done
- [ ] Performance considerations addressed

## 🔐 Protected Branch Rules

**Main Branch Protection**:
- Require PR reviews before merge
- Require status checks to pass
- Require branches to be up to date
- Dismiss stale PR approvals
- Require signed commits (optional)

## 📚 Quick Commands

```bash
# View current branch
git branch

# List all branches
git branch -a

# Delete local branch
git branch -d feat/branch-name

# Delete remote branch
git push origin --delete feat/branch-name

# View commit log
git log --oneline

# View changes
git diff

# Stash changes
git stash

# Pop stashed changes
git stash pop

# Rebase current branch
git rebase develop

# Merge current branch
git merge develop
```

## 🎯 Rules for FuelPay Project

1. **Always create feature branches** - Never work directly on main/develop
2. **One feature per branch** - Keep scope focused
3. **Meaningful commits** - Use proper commit messages
4. **Small, logical commits** - Not one giant commit per phase
5. **No direct main branch pushes** - Always go through PR/review
6. **Test before merging** - Verify app works
7. **Update documentation** - Keep docs in sync with code
8. **Delete merged branches** - Keep repo clean

---

## 🚀 FuelPay Release Cycle

```
Feature Development
        ↓
   feat/phase-X branch
        ↓
   Multiple meaningful commits
        ↓
   Push to remote
        ↓
   Create PR to develop
        ↓
   Code review + testing
        ↓
   Merge to develop
        ↓
   Integration testing
        ↓
   PR to main
        ↓
   Final verification
        ↓
   Merge to main + Tag release
        ↓
   Deploy to staging/production
```

---

**Last Updated**: 2024  
**Version**: 1.0
