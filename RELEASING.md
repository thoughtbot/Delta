# Releasing

1. Update version file accordingly.
1. Commit changes.
1. Tag the release: `git tag vVERSION`
1. Push changes: `git push --tags`
1. Build the binary to attach to the release:
  ```bash
  bin/archive
  ```

1. Add a new GitHub release and populate the content. Sample
   URL: https://github.com/thoughtbot/Delta/releases/new?tag=vVERSION
1. Announce the new release,
   making sure to say "thank you" to the contributors
   who helped shape this version!
