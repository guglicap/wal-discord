## Git Flow

The preferred workflow to contribute to this project goes like this:

* Fork
* Write code
* Rebase and Squash

### Fork

To start working on some code, create a fork of the project first. Once the fork is created please also create a feature branch, whose name is up to you.

### Write code

Start working on the issue / feature you picked. At this stage you can create as many commits as you like, though please try to keep them significant. If you need feedback while you're working on it you can already create a PR, but prefix it with `WIP:`.

If you're making changes to the `wal-discord` script or to `master.scss` please update the relevant versions.

### Rebase and Squash

It might have happened that, while you were working on your code, the master branch has been updated. If that's the case please rebase your feature branch on master. Once that's done, squash your commits into a single one, and use as a prefix to your commit message:
* `fix:` for bug fixes
* `feat:` for new features
* `doc:` for documentation (README, CONTRIBUTING) updates.  
  
The list might be expanded in the future.  

Now force push your branch so that the PR contains a single commit. Everything should be ready to be merged now.