# matatika-lab
Community Edition of the Matatika Data Platform

1. Install

```
git clone https://github.com/Matatika/matatika-ce
docker-compose up
```


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
