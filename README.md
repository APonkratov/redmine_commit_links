# Redmine Commit Links

Display links to associated commits on Redmine's issue page.

Intercepts webhooks and parses commit descriptions for mentioned issue ids.

The following platforms are supported:

* GitHub
* GitLab
* Gitea


## Requirements

* Redmine 3 (tested with 3.4.3)

## Installation

Copy plugin directoy to `{RAILS_APP}/plugins` on your Redmine
path. Run plugin migrations from your redmine root directory:

```bash
$ rake redmine:plugins:migrate RAILS_ENV=production
```

This plugin requires an additional view hook which can be added by
applying a patch to your Redmine instance. From your Redmine path run:

```bash
$ git apply plugins/redmine_commit_links/patches/view_hook_issues_show_after_details_redmine_3.4.patch
```

or if you use EasyRedmine
```bash
$ git apply plugins/redmine_commit_links/patches/view_hook_issues_show_after_details_easyredmine.patch
```

Finally, restart your redmine.


## Configuration

Create a webhook in GitLab, GitHub or Gitea as described here:

### GitLab

* Go to either the webhook page of a project (Settings > Integration)
  or the system hook page (Admin area > System Hooks).

* Enter the URL of your Redmine instance
  `http://redmine.example.com/commits/event`

* Check the "Push" trigger.

* Click "Add webhook".

### GitHub

* Go to the webhook page of a project or organization.

* Enter the URL of your Redmine instance
  `https://redmine.example.com/commits/event`.

* Select `application/json` as content type.

* Choose "Let me select individual events".

* Check the "Push" event.

* Click "Add webhook".

### Gitea

* Go to the webhook page of a project or organization.

* Enter the URL of your Redmine instance
  `https://redmine.example.com/commits/event`.

* Select `application/json` as content type.

* Choose "Custom events...".

* Check the "Push" event.

* Click "Add webhook".

### Redmine

To display associated commits on issue pages:

* Add the "View associated commits" permission to one or more
  roles.

* Enable the "Commit links" project module.


## Usage

Create a commit and reference a Redmine issue either in the
form `#123` or `REDMINE-123`. See a link to the commit appear
on the issue's Redmine page.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
