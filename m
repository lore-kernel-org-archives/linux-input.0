From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH 2/8] HID: wacom: Move WAC_CMD_* into wacom_wac.h
Date: Wed, 25 Jan 2017 12:08:36 -0800
Message-ID: <1485374922-3417-3-git-send-email-skomra@gmail.com>
References: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35159 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751708AbdAYUJY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Jan 2017 15:09:24 -0500
Received: by mail-pf0-f196.google.com with SMTP id f144so15004502pfa.2
        for <linux-input@vger.kernel.org>; Wed, 25 Jan 2017 12:09:24 -0800 (PST)
In-Reply-To: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, benjamin.tissoires@redhat.com, pinglinux@gmail.com, killertofu@gmail.com
Cc: Jason Gerecke <jason.gerecke@wacom.com>

From: Jason Gerecke <killertofu@gmail.com>

Centralize our definition of report IDs by moving those for device commands
into wacom_wac.h alongside those for input reports.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 8 --------
 drivers/hid/wacom_wac.h | 9 +++++++++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index e1aa51a..4dd7b80 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -16,15 +16,7 @@
 #include <linux/input/mt.h>
 
 #define WAC_MSG_RETRIES		5
-
-#define WAC_CMD_WL_LED_CONTROL	0x03
-#define WAC_CMD_LED_CONTROL	0x20
-#define WAC_CMD_ICON_START	0x21
-#define WAC_CMD_ICON_XFER	0x23
-#define WAC_CMD_ICON_BT_XFER	0x26
 #define WAC_CMD_RETRIES		10
-#define WAC_CMD_DELETE_PAIRING	0x20
-#define WAC_CMD_UNPAIR_ALL	0xFF
 
 #define DEV_ATTR_RW_PERM (S_IRUGO | S_IWUSR | S_IWGRP)
 #define DEV_ATTR_WO_PERM (S_IWUSR | S_IWGRP)
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index fb0e50a..804fda3 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -72,6 +72,15 @@
 #define WACOM_REPORT_REMOTE		17
 #define WACOM_REPORT_INTUOSHT2_ID	8
 
+/* wacom command report ids */
+#define WAC_CMD_WL_LED_CONTROL          0x03
+#define WAC_CMD_LED_CONTROL             0x20
+#define WAC_CMD_ICON_START              0x21
+#define WAC_CMD_ICON_XFER               0x23
+#define WAC_CMD_ICON_BT_XFER            0x26
+#define WAC_CMD_DELETE_PAIRING          0x20
+#define WAC_CMD_UNPAIR_ALL              0xFF
+
 /* device quirks */
 #define WACOM_QUIRK_BBTOUCH_LOWRES	0x0001
 #define WACOM_QUIRK_SENSE		0x0002
-- 
2.7.4

