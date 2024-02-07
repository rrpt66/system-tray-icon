# เรียกใช้งานหน้าต่างแบบฟอร์มของ .NET Framework
Add-Type -AssemblyName System.Windows.Forms

# สร้างหน้าต่างแบบฟอร์ม
$form = New-Object System.Windows.Forms.Form
$form.Text = "Anti-virus"
$form.Size = New-Object System.Drawing.Size(200,50)

# สร้างไอคอน
$icon = New-Object System.Drawing.Icon("C:\icon\icon.ico")  # ระบุ path ของไอคอนของคุณที่นี่
$notifyIcon = New-Object System.Windows.Forms.NotifyIcon
$notifyIcon.Icon = $icon
$notifyIcon.Visible = $true

# เพิ่มไอคอนไปยัง tray icon
$notifyIcon.Text = "Anti-virus"

# เพิ่มเมนูต่าง ๆ โดยใช้ ContextMenuStrip
$contextMenuStrip = New-Object System.Windows.Forms.ContextMenuStrip

# เพิ่มเมนู "Exit"
$menuItemExit = New-Object System.Windows.Forms.ToolStripMenuItem
$menuItemExit.Text = "Exit"
$menuItemExit.Add_Click({
    Stop-Process -Name "cmd"  # ปิด cmd.exe
})
$contextMenuStrip.Items.Add($menuItemExit)

# เพิ่มเมนู "Credit"
$menuItemCredit = New-Object System.Windows.Forms.ToolStripMenuItem
$menuItemCredit.Text = "Credit"
$menuItemCredit.Add_Click({
    Start-Process "https://github.com/rrpt66"  # เปิดลิ้งค์ของคุณ
})
$contextMenuStrip.Items.Add($menuItemCredit)

# เชื่อมต่อ ContextMenuStrip กับ NotifyIcon
$notifyIcon.ContextMenuStrip = $contextMenuStrip

# ให้โปรแกรมรองรับการปิด Form
$form.Add_Closing({
    $notifyIcon.Visible = $false  # ซ่อน tray icon หลังจากปิด Form
})

# แสดงหน้าต่างแบบฟอร์ม
$form.ShowDialog() | Out-Null
