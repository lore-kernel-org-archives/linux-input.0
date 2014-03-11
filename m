From: Arkadiusz (Arkq) Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH] atkbd: Samsung NP530U3C laptop forced key release
Date: Tue, 11 Mar 2014 19:54:48 +0100
Message-ID: <20140311195448.0b722ea5@sambook>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:44019 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbaCKSzN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Mar 2014 14:55:13 -0400
Received: by mail-ea0-f176.google.com with SMTP id o10so4493684eaj.7
        for <linux-input@vger.kernel.org>; Tue, 11 Mar 2014 11:55:11 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

atkbd: Samsung NP530U3C laptop forced key release

For Samsung NP530U3C laptop (observed on firmware P09ABH) not all Fn keys
generates release event, which leaves key in a pressed state. This patch
adds those keys into the "forced release" workaround. Fixed keys: WLAN,
Settings, Fn Lock.

Patch generated for kernel version 3.13.6

Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
---

--- linux-3.13.6/drivers/input/keyboard/atkbd.c.orig	2014-03-07 07:07:02.000000000 +0100
+++ linux-3.13.6/drivers/input/keyboard/atkbd.c	2014-03-11 18:48:47.593211190 +0100
@@ -943,6 +943,13 @@ static unsigned int atkbd_samsung_forced
 };
 
 /*
+ * Samsung NP530U3C key release for WLAN, Settings and Fn Lock
+ */
+static unsigned int atkbd_samsung_np530_forced_release_keys[] = {
+	0xa8, 0xa9, 0xce, 0xd5, -1U
+};
+
+/*
  * Amilo Pi 3525 key release for Fn+Volume keys not working
  */
 static unsigned int atkbd_amilo_pi3525_forced_release_keys[] = {
@@ -1732,6 +1739,15 @@ static const struct dmi_system_id atkbd_
 		.driver_data = atkbd_samsung_forced_release_keys,
 	},
 	{
+		/* Samsung NP530U3C */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "530U3C"),
+		},
+		.callback = atkbd_setup_forced_release,
+		.driver_data = atkbd_samsung_np530_forced_release_keys,
+	},
+	{
 		/* Fujitsu Amilo PA 1510 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
