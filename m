From: Andy Ross <andy.ross@windriver.com>
Subject: Re: [PATCH 0/2] Pegatron Lucid tablet accelerometer
Date: Mon, 17 Jan 2011 14:14:29 -0800
Message-ID: <4D34BF45.30804@windriver.com>
References: <1295287011-12849-1-git-send-email-andy.ross@windriver.com> <20110117184927.GA27245@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20110117184927.GA27245@core.coreip.homeip.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Corentin Chary <corentincj@iksaif.net>, linux-input@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 01/17/2011 10:49 AM, Dmitry Torokhov wrote:
> It does not belong anywhere. Please create platform device dynamically
> (for example using platfrom_device_register_simple) and destroy it when
> done.
>
> The only time when static devices are [semi-]allowed (Greg has differing
> opioon on this I believe) is in platform/arch code for devices that can
> never be destroyed.

OK, didn't know that rule.  I honestly thought avoiding the heap
allocation for this driver (which is is stateless: the "device" is
just a single bit of information indicating the presence of three acpi
methods) would be desirable.

Fixed patch 2/2 below.

Andy

>From 83c679bc5687d293c12f566c348871fc4e55896c Mon Sep 17 00:00:00 2001
From: Andy Ross <andy.ross@windriver.com>
Date: Mon, 17 Jan 2011 09:19:58 -0800
Subject: [PATCH 2/2] asus-laptop: Support pega_accel driver

Add device detecton for the ACPI accelerometer interface on Pegatron
Lucid tablets.

Signed-off-by: Andy Ross <andy.ross@windriver.com>
---
 drivers/platform/x86/asus-laptop.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index d235f44..73f8ca0 100644
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
@@ -247,6 +249,7 @@ struct asus_laptop {
 	int wireless_status;
 	bool have_rsts;
 	int lcd_state;
+	struct platform_device *pega_accel;

 	struct rfkill *gps_rfkill;

@@ -1556,6 +1559,19 @@ static int __devinit asus_acpi_init(struct asus_laptop *asus)
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
@@ -1605,6 +1621,8 @@ static int __devinit asus_acpi_add(struct acpi_device *device)
 	if (result)
 		goto fail_rfkill;

+	asus_pega_accel_init(asus);
+
 	asus_device_present = true;
 	return 0;

@@ -1627,6 +1645,9 @@ static int asus_acpi_remove(struct acpi_device *device, int type)
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
