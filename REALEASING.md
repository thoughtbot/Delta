# Releasing

1. Update version file accordingly.
1. Update `NEWS.md` to reflect the changes since last release.
1. Commit changes.
   There shouldn't be code changes,
   and thus CI doesn't need to run,
   you can then add "[ci skip]" to the commit message.
1. Tag the release: `git tag vVERSION`
1. Push changes: `git push --tags`
1. Build and publish:
  ```bash
  TODO...
  ```

1. Add a new GitHub release using the recent `NEWS.md` as the content. Sample
   URL: https://github.com/thoughtbot/Flux/releases/new?tag=vVERSION
1. Announce the new release,
   making sure to say "thank you" to the contributors
   who helped shape this version!
