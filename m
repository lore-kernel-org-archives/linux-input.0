From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2] HID: wacom: Improve generic name generation
Date: Wed, 17 May 2017 10:52:08 -0700
Message-ID: <20170517175208.14233-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35885 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdEQRwY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 17 May 2017 13:52:24 -0400
Received: by mail-qk0-f194.google.com with SMTP id y128so2671693qka.3
        for <linux-input@vger.kernel.org>; Wed, 17 May 2017 10:52:23 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The 'wacom_update_name' function is responsible for producing names for
the input device nodes based on the hardware device name. Commit f2209d4
added the ability to strip off prefixes like "Wacom Co.,Ltd." where the
prefix was immediately (and redundantly) followed by "Wacom". The
2nd-generation Intuos Pro 2 has such a prefix, but with a small error
(the period and comma are swapped) that prevents the existing code from
matching it. We're loath to extend the number of cases out endlessly and
so instead try to be smarter about name generation.

We observe that the cause of the redundant prefixes is HID combining the
manufacturer and product strings of USB devices together. By using the
original product name (with "Wacom" prefixed, if it does not already
exist in the string) we can bypass the gyrations to find and remove
redundant prefixes. Other devices either don't have a manufacturer string
that needs to be removed (Bluetooth, uhid) or should have their name
generated from scratch (I2C).

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 90 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 30 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 838c1ebfffa9..c68458e44139 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -14,6 +14,7 @@
 #include "wacom_wac.h"
 #include "wacom.h"
 #include <linux/input/mt.h>
+#include <linux/usb.h>
 
 #define WAC_MSG_RETRIES		5
 #define WAC_CMD_RETRIES		10
@@ -2020,6 +2021,29 @@ static size_t wacom_compute_pktlen(struct hid_device *hdev)
 	return size;
 }
 
+
+static int __wacom_is_usb_parent(struct usb_device *usbdev, void *ptr)
+{
+	struct wacom *wacom = ptr;
+	struct device *parent = wacom->hdev->dev.parent;
+	struct usb_host_config *config = usbdev->actconfig;
+	int i;
+
+	for (i = 0; i < config->desc.bNumInterfaces; i++) {
+		if (&config->interface[i]->dev == parent)
+			return 1;
+	}
+	return 0;
+}
+
+/*
+ * Distinguish between real USB devices and uhid-created doppelgangers
+ */
+static bool wacom_is_real_usb(struct wacom *wacom) {
+	return wacom->hdev->bus == BUS_USB &&
+	       usb_for_each_dev(wacom, __wacom_is_usb_parent);
+}
+
 static void wacom_update_name(struct wacom *wacom, const char *suffix)
 {
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
@@ -2028,41 +2052,47 @@ static void wacom_update_name(struct wacom *wacom, const char *suffix)
 
 	/* Generic devices name unspecified */
 	if ((features->type == HID_GENERIC) && !strcmp("Wacom HID", features->name)) {
-		if (strstr(wacom->hdev->name, "Wacom") ||
-		    strstr(wacom->hdev->name, "wacom") ||
-		    strstr(wacom->hdev->name, "WACOM")) {
-			/* name is in HID descriptor, use it */
-			strlcpy(name, wacom->hdev->name, sizeof(name));
-
-			/* strip out excess whitespaces */
-			while (1) {
-				char *gap = strstr(name, "  ");
-				if (gap == NULL)
-					break;
-				/* shift everything including the terminator */
-				memmove(gap, gap+1, strlen(gap));
-			}
+		char *product_name = NULL;
 
-			/* strip off excessive prefixing */
-			if (strstr(name, "Wacom Co.,Ltd. Wacom ") == name) {
-				int n = strlen(name);
-				int x = strlen("Wacom Co.,Ltd. ");
-				memmove(name, name+x, n-x+1);
+		if (wacom->hdev->bus == BUS_USB) {
+			if (wacom_is_real_usb(wacom)) {
+				struct usb_interface *intf = to_usb_interface(wacom->hdev->dev.parent);
+				struct usb_device *dev = interface_to_usbdev(intf);
+				product_name = dev->product;
 			}
-			if (strstr(name, "Wacom Co., Ltd. Wacom ") == name) {
-				int n = strlen(name);
-				int x = strlen("Wacom Co., Ltd. ");
-				memmove(name, name+x, n-x+1);
+			else {
+				product_name = wacom->hdev->name;
 			}
+		}
+		else if (wacom->hdev->bus == BUS_BLUETOOTH) {
+			product_name = wacom->hdev->name;
+		}
 
-			/* get rid of trailing whitespace */
-			if (name[strlen(name)-1] == ' ')
-				name[strlen(name)-1] = '\0';
-		} else {
-			/* no meaningful name retrieved. use product ID */
-			snprintf(name, sizeof(name),
-				 "%s %X", features->name, wacom->hdev->product);
+		if (!product_name) {
+			snprintf(name, sizeof(name), "%s %X",
+			         features->name, wacom->hdev->product);
+		}
+		else if (strstr(product_name, "Wacom") ||
+			 strstr(product_name, "wacom") ||
+			 strstr(product_name, "WACOM")) {
+			strlcpy(name, product_name, sizeof(name));
 		}
+		else {
+			snprintf(name, sizeof(name), "Wacom %s", product_name);
+		}
+
+		/* strip out excess whitespaces */
+		while (1) {
+			char *gap = strstr(name, "  ");
+			if (gap == NULL)
+				break;
+			/* shift everything including the terminator */
+			memmove(gap, gap+1, strlen(gap));
+		}
+
+		/* get rid of trailing whitespace */
+		if (name[strlen(name)-1] == ' ')
+			name[strlen(name)-1] = '\0';
 	} else {
 		strlcpy(name, features->name, sizeof(name));
 	}
-- 
2.12.2

