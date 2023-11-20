# Release draft publisher

This GitHub Action publishes the latest draft release for a repository. It is intended to be used with the Release Drafter so that you can automatically release on a scheduled cadence.

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
        with:
          token: ${{ secrets.RELEASE_TOKEN }} # Needed to trigger release workflow
      - name: Release draft
        id: publish_release_draft
        uses: ./
```


## Inputs

**github_token** (required): The GitHub token to use for authentication. Defaults to `${{ secrets.GITHUB_TOKEN }}`.

## Outputs

- **release_tag**: The tag of the published release.
- **latest_tag**: The tag of the latest release.
