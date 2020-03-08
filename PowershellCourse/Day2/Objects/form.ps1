$panel = [System.Windows.Forms.Panel]@{
    BackColor = 'Green'
    Dock = 'Fill'
}

$label = [System.Windows.Forms.Label]@{
    Text = 'Example: Objects!'
}
$panel.Controls.Add($label)

Write-Output $panel