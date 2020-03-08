$panel = [System.Windows.Forms.Panel]@{
    BackColor = 'Blue'
    Dock = 'Fill'
}

$label = [System.Windows.Forms.Label]@{
    Text = 'Example: Running Commands!'
}
$panel.Controls.Add($label)

Write-Output $panel