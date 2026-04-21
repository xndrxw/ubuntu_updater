# ubuntu_updater

This repo now also tracks the shell profile used on this machine.

## `.bashrc` sync workflow

`~/.bashrc` is symlinked to `~/ubuntu_updater/.bashrc`, so edits in either location change the same file.

Use:

```bash
bashrc-sync
```

This runs `sync-bashrc.sh`, which pulls latest changes, commits `.bashrc` if needed, and pushes to GitHub.
