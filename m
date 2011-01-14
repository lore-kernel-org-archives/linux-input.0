From: Andy Ross <andy@windriver.com>
Subject: [PATCH 2/2] asus-laptop: Support pega_accel driver
Date: Fri, 14 Jan 2011 12:14:10 -0800
Message-ID: <1295036050-10553-3-git-send-email-andy@windriver.com>
References: <1295036050-10553-1-git-send-email-andy@windriver.com>
 <1295036050-10553-2-git-send-email-andy@windriver.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from li44-10.members.linode.com ([72.14.181.10]:36118 "EHLO
	plausible.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab1ANURR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Jan 2011 15:17:17 -0500
In-Reply-To: <1295036050-10553-2-git-send-email-andy@windriver.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Corentin Chary <corentincj@iksaif.net>, linux-input@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

From: Andy Ross <andy.ross@windriver.com>

Add device detection for the ACPI accelerometer interface on Pegatron
Lucid tablets.

Signed-off-by: Andy Ross <andy.ross@windriver.com>
---
 drivers/platform/x86/asus-laptop.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index d235f44..4a6d647 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2002-2005 Julien Lerouge, 2003-2006 Karol Kozimor
  *  Copyright (C) 2006-2007 Corentin Chary
+ *  Copyright (C) 2011 Wind River Systems
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -31,6 +32,7 @@
  *  Josh Green     - Light Sens support
  *  Thomas Tuttle  - His first patch for led support was very helpfull
  *  Sam Lin        - GPS support
+ *  Andy Ross      - Pegatron Lucid accelerometer
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -246,6 +248,7 @@ struct asus_laptop {
 
 	int wireless_status;
 	bool have_rsts;
+	bool have_pega_accel;
 	int lcd_state;
 
 	struct rfkill *gps_rfkill;
@@ -1352,6 +1355,7 @@ static const struct attribute_group asus_attr_group = {
 	.attrs		= asus_attributes,
 };
 
+
 static int asus_platform_init(struct asus_laptop *asus)
 {
 	int result;
@@ -1556,6 +1560,24 @@ static int __devinit asus_acpi_init(struct asus_laptop *asus)
 	return result;
 }
 
+static struct platform_device pega_accel_dev = {
+	.name = "pega_accel",
+	.id   = -1,
+};
+
+static void __devinit asus_pega_accel_init(struct asus_laptop *asus)
+{
+	/* Pegatron Lucid tablets expose their accelerometer through ACPI.
+	 * Check for XLR{X,Y,Z} methods */
+	if (acpi_check_handle(asus->handle, "XLRX", NULL) ||
+	    acpi_check_handle(asus->handle, "XLRY", NULL) ||
+	    acpi_check_handle(asus->handle, "XLRZ", NULL))
+		return;
+
+	if (!platform_device_register(&pega_accel_dev))
+		asus->have_pega_accel = true;
+}
+
 static bool asus_device_present;
 
 static int __devinit asus_acpi_add(struct acpi_device *device)
@@ -1605,6 +1627,8 @@ static int __devinit asus_acpi_add(struct acpi_device *device)
 	if (result)
 		goto fail_rfkill;
 
+	asus_pega_accel_init(asus);
+
 	asus_device_present = true;
 	return 0;
 
@@ -1627,6 +1651,9 @@ static int asus_acpi_remove(struct acpi_device *device, int type)
 {
 	struct asus_laptop *asus = acpi_driver_data(device);
 
+	if (asus->have_pega_accel)
+		platform_device_unregister(&pega_accel_dev);
+
 	asus_backlight_exit(asus);
 	asus_rfkill_exit(asus);
 	asus_led_exit(asus);
-- 
1.7.1

