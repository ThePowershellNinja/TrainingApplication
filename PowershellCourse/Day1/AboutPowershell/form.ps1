$panel = [System.Windows.Forms.Panel]@{
    BackColor = 'Yellow'
    Dock = 'Fill'
}

$label = [System.Windows.Forms.Label]@{
    Text = 'Example: About Powershell!'
}
$panel.Controls.Add($label)

Write-Output $panel