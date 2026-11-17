# =========================================================
# AIM ESTABLE V2 - FREE FIRE
# Configura Regedit + Raw Accel segun tu sensi, polling, DPI y FPS
# =========================================================

$config = @{}
Write-Host "=== AIM ESTABLE V2 - FREE FIRE ===" -ForegroundColor Cyan
Write-Host "Te voy a dejar la mira ultra estable, paso a paso" -ForegroundColor Yellow
Write-Host ""

# ===== PASO 1: SENSI =====
Write-Host "--- PASO 1: ELIGE TU SENSI ---" -ForegroundColor Cyan
Write-Host "1. ULTRA BAJA - Puro preciso"
Write-Host "2. BAJA"
Write-Host "3. MEDIA BAJA - La mas usada y mas estable"
Write-Host "4. MEDIA"
Write-Host "5. MEDIA ALTA"
Write-Host "6. ALTA"
Write-Host "7. MUY ALTA"
Write-Host "8. ULTRA ALTA - Puro rush escopeta"
$sensi = Read-Host "Elige (1-8)"
$config.Sensi = $sensi

# ===== PASO 2: POLLING RATE =====
Write-Host ""
Write-Host "--- PASO 2: HASTA QUE POLLING RATE LLEGA TU MOUSE? ---" -ForegroundColor Cyan
Write-Host "1. 125Hz - Mouse normal / oficina / generico"
Write-Host "2. 250Hz"
Write-Host "3. 500Hz"
Write-Host "4. 1000Hz - Lo normal gamer"
Write-Host "5. 2000Hz"
Write-Host "6. 4000Hz"
Write-Host "7. 8000Hz - Lo mas alto que existe"
Write-Host "8. 1000Hz pero no estoy seguro"
Write-Host "9. No se cuanto tiene"
Write-Host "10. Mi mouse es generico, no se"
$polling = Read-Host "Elige (1-10)"
$config.PollingRate = $polling
Write-Host "Guardado: Polling $polling" -ForegroundColor Green

# ===== PASO 3: TIENE SOFTWARE? =====
Write-Host ""
Write-Host "--- PASO 3: TU MOUSE TIENE SOFTWARE? ---" -ForegroundColor Cyan
Write-Host "1. SI, tiene software (Logitech G Hub, Razer Synapse, etc)"
Write-Host "2. NO, es generico / no tiene"
$tieneSoftware = Read-Host "Elige (1 o 2)"
$config.TieneSoftware = $tieneSoftware

if ($tieneSoftware -eq "1") {
    Write-Host ""
    Write-Host "=== COMO CAMBIAR EL POLLING RATE EN TU SOFTWARE ===" -ForegroundColor Yellow
    Write-Host "1. Abre el software de tu mouse (G Hub, Synapse, iCUE, Armoury Crate)"
    Write-Host "2. Busca tu mouse y entra a RENDIMIENTO / PERFORMANCE"
    Write-Host "3. Ahi dice POLLING RATE o REPORT RATE"
    Write-Host "4. Ponlo al maximo que soporte tu mouse, lo que pusiste arriba"
    Write-Host "5. Dale a GUARDAR / APLICAR"
    Write-Host "Si no te sale, tu mouse esta bloqueado a 1000Hz, dejalo ahi."
    Read-Host "Presiona ENTER para seguir"
}

# ===== PASO 4: PUEDES CAMBIAR DPI? =====
Write-Host ""
Write-Host "--- PASO 4: PUEDES CAMBIAR EL DPI DE TU MOUSE? ---" -ForegroundColor Cyan
Write-Host "1. SI, si puedo"
Write-Host "2. NO, no puedo / no tiene boton"
$puedeDPI = Read-Host "Elige (1 o 2)"
$config.PuedeCambiarDPI = $puedeDPI

# ===== PASO 5: FPS =====
Write-Host ""
Write-Host "--- PASO 5: A CUANTOS FPS JUEGAS? ---" -ForegroundColor Cyan
Write-Host "1. 60 - 100 FPS"
Write-Host "2. 100 - 180 FPS"
Write-Host "3. 180 - 240 FPS"
Write-Host "4. +240 FPS"
$fps = Read-Host "Elige (1-4)"
$config.FPS = $fps

# Guardar todo
$config | ConvertTo-Json | Out-File "$env:USERPROFILE\aim-config.json"
Write-Host "Tu configuracion quedo guardada!" -ForegroundColor Green

# ===== CALCULAR DPI FINAL =====
$dpiFinal = "800"
$sensRegedit = "6"
if ($sensi -eq "1") { $dpiFinal = "400"; $sensRegedit = "2" }
if ($sensi -eq "2") { $dpiFinal = "600"; $sensRegedit = "4" }
if ($sensi -eq "3") { $dpiFinal = "800"; $sensRegedit = "6" }
if ($sensi -eq "4") { $dpiFinal = "1000"; $sensRegedit = "8" }
if ($sensi -eq "5") { $dpiFinal = "1200"; $sensRegedit = "10" }
if ($sensi -eq "6") { $dpiFinal = "1600"; $sensRegedit = "12" }
if ($sensi -eq "7") { $dpiFinal = "2000"; $sensRegedit = "14" }
if ($sensi -eq "8") { $dpiFinal = "3200"; $sensRegedit = "16" }

Write-Host ""
Write-Host "=== TU CONFIGURACION FINAL ===" -ForegroundColor Cyan
if ($puedeDPI -eq "1") {
    Write-Host "DPI RECOMENDADO PARA TI: $dpiFinal DPI" -ForegroundColor Green
    Write-Host "Pon ese DPI en tu software o con el boton de tu mouse"
} else {
    Write-Host "Como no puedes cambiar DPI, te dejamos Windows en sensi estable" -ForegroundColor Yellow
}
Write-Host "DPI RECOMENDADO EN EMULADOR (BlueStacks / MSI / LDPlayer): $dpiFinal" -ForegroundColor Cyan
Write-Host "En el emulador pon: Sensibilidad General 95, Mira 90, DPI $dpiFinal"
if ($fps -eq "1") { Write-Host "FPS 60-100: Usa DPI $dpiFinal y sensi MEDIA BAJA para que no se te vaya la mira por lag" }
if ($fps -eq "4") { Write-Host "FPS +240: Puedes usar DPI alto, tu PC aguanta, tu mira va super fluida" }

# ===== PASO 6: BOTONES REGEDIT =====
Write-Host ""
Write-Host "=== BOTONES FINALES - REGEDIT ===" -ForegroundColor Cyan
Write-Host "1. APLICAR REGEDIT ESTABLE - Cambia todos los valores y deja la sensi estable"
Write-Host "2. DESACTIVAR ACELERACION DEL MOUSE"
Write-Host "3. DESACTIVAR PRECISION DEL PUNTERO (Enhance pointer precision OFF)"
Write-Host "4. APLICAR TODO JUNTO (Recomendado)"
$boton = Read-Host "Elige (1-4)"

$mousePath = "HKCU:\Control Panel\Mouse"

# Si es generico 125Hz, lo obligamos a lo mas estable
if ($tieneSoftware -eq "2" -and $puedeDPI -eq "2") {
    Write-Host "Como eres generico 125Hz, te pongo a huevo la mas estable: MEDIA BAJA (6)" -ForegroundColor Yellow
    $sensRegedit = "6"
    $dpiFinal = "800"
}

if ($boton -eq "1" -or $boton -eq "4") {
    Write-Host "Aplicando Regedit estable..."
    Set-ItemProperty -Path $mousePath -Name "MouseSpeed" -Value "0"
    Set-ItemProperty -Path $mousePath -Name "MouseThreshold1" -Value "0"
    Set-ItemProperty -Path $mousePath -Name "MouseThreshold2" -Value "0"
    Set-ItemProperty -Path $mousePath -Name "MouseSensitivity" -Value $sensRegedit
    Set-ItemProperty -Path $mousePath -Name "SmoothMouseXCurve" -Value ([byte[]](0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0))
    Set-ItemProperty -Path $mousePath -Name "SmoothMouseYCurve" -Value ([byte[]](0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0))
    Set-ItemProperty -Path $mousePath -Name "MouseHoverTime" -Value "0"
    Write-Host "Regedit aplicado! Sensi $sensRegedit" -ForegroundColor Green
}
if ($boton -eq "2" -or $boton -eq "4") {
    Write-Host "Desactivando aceleracion..."
    Set-ItemProperty -Path $mousePath -Name "MouseSpeed" -Value "0"
    Write-Host "Aceleracion OFF!" -ForegroundColor Green
}
if ($boton -eq "3" -or $boton -eq "4") {
    Write-Host "Desactivando precision del puntero..."
    Set-ItemProperty -Path $mousePath -Name "MouseSpeed" -Value "0"
    Write-Host "Precision del puntero OFF!" -ForegroundColor Green
}

# ===== PASO 7: SOLO PARA GENERICOS 125Hz =====
if ($puedeDPI -eq "2" -and $tieneSoftware -eq "2") {
    Write-Host ""
    Write-Host "==========================================" -ForegroundColor Red
    Write-Host "TU MOUSE ES GENERICO / 125Hz" -ForegroundColor Yellow
    Write-Host "No se puede subir el Polling Rate, es de tu mouse."
    Write-Host "Pero te dejamos la sensi MAS ESTABLE para 125Hz en Regedit" -ForegroundColor Yellow
    Write-Host "=========================================="
    Write-Host "Sensi en Windows: 6 (MEDIA BAJA)"
    Write-Host "Polling Rate: 125Hz (se queda asi)"
    Write-Host "DPI recomendado con Raw Accel: 800 DPI" -ForegroundColor Green
}

# ===== PASO 8: RAW ACCEL AUTOMATICO =====
Write-Host ""
Write-Host "=== RAW ACCEL AUTOMATICO ===" -ForegroundColor Magenta
Write-Host "1. DESCARGAR RAW ACCEL"
Write-Host "2. CONFIGURAR RAW ACCEL CON TU SENSI QUE YA PUSISTE"
Write-Host "3. HACER LOS 2 JUNTOS (Recomendado)"
Write-Host "4. Saltar, yo lo hago manual"
$raw = Read-Host "Elige (1-4)"

$rawPath = "$env:USERPROFILE\RawAccel"
$rawExe = "$rawPath\RawAccel.exe"

if ($raw -eq "1" -or $raw -eq "3") {
    Write-Host "Descargando Raw Accel..." -ForegroundColor Cyan
    if (!(Test-Path $rawPath)) { New-Item -ItemType Directory -Path $rawPath -Force | Out-Null }
    $url = "https://github.com/RawAccelOfficial/rawaccel/releases/download/v1.5.2/RawAccel_1.5.2.zip"
    try {
        Invoke-WebRequest -Uri $url -OutFile "$rawPath\RawAccel.zip" -UseBasicParsing
        Expand-Archive -Path "$rawPath\RawAccel.zip" -DestinationPath $rawPath -Force
        Write-Host "Raw Accel descargado en: $rawPath" -ForegroundColor Green
    } catch {
        Write-Host "No se pudo descargar automatico. Descargalo manual de: https://github.com/RawAccelOfficial/rawaccel" -ForegroundColor Red
    }
}

if ($raw -eq "2" -or $raw -eq "3") {
    Write-Host "Configurando Raw Accel con tu sensi..." -ForegroundColor Cyan
    $sensRaw = 1.0
    $dpiRaw = 800
    if ($sensi -eq "1") { $sensRaw = 0.6; $dpiRaw = 400 }
    if ($sensi -eq "2") { $sensRaw = 0.8; $dpiRaw = 600 }
    if ($sensi -eq "3") { $sensRaw = 1.0; $dpiRaw = 800 }
    if ($sensi -eq "4") { $sensRaw = 1.2; $dpiRaw = 1000 }
    if ($sensi -eq "5") { $sensRaw = 1.4; $dpiRaw = 1200 }
    if ($sensi -eq "6") { $sensRaw = 1.6; $dpiRaw = 1600 }
    if ($sensi -eq "7") { $sensRaw = 1.8; $dpiRaw = 2000 }
    if ($sensi -eq "8") { $sensRaw = 2.0; $dpiRaw = 3200 }

    if ($tieneSoftware -eq "2" -and $puedeDPI -eq "2") {
        $sensRaw = 1.0
        $dpiRaw = 800
        Write-Host "Como eres generico 125Hz, te puse lo mas estable: Sens 1.0 / DPI 800" -ForegroundColor Yellow
    }

    $configRaw = @"
{
    "Sensitivity": $sensRaw,
    "DPI": $dpiRaw,
    "Accel": 0,
    "Cap": 0,
    "Offset": 0,
    "UseRawAccel": true,
    "Comment": "Configurada por AIM ESTABLE V2 - Sensi $sensi / Polling $polling / FPS $fps"
}
"@
    $configRaw | Out-File "$rawPath\settings.json" -Encoding utf8
    Write-Host "Raw Accel configurado!" -ForegroundColor Green
    Write-Host "Sensibilidad: $sensRaw" -ForegroundColor Cyan
    Write-Host "DPI: $dpiRaw" -ForegroundColor Cyan
    Write-Host "Aceleracion: 0 (Recta, para que no se te vaya la mira)" -ForegroundColor Cyan

    if (Test-Path $rawExe) {
        Write-Host "Abriendo Raw Accel para que lo veas..."
        Start-Process $rawExe
    } else {
        Write-Host "Ya quedo el archivo settings.json creado. Abre Raw Accel y dale a Write."
    }
}

Write-Host ""
Write-Host "LISTO TOTAL! Ya tienes Regedit + Raw Accel configurado con TU sensi" -ForegroundColor Green
Write-Host "Reinicia tu emulador y ya quedo ultra estable. Suerte en tus partidas!" -ForegroundColor Yellow
