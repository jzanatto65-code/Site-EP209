<#
.SYNOPSIS
  Atualiza a nota e o número de avaliações mostrados no hero do index.html do site EP209.

.DESCRIPTION
  Edite manualmente a nota e o número de avaliações vendo o anúncio no Airbnb,
  e este script aplica a troca no index.html (trecho "5,0 · 9 avaliações").

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File "scripts\atualizar-avaliacoes.ps1" -Nota 4.9 -Avaliacoes 12
#>
param(
    [Parameter(Mandatory = $true)]
    [ValidateRange(0, 5)]
    [double]$Nota,

    [Parameter(Mandatory = $true)]
    [ValidateRange(0, 100000)]
    [int]$Avaliacoes
)

$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$indexPath = Join-Path $root "index.html"

if (-not (Test-Path $indexPath)) {
    throw "Não encontrei $indexPath"
}

$utf8SemBom = New-Object System.Text.UTF8Encoding($false)
$conteudo = [System.IO.File]::ReadAllText($indexPath, $utf8SemBom)

$cultura = [System.Globalization.CultureInfo]::GetCultureInfo("pt-BR")
$notaTexto = $Nota.ToString("0.0", $cultura)
$palavraAvaliacao = if ($Avaliacoes -eq 1) { "avaliação" } else { "avaliações" }
$substituicao = "<strong>$notaTexto</strong> · $Avaliacoes $palavraAvaliacao"

$padrao = '<strong>\d+[,.]\d+</strong>\s*·\s*\d+\s+avalia(?:ç|c)(?:ão|ões)'

if ($conteudo -notmatch $padrao) {
    throw "Não encontrei o trecho de avaliações no index.html. Verifique se o HTML mudou de formato."
}

$novoConteudo = [regex]::Replace($conteudo, $padrao, $substituicao)

[System.IO.File]::WriteAllText($indexPath, $novoConteudo, $utf8SemBom)

Write-Host "index.html atualizado: $notaTexto - $Avaliacoes $palavraAvaliacao" -ForegroundColor Green
