From: Sebastian Frei <dr.nop@gmx.net>
Subject: [PATCH] wistron_btns.c: Add DMI entry for Medion WIM2030 laptop
Date: Sat, 19 Sep 2009 12:43:09 +0200
Message-ID: <200909191243.09243.dr.nop@gmx.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932172AbZISKnb@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mitr@volny.cz
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This patch adds a DMI entry for the Medion WIM2030 laptop.

Signed-off-by: Sebastian Frei <dr.nop@gmx.net>

--- linux-2.6.31.orig/drivers/input/misc/wistron_btns.c
+++ linux-2.6.31/drivers/input/misc/wistron_btns.c
@@ -669,6 +669,15 @@
        },
        {
                .callback = dmi_matched,
+               .ident = "Medion MD 42200",
+               .matches = {
+                       DMI_MATCH(DMI_SYS_VENDOR, "Medion"),
+                       DMI_MATCH(DMI_PRODUCT_NAME, "WIM 2030"),
+               },
+               .driver_data = keymap_fs_amilo_pro_v2000
+       },
+       {
+               .callback = dmi_matched,
                .ident = "Fujitsu N3510",
                .matches = {
                        DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
