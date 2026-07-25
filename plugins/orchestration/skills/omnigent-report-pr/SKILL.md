---
name: omnigent-report-pr
description: Report a pull request back to the Omnigent platform after creating one.
---
After creating a pull request, report it to Omnigent by running:

```sh
"$OMNIGENT_CLI" harness-support report-artifact pull-request --url '<url>' --branch '<branch>'
```

Replace `<url>` with the full pull request URL and `<branch>` with the branch name.
