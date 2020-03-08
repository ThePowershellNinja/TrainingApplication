$panel = [System.Windows.Forms.Panel]@{
    BackColor = 'Red'
    Dock = 'Fill'
}

$label = [System.Windows.Forms.Label]@{
    Text = 'Example: Help System!'
}
$panel.Controls.Add($label)

Write-Output $panel