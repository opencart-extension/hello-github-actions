const core = require('@actions/core')
const github = require('@actions/github')

core.setOutput('Número do issue', github.context.issue.number)
core.setOutput('Repo', github.context.issue.repo)
core.setOutput('number', '123456789')