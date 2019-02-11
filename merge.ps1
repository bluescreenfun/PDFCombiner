# 12.12.2018

$scriptPath = $(Split-Path -Parent $MyInvocation.MyCommand.Path) + "\"
[Reflection.Assembly]::LoadFile($scriptPath + "bin\itextsharp.dll") | Out-Null
$inputDirectory = $scriptPath + "input\"
$outputDirectory = $scriptPath + "output\"

$pdfs = ls $inputDirectory -recurse | where {-not $_.PSIsContainer -and $_.Extension -imatch "^\.pdf$"};


$outputFile = $outputDirectory + "output.pdf"
$fileStream = New-Object System.IO.FileStream($outputFile, [System.IO.FileMode]::OpenOrCreate);
$document = New-Object iTextSharp.text.Document;
$pdfCopy = New-Object iTextSharp.text.pdf.PdfCopy($document, $fileStream);
$document.Open();

foreach ($pdf in $pdfs) {
    $reader = New-Object iTextSharp.text.pdf.PdfReader($pdf.FullName);
    $pdfCopy.AddDocument($reader);
    $reader.Dispose();  
}

$pdfCopy.Dispose();
$document.Dispose();
$fileStream.Dispose();
