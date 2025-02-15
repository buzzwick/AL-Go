# #13 Set up your own GitHub runner to increase build performance
*Prerequisites: An AL-Go repository setup using one of the scenarios*

When running the CI/CD workflow, the build job is by far the most time-consuming job. By adding your own GitHub Runner, which can cache the generic image, the build image and also the artifacts, the time for running the build job can become much faster.

GitHub runners can be registered for an organization (accessible for all repositories in the organization) or for a single repository.

1. Navigate to [https://github.com/organizations/{organization}/settings/actions/runners/new](https://github.com/organizations/{organization}/settings/actions/runners/new) to create a self-hosted runner for your organization. Use [https://github.com/{organization}/{repository}/settings/actions/runners](https://github.com/{organization}/{repository}/settings/actions/runners) to create a self-hosted runner for a single repository.
![Organization new runner](images/13a.png)
1. To create a self-hosted runner manually, choose Windows under Runner Image and x64 in architecture and follow the description on how to create a self-hosted runner manually, then go to step 9 to continue the configuration.
1. To create an Azure VM hosting x self-hosted runners, open a new tab and navigate to [https://aka.ms/getbuildagent](https://aka.ms/getbuildagent).
1. Enter the **Resource Group name**, **Region**, **VM Name**, **Admin Password** of your choice.
1. Enter the **number of agents** you want to create on the VM.
1. Grab the **token**, the **organization Url**, and the **Agent Url** from the Create Self-Hosted runner page, and specify **self-hosted** in labels.
![getbuildagent](images/13b.png)
1. Select **Review and Create** and then review the deployment and choose **Create**.
1. Wait for the Azure VM creation to finalize, navigate back to see that the Runners have been registered and are ready to use.
![Runners](images/13c.png)
1. On the list of Runners on GitHub, choose the runner group **Default** and allow public repositories if your repository is public.
![public](images/13f.png)
1. Now navigate to your project settings file (.AL-Go/settings.json) and set **gitHubRunner** to **self-hosted**.
1. Save and inspect your workflows performance increase on the second run.
1. Inspect that one of the runners pick up the workflow.
![Active](images/13d.png)
1. Clicking the runner reveals that the job it is running.
![Job](images/13e.png)

## Additional info on build performance

1. Running 6 CI/CD workflows simultanously, causes 1 workflow to wait as I only had 5 runners.
![Wait](images/13g.png)
1. Connecting to the runner VM and looking at utilization indicates that the VM is pretty busy and probably over-allocated when starting 5+ builds at the same time. Every build was ~50% slower than when running only 1 build.
![CPU](images/13h.png)
1. Decreasing the number of runners to 4 causes the build performance to be similar to when running just 1 build.
1. Turning off real-time protection on the self-hosted runner makes builds go ~25% faster.
![Better utilization](images/13i.png)

---
[back](../README.md)
