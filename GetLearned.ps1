Add-Type -AssemblyName System.Drawing,System.Windows.Forms

$main = [System.Windows.Forms.Form]@{
    Size = '1024,768'
    Text = 'GetLearned'
    MinimumSize = '1024,768'
}

$courseRootPath = "$PSScriptRoot/PowershellCourse"
$manifest = Get-Content -Path "$courseRootPath/Manifest.json" -Raw | ConvertFrom-Json

$splitContainer = [System.Windows.Forms.SplitContainer]@{
    Location = '0,0'
    Dock = 'Fill'
    SplitterWidth = 5
    BorderStyle = 'Fixed3D'
    SplitterDistance = 6
    IsSplitterFixed = $true
}
$splitContainer.Panel1.BackColor = "Gray"
$splitContainer.Panel2.BackColor = "White"
$main.Controls.Add($splitContainer)


$collapseExpandButton = [System.Windows.Forms.Button]@{
    #Location = '0,0'
    Size = '250,35'
    Text = '<'
    Dock = 'Bottom'
}

$treeView = [System.Windows.Forms.TreeView]@{
    Size = '250,500'
    Dock = 'Fill'
}
function InitializeTreeView {
    $treeView.Nodes.Clear()
    $treeView.BeginUpdate()
    $treeView.Nodes.Add('Powershell Class')
    $treeView.EndUpdate()
}
$splitContainer.Panel1.Controls.AddRange(@($collapseExpandButton,$treeView))



$collapseExpandButton.Add_Click({
    InitializeTreeView
    if ($splitContainer.Panel1Collapsed) {
        $splitContainer.Panel1Collapsed = $false
        $splitContainer.Panel1.Visible = $true
        $collapseExpandButton.Text = '<'
    }
    elseif ($splitContainer.Panel1Collapsed -eq $false) {
        $splitContainer.Panel1Collapsed = $true
        $collapseExpandButton.Text = '>'
        Start-Sleep -Seconds 1
        $splitContainer.Panel1Collapsed = $false
        $collapseExpandButton.Text = '<'
    }
})

[System.Windows.Forms.Application]::Run($main)