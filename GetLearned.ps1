Add-Type -AssemblyName System.Drawing,System.Windows.Forms

$main = [System.Windows.Forms.Form]@{
    Size = '1024,768'
    Text = 'GetLearned'
    MinimumSize = '1024,768'
}

$splitContainer = [System.Windows.Forms.SplitContainer]@{
    Size = '{0},{1}' -f $main.ClientSize.Width,$main.ClientSize.Height
    Location = '0,0'
    Dock = 'Fill'
    SplitterWidth = 5
    BorderStyle = 'Fixed3D'
    SplitterDistance = 4
}
$splitContainer.Panel1.BackColor = "Gray"
$splitContainer.Panel2.BackColor = "White"

$collapseExpandButton = [System.Windows.Forms.Button]@{
    Size = '25,25'
    Text = '<'
    Location = '5,5'
}

$collapseExpandButton.Add_Click({
    if ($splitContainer.Panel1Collapsed) {
        $splitContainer.Panel1Collapsed = $false
        $splitContainer.Panel1.Visible = $true
        $collapseExpandButton.Text = '<'
    }
    elseif ($splitContainer.Panel1Collapsed -eq $false) {
        $splitContainer.Panel1Collapsed = $true
        $collapseExpandButton.Text = '>'
        Start-Sleep -Seconds 1
        $collapseExpandButton.PerformClick()
    }
})

$splitContainer.Panel1.Controls.AddRange(@($collapseExpandButton))
$main.Controls.AddRange(@($splitContainer))
[System.Windows.Forms.Application]::Run($main)