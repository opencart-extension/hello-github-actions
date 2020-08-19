const core = require('@actions/core')
const github = require('@actions/github')

core.setOutput('Número do issue', github.context.issue.number)