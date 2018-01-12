<#
.SYNOPSIS
  Creates an npm module and a git repo in the current folder.
  Includes mocha, chai, eslint configured to follow the Google style,
  and a vscode launch file to run mocha.
#>

$Script:ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

npm init
npm install --save-dev eslint eslint-config-google mocha chai

$eslintContent = @"
module.exports = {
  "extends": "google",
  "parserOptions":{
      "ecmaVersion": 2017
  }
};
"@
Add-Content -Value $eslintContent -Path '.eslintrc.js'

$LaunchContent = @'
{
  // Use IntelliSense to learn about possible attributes.
  // Hover to view descriptions of existing attributes.
  // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Mocha Tests",
      "program": "${workspaceFolder}/node_modules/mocha/bin/_mocha",
      "args": [
        "-u",
        "tdd",
        "--timeout",
        "200000",
        "--colors",
        "${workspaceFolder}/test"
      ],
      "internalConsoleOptions": "openOnSessionStart"
    },
    {
      "type": "node",
      "request": "launch",
      "name": "Launch Program",
      "program": "${workspaceFolder}\\index.js"
    }
  ]
}
'@
New-Item -Path '.vscode' -ItemType Directory
Add-Content -Value $LaunchContent -Path '.vscode/launch.json'

New-Item -Path 'test' -ItemType Directory

Add-Content -Value 'node_modules/' -Path '.gitignore'
git init
git add .
git commit -m 'The beginning'