From: Andy Ross <andy.ross@windriver.com>
Subject: [PATCH 3/4] asus-laptop: Support pega_accel accelerometer driver
Date: Mon, 24 Jan 2011 14:48:07 -0800
Message-ID: <1295909288-32650-4-git-send-email-andy.ross@windriver.com>
References: <1295909288-32650-1-git-send-email-andy.ross@windriver.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1295909288-32650-1-git-send-email-andy.ross@windriver.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Corentin Chary <corentincj@iksaif.net>, linux-input@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add device detecton for the ACPI accelerometer interface on Pegatron
Lucid tablets.

Signed-off-by: Andy Ross <andy.ross@windriver.com>
---
 drivers/platform/x86/asus-laptop.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index b397a4c..75c84f8 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -261,6 +261,7 @@ struct asus_laptop {
 	bool have_rsts;
 	bool have_pega_lucid;
 	int lcd_state;
+	struct platform_device *pega_accel;
 
 	struct rfkill *gps_rfkill;
 
@@ -1631,6 +1632,19 @@ static int __devinit asus_acpi_init(struct asus_laptop *asus)
 	return result;
 }
 
+static void __devinit asus_pega_accel_init(struct asus_laptop *asus)
+{
+	/* Pegatron Lucid tablets expose their accelerometer through ACPI.
+	 * Check for XLR{X,Y,Z} methods */
+	if (acpi_check_handle(asus->handle, "XLRX", NULL) ||
+	    acpi_check_handle(asus->handle, "XLRY", NULL) ||
+	    acpi_check_handle(asus->handle, "XLRZ", NULL))
+		return;
+
+	asus->pega_accel = platform_device_register_simple("pega_accel", -1,
+							   NULL, 0);
+}
+
 static bool asus_device_present;
 
 static int __devinit asus_acpi_add(struct acpi_device *device)
@@ -1681,6 +1695,8 @@ static int __devinit asus_acpi_add(struct acpi_device *device)
 		goto fail_rfkill;
 
 	asus->have_pega_lucid = asus_check_pega_lucid(asus);
+	if (asus->have_pega_lucid)
+		asus_pega_accel_init(asus);
 
 	asus_device_present = true;
 	return 0;
@@ -1704,6 +1720,9 @@ static int asus_acpi_remove(struct acpi_device *device, int type)
 {
 	struct asus_laptop *asus = acpi_driver_data(device);
 
+	if (asus->pega_accel)
+		platform_device_unregister(asus->pega_accel);
+
 	asus_backlight_exit(asus);
 	asus_rfkill_exit(asus);
 	asus_led_exit(asus);
-- 
1.7.1
