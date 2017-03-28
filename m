From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Improve generic name generation
Date: Tue, 28 Mar 2017 14:15:31 -0700
Message-ID: <20170328211531.4641-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34264 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbdC1VQM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Mar 2017 17:16:12 -0400
Received: by mail-pg0-f67.google.com with SMTP id o123so21364264pga.1
        for <linux-input@vger.kernel.org>; Tue, 28 Mar 2017 14:16:06 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

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
redundant prefixes. For devices connected by other busses, the problem
either doesn't exist (e.g. BUS_BLUETOOTH) or the name should be replaced
with a generic one entirely (e.g. BUS_I2C, BUS_INTEL_ISHTP).

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 65 +++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 037b9c04745a..ad5d8722fa84 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2026,41 +2026,42 @@ static void wacom_update_name(struct wacom *wacom, const char *suffix)
 
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
-			}
-			if (strstr(name, "Wacom Co., Ltd. Wacom ") == name) {
-				int n = strlen(name);
-				int x = strlen("Wacom Co., Ltd. ");
-				memmove(name, name+x, n-x+1);
-			}
+		if (wacom->hdev->bus == BUS_USB) {
+			struct usb_interface *intf = to_usb_interface(wacom->hdev->dev.parent);
+			struct usb_device *dev = interface_to_usbdev(intf);
+			product_name = dev->product;
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
 		}
+		else if (strstr(product_name, "Wacom") ||
+			 strstr(product_name, "wacom") ||
+			 strstr(product_name, "WACOM")) {
+			strlcpy(name, product_name, sizeof(name));
+		}
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
2.12.0

