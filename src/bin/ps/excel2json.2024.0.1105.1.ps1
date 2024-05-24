<#
    .SYNOPSIS
    Converts an Excel sheet from a workbook to JSON.

    .DESCRIPTION
    To enable parsing of Excel Workbooks efficiently in PowerShell, this script converts a sheet from a spreadsheet into a JSON file with the same structure as the sheet.

    .PARAMETER InputFile
    The Excel Workbook to be converted. Can be FileInfo or a String.

    .PARAMETER OutputFileName
    The path to the JSON file to be created.

    .PARAMETER SheetName
    The name of the sheet from the Excel Workbook to convert. If only one sheet exists, it will convert that one.

    .PARAMETER HeaderRow
    The row number containing the header in the Excel Workbook. If not specified, defaults to the first row.

    .PARAMETER DetailRow
    The row number containing the detail data in the Excel Workbook. If not specified, defaults to the second row.

    .PARAMETER Encoding
    The character encoding to use when outputting the JSON file. If not specified, defaults to 'ascii'.
    Valid values include 'ascii', 'bigendianunicode', 'bigendianutf32', 'oem', 'unicode', 'utf7', 'utf8', 'utf8BOM', 'utf8NoBOM', 'utf32', and 'default'.

    .EXAMPLE
    Excel2JSON -InputFile MyExcelWorkbook.xlsx

    .EXAMPLE
    Get-Item MyExcelWorkbook.xlsx | Excel2JSON -OutputFileName MyConvertedFile.json -SheetName Sheet2 -HeaderRow 2 -DetailRow 3

    .NOTES
    Written by: Marinaldo de Jesus

    Find me on:
    * My blog: https://blacktdn.com.br/
    * Github: https://github.com/naldodj
#>

[CmdletBinding()]
Param(

    [Parameter(
        ValueFromPipeline=$true,
        Mandatory=$true
    )]
    [Object]$InputFile,

    [Parameter()]
    [string]$OutputFileName,

    [Parameter()]
    [string]$SheetName,

    [Parameter()]
    [int]$HeaderRow = 1,

    [Parameter()]
    [int]$DetailRow = 2

    [Parameter()]
    [string]$Encoding = "ascii"
)

#region prep
# Check what type of file $InputFile is, and update the variable accordingly
if ($InputFile -is "System.IO.FileSystemInfo") {
    $InputFile = $InputFile.FullName.ToString()
}

# Make sure the input file path is fully qualified
$InputFile = [System.IO.Path]::GetFullPath($InputFile)
Write-Verbose "Converting '$InputFile' to JSON"

# If no OutputfileName was specified, make one up
if (-not $OutputFileName) {
    $OutputFileName = [System.IO.Path]::GetFileNameWithoutExtension($(Split-Path $InputFile -Leaf))
    $OutputFileName = Join-Path $pwd ($OutputFileName + ".json")
}

# Make sure the output file path is fully qualified
$OutputFileName = [System.IO.Path]::GetFullPath($OutputFileName)

# Instantiate Excel
$excelApplication = New-Object -ComObject Excel.Application
$excelApplication.DisplayAlerts = $false
$Workbook = $excelApplication.Workbooks.Open($InputFile)

# If SheetName wasn't specified, make sure there's only one sheet
if (-not $SheetName) {
    if ($Workbook.Sheets.Count -eq 1) {
        $SheetName = @($Workbook.Sheets)[0].Name
        Write-Verbose "SheetName was not specified, but only one sheet exists. Converting '$SheetName'"
    } else {
        throw "SheetName was not specified and more than one sheet exists."
    }
} else {
    # If SheetName was specified, make sure the sheet exists
    $worksheet = $Workbook.Sheets | Where-Object {$_.Name -eq $SheetName}
    if (-not $worksheet) {
        throw "Could not locate SheetName '$SheetName' in the workbook"
    }
}

Write-Verbose "Outputting sheet '$SheetName' to '$OutputFileName'"

#endregion prep
# Grab the sheet to work with
$worksheet = $Workbook.Sheets | Where-Object {$_.Name -eq $SheetName}

# Get the range of used cells in the worksheet
$usedRange = $worksheet.UsedRange

# Get headers
$Headers = @{}
$numberOfColumns = $usedRange.Columns.Count
for ($i = 1; $i -le $numberOfColumns; $i++) {
    $cellValue = $usedRange.Cells.Item($HeaderRow, $i).Text.Trim()
    if (-not [string]::IsNullOrWhiteSpace($cellValue)) {
        $Headers.Add($i, $cellValue)
    }
}

# Get data
$data = New-Object System.Collections.ArrayList
$rowCount = $usedRange.Rows.Count
if ($rowCount -gt $HeaderRow) {
    # Get all the values from the spreadsheet at once
    $values = $usedRange.Value2
    for ($rowIndex = $DetailRow; $rowIndex -le $rowCount; $rowIndex++) {
        $rowData = @{}
        foreach ($columnIndex in $Headers.Keys) {
            $columnName = $Headers[$columnIndex]
            $cellValue = $values[$rowIndex, $columnIndex]
            $rowData[$columnName] = $cellValue
        }
        [void]$data.Add($rowData)
    }
}

# Close the Workbook
$Workbook.Close($false)

# Close Excel
$excelApplication.Quit()

# Release COM objects
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($usedRange) | Out-Null
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($worksheet) | Out-Null
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($Workbook) | Out-Null
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($excelApplication) | Out-Null

# Convert to JSON and output to file
$data | ConvertTo-Json | Out-File -Encoding $Encoding -FilePath $OutputFileName

# Garbage collection
[System.GC]::Collect()
[System.GC]::WaitForPendingFinalizers()
