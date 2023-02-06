from prefect.deployments import Deployment
from parameterized_flow import etl_parent_flow
from prefect.filesystems import GitHub

github_dep = Deployment.build_from_flow(
    flow=etl_parent_flow,
    name="email-notification-flow-q5",
    parameters={"year":2019, "color":"green", "months":[4]},
    storage=GitHub.load("de-zoomcamp-github"),
    entrypoint="week_2_workflow_orchestration/parameterized_flow.py:etl_parent_flow"
)

if __name__ == "__main__":
    github_dep.apply()



