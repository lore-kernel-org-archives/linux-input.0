From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: input - Add two new usages for digitizer
Date: Mon,  2 Jun 2014 17:19:52 -0700
Message-ID: <1401754792-5607-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:61992 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbaFCATy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Jun 2014 20:19:54 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so3925615pdj.6
        for <linux-input@vger.kernel.org>; Mon, 02 Jun 2014 17:19:53 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

On Feb 17, 2014, two new usages are approved to HID usage Table 18 -
Digitizer Page:

5A	Secondary Barrel Switch		MC	16.4
5B	Transducer Serial Number	SV	16.3.1

This patch adds relevant definitions to hid/input. It also removes
outdated comments in hid.h.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-debug.c | 2 ++
 drivers/hid/hid-input.c | 5 +++++
 include/linux/hid.h     | 7 ++-----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 53b771d..f299f42 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -165,6 +165,8 @@ static const struct hid_usage_entry hid_usage_table[] = {
     {0, 0x53, "DeviceIndex"},
     {0, 0x54, "ContactCount"},
     {0, 0x55, "ContactMaximumNumber"},
+    {0, 0x5A, "SecondaryBarrelSwitch"},
+    {0, 0x5B, "TransducerSerialNumber"},
   { 15, 0, "PhysicalInterfaceDevice" },
     {0, 0x00, "Undefined"},
     {0, 0x01, "Physical_Interface_Device"},
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index e7e8b19..da0267e 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -684,9 +684,14 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			break;
 
 		case 0x46: /* TabletPick */
+		case 0x5a: /* SecondaryBarrelSwitch */
 			map_key_clear(BTN_STYLUS2);
 			break;
 
+		case 0x5b: /* TransducerSerialNumber */
+			set_bit(MSC_SERIAL, input->mscbit);
+			break;
+
 		default:  goto unknown;
 		}
 		break;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 720e3a1..a468ec8 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -233,11 +233,6 @@ struct hid_item {
 #define HID_DG_BARRELSWITCH	0x000d0044
 #define HID_DG_ERASER		0x000d0045
 #define HID_DG_TABLETPICK	0x000d0046
-/*
- * as of May 20, 2009 the usages below are not yet in the official USB spec
- * but are being pushed by Microsft as described in their paper "Digitizer
- * Drivers for Windows Touch and Pen-Based Computers"
- */
 #define HID_DG_CONFIDENCE	0x000d0047
 #define HID_DG_WIDTH		0x000d0048
 #define HID_DG_HEIGHT		0x000d0049
@@ -246,6 +241,8 @@ struct hid_item {
 #define HID_DG_DEVICEINDEX	0x000d0053
 #define HID_DG_CONTACTCOUNT	0x000d0054
 #define HID_DG_CONTACTMAX	0x000d0055
+#define HID_DG_BARRELSWITCH2	0x000d005a
+#define HID_DG_TOOLSERIALNUMBER	0x000d005b
 
 /*
  * HID report types --- Ouch! HID spec says 1 2 3!
-- 
1.9.1

