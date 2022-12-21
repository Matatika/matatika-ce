# matatika-ce
Community Edition of the Matatika Data Platform

1. Install

```
git clone https://github.com/Matatika/matatika-ce
cd matatika-ce
export userID=$(id -u); export groupID=$(id -g)
docker-compose up
```
In order to persist the userID and groupID variables, please add those to your .bashrc profile.
To always be up to date with our latest changes, make sure that you run git pull to update your code from matatika-ce repository.

2. Register, Login and create workspace

https://localhost:3443

Your workspaces will be created in `./workspaces` by default.  Configure this with `MATATIKA_WORKSPACES_HOME` in your docker-compose.yml


3. Configure your first pipeline

Install `analyze-github` plugin and supply mandatory settings.

Available plugins can be found in `./plugins` by default.  Configure this with `MATATIKA_PLUGINS_HOME` in your docker-compose.yml


4. Running your pipelines

`analyze-github` is supplied with a default pipeline to import your data and some default datasets.


5. Share your data with the App or API

Create new datasets in `[your-workspace]/analyze/datasets`
