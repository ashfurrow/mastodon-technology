# hello-rails

This is a demo Ruby on Rails app you can deploy to [Skyliner](https://www.skyliner.io). Here's a guide to getting started:

[https://www.skyliner.io/help/quick-start](https://www.skyliner.io/help/quick-start)

If you have any trouble, please drop us a line at [support@skyliner.io](mailto:support@skyliner.io?Subject=Help%20with%20hello-rails).

## Differences from a stock Rails application

* Writes logs to `STDOUT`.
* Serves static assets from the Rails process itself. (If static asset serving
  becomes a performance hotspot, we recommend setting up CloudFront.)
* Commits `secrets.yaml` to source control. It pulls the production secret base
  from the `SECRET_KEY_BASE` environment variable, which is securely managed by
  Skyliner.
* Adds quotes to the use of `SECRET_KEY_BASE` in `secrets.yaml`, which prevents
  a secret with all digits from being interpreted as a number.
* Depends on `puma-heroku`, which borrows Heroku's recommended Puma
  configuration.
* Manages web and worker processes using Foreman.

## Setting up background workers

* Edit `Procfile` to include a `worker` process. If you uncomment the example,
  you'll need a Rake task named `jobs:work`.
* Edit the `Dockerfile`'s `CMD` to increase the number of `worker` processes.

N.B.: Worker processes run on the same instances as the web processes, so budget
accordingly when selecting an instance type.

## Setting up a database

* Follow the directions [here](https://www.skyliner.io/help/databases) to create
  an RDS instance of your preferred database.
* Edit the `config/database.yml` file in your project and modify the
  `production` entry to look like the following:

```yaml
<dev and test stuff here>

production:
  url: "<%= ENV["DATABASE_URL"] %>"
```

* In Skyliner, go to the *Setting* page for your app and select the
  *Configuration* section.
* Click the gear to edit the settings and enter `DATABASE_URL` in the key field
  and the
  [database url](http://edgeguides.rubyonrails.org/configuring.html#configuring-a-database)
  for your database in the value field.
* Select the Skyliner environment you want the setting to apply to (*QA* or
  *Production*).
* Click *Update* to save your settings.
* Re-deploy to the environment you are interested in.

Repo created by [Skyliner](https://www.skyliner.io) app templates at 2017-04-13T15:53:02.201Z