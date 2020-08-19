const core = require('@actions/core')
const github = require('@actions/github')

core.setOutput('Número do issue', github.context.issue.number)
core.setOutput('Repo', ':: Nome do Repositório ::')
core.setOutput('number', '123456789')

module.exports = (':/')

console.log('Tristonho!')
console.log('Senha :: ' + core.getInput('SENHA'))
console.log('Issue Code: ' + github.context.issue.number)
console.log(`::set-output name=Repo::${github.context.issue.repo}`)

return 'Poxa...'
