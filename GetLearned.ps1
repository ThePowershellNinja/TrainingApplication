Add-Type -AssemblyName System.Drawing,System.Windows.Forms

$main = [System.Windows.Forms.Form]@{
    Size = '1024,768'
    Text = 'GetLearned'
    MinimumSize = '1024,768'
}

$courseRootPath = "$PSScriptRoot\PowershellCourse"
$manifest = Get-Content -Path "$courseRootPath\Manifest.json" -Raw | ConvertFrom-Json

$splitContainer = [System.Windows.Forms.SplitContainer]@{
    Dock = 'Fill'
    SplitterWidth = 2
    BorderStyle = 'Fixed3D'
    SplitterDistance = 650
    #IsSplitterFixed = $true
    FixedPanel = 'Panel1'
}
$splitContainer.Panel1.BackColor = "Gray"
$splitContainer.Panel2.BackColor = "White"
$main.Controls.Add($splitContainer)

$collapseExpandButton = [System.Windows.Forms.Button]@{
    #Location = '0,0'
    Size = '350,35'
    Text = '<'
    Dock = 'Bottom'
}

$treeView = [System.Windows.Forms.TreeView]@{
    Size = '350,500'
    Dock = 'Fill'
}
function InitializeTreeView {
    $treeView.Nodes.Clear()
    $treeView.BeginUpdate()
    $treeView.Nodes.Add('Powershell Class')
    foreach ($object in $manifest) {
        if (($treeView.Nodes | Select-Object -ExpandProperty Text) -notcontains $object.Parent) {
            $treeView.Nodes.Add($object.Parent)
        }
        if ((($treeView.Nodes | Where-Object {$_.Text -eq $object.Parent}).Nodes | Select-Object -ExpandProperty Text) -notcontains $object.Name){
            ($treeView.Nodes | Where-Object {$_.Text -eq $object.Parent}).Nodes.Add($object.Name)
        }
    }
    $treeView.EndUpdate()
}
$splitContainer.Panel1.Controls.AddRange(@($collapseExpandButton,$treeView))

$collapseExpandButton.Add_Click({
    InitializeTreeView
    if ($splitContainer.Panel1Collapsed) {
        $splitContainer.Panel1Collapsed = $false
        #$splitContainer.Panel1.Visible = $true
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

$treeView.Add_NodeMouseClick({
    $selectedNode = $_.Node.Text
    $formPath = '{0}\{1}\form.ps1' -f $courseRootPath, ($manifest | Where-Object {$_.Name -eq $selectedNode} | Select-Object -ExpandProperty 'Path')

    if (Test-Path $formPath){
        $splitContainer.Panel2.Controls.Clear()
        $contentPanel = & $formPath
        $splitContainer.Panel2.Controls.Add($contentPanel)
    }
})

[System.Windows.Forms.Application]::Run($main)