$ErrorActionPreference = "Stop"

$destination = "C:\Users\Red\Aion Server"
$servers = @("chat-server", "game-server", "login-server")

Write-Host "Packaging servers..."
mvn package

Write-Host "Preparing destination: $destination"
New-Item -ItemType Directory -Force -Path $destination | Out-Null

foreach ($server in $servers) {
	$zip = Join-Path $PSScriptRoot "$server\target\$server.zip"

	if (-not (Test-Path -LiteralPath $zip)) {
		throw "Missing expected package: $zip"
	}

	Write-Host "Copying $server.zip"
	Copy-Item -LiteralPath $zip -Destination $destination -Force
}

Write-Host "Done. Packages copied to: $destination"
