# File: scripts/update-marketplace-recursive.ps1
$ErrorActionPreference = "Stop"

$MarketplacePath = ".claude-plugin\marketplace.json"
$SkillsDir = "skills"

if (!(Test-Path $SkillsDir)) {
    throw "Skills directory not found: $SkillsDir"
}

if (!(Test-Path $MarketplacePath)) {
    throw "Marketplace file not found: $MarketplacePath"
}

$marketplace = Get-Content $MarketplacePath -Raw | ConvertFrom-Json

# 递归查找所有 SKILL.md 文件所在目录
$skills = Get-ChildItem $SkillsDir -Recurse -Directory |
    Where-Object { Test-Path (Join-Path $_.FullName "SKILL.md") } |
    Sort-Object FullName |
    ForEach-Object {
        # 将绝对路径转换为相对路径
        $relative = $_.FullName.Substring((Get-Location).Path.Length)
        $relative = $relative -replace "^\\+", "."  # 开头斜杠替换为 .
        $relative = $relative -replace "\\", "/"    # Windows 路径反斜杠替换为 /
        $relative
    }

if ($null -eq $marketplace.plugins -or $marketplace.plugins.Count -eq 0) {
    throw "No plugins found in marketplace.json"
}

$marketplace.plugins[0].skills = $skills

$marketplace |
    ConvertTo-Json -Depth 20 |
    Set-Content $MarketplacePath -Encoding UTF8

Write-Host "Updated $MarketplacePath"
Write-Host "Detected skills:"
$skills | ForEach-Object { Write-Host " - $_" }