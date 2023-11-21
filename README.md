# Publish release draft

This GitHub Action publishes the latest draft release for a repository. It is intended to be used with the [Release Drafter](https://github.com/release-drafter/release-drafter) so that you can automatically release on a scheduled cadence.

## Usage

```yaml
name: Publish release draft

on:
  schedule:
    - cron: '0 0 * * 0' # Run every Sunday at midnight
  workflow_dispatch: # Run if action manually triggered

permissions:
  contents: write # Needed to publish a draft release

jobs:

  publish-release:
    runs-on: ubuntu-latest
    outputs:
      release_tag: ${{ steps.publish_release_draft.outputs.release_tag }}
      latest_tag: ${{ steps.publish_release_draft.outputs.latest_tag }}
    steps:
      - uses: actions/checkout@v4
      - name: Release draft
        id: publish_release_draft
        uses: athackst/publish-release-draft@main

  # Optional to run release workflow when released
  release-workflow:
    if: ${{ needs.publish-release.outputs.release_tag != ''}}
    needs: publish-release
    uses: athackst/publish-release-draft/.github/workflows/release.yml@main
```


## Inputs

- **github_token** (required): The GitHub token to use for authentication. Defaults to `${{ secrets.GITHUB_TOKEN }}`.

## Outputs

- **release_tag**: The tag of the published release.
- **latest_tag**: The tag of the latest release.
