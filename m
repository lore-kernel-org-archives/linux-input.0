From: Daniel Axtens <dja@axtens.net>
Subject: [PATCH] HID: holtekff: move MODULE_* parameters out of #ifdef block
Date: Sun, 26 Nov 2017 15:34:04 +1100
Message-ID: <20171126043404.11621-1-dja@axtens.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33494 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751902AbdKZEen (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Nov 2017 23:34:43 -0500
Received: by mail-pl0-f67.google.com with SMTP id a12so6524058pll.0
        for <linux-input@vger.kernel.org>; Sat, 25 Nov 2017 20:34:43 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, anssi.hannula@iki.fi
Cc: Daniel Axtens <dja@axtens.net>

If you compile with:
CONFIG_HID_HOLTEK=m
CONFIG_HOLTEK_FF is not set

You get the following warning:
WARNING: modpost: missing MODULE_LICENSE() in drivers/hid/hid-holtekff.o
see include/linux/module.h for more information

Fix this by moving the module info out of the #ifdef CONFIG_HOLTEK_FF
block and into the un-guarded part of the file.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/hid/hid-holtekff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-holtekff.c b/drivers/hid/hid-holtekff.c
index 9325545fc3ae..edc0f64bb584 100644
--- a/drivers/hid/hid-holtekff.c
+++ b/drivers/hid/hid-holtekff.c
@@ -32,10 +32,6 @@
 
 #ifdef CONFIG_HOLTEK_FF
 
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Anssi Hannula <anssi.hannula@iki.fi>");
-MODULE_DESCRIPTION("Force feedback support for Holtek On Line Grip based devices");
-
 /*
  * These commands and parameters are currently known:
  *
@@ -223,3 +219,7 @@ static struct hid_driver holtek_driver = {
 	.probe = holtek_probe,
 };
 module_hid_driver(holtek_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Anssi Hannula <anssi.hannula@iki.fi>");
+MODULE_DESCRIPTION("Force feedback support for Holtek On Line Grip based devices");
-- 
2.11.0

