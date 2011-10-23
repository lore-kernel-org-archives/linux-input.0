From: chris@cnpbagwell.com
Subject: [PATCH v3 3/6] Input: wacom - add some comments to wacom_parse_hid
Date: Sun, 23 Oct 2011 17:28:57 -0500
Message-ID: <1319408940-2345-4-git-send-email-chris@cnpbagwell.com>
References: <1319408940-2345-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43993 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab1JWW3R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Oct 2011 18:29:17 -0400
Received: by mail-yx0-f174.google.com with SMTP id 42so2638796yxl.19
        for <linux-input@vger.kernel.org>; Sun, 23 Oct 2011 15:29:16 -0700 (PDT)
In-Reply-To: <1319408940-2345-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com, rydberg@euromail.se
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
Acked-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 620f0c3..5e1539c 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -165,7 +165,36 @@ static void wacom_close(struct input_dev *dev)
 		usb_autopm_put_interface(wacom->intf);
 }
 
-static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hid_desc,
+/* Interface Descriptor of wacom devices can be incomplete and
+ * inconsistent so wacom_features table is used to store stylus
+ * device's packet lengths, various maximum values, and tablet
+ * resolution based on product ID's.
+ *
+ * For devices that contain 2 interfaces, wacom_features table is
+ * inaccurate for the touch interface.  Since the Interface Descriptor
+ * for touch interfaces has pretty complete data, this function exists
+ * to query tablet for this missing information instead of hard coding in
+ * an additional table.
+ *
+ * A typical Interface Descriptor for a stylus will contain a
+ * boot mouse application collection that is not of interest and this
+ * function will ignore it.
+ *
+ * It also contains a digitizer application collection that also is not
+ * of interest since any information it contains would be duplicate
+ * of what is in wacom_features. Usually it defines a report of an array
+ * of bytes that could be used as max length of the stylus packet returned.
+ * If it happens to define a Digitizer-Stylus Physical Collection then
+ * the X and Y logical values contain valid data but it is ignored.
+ *
+ * A typical Interface Descriptor for a touch interface will contain a
+ * Digitizer-Finger Physical Collection which will define both logical
+ * X/Y maximum as well as the physical size of tablet. Since touch
+ * interfaces haven't supported pressure or distance, this is enough
+ * information to override invalid values in the wacom_features table.
+ */
+static int wacom_parse_hid(struct usb_interface *intf,
+			   struct hid_descriptor *hid_desc,
 			   struct wacom_features *features)
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
@@ -306,6 +335,11 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 				i++;
 				break;
 
+			/*
+			 * Requiring Stylus Usage will ignore boot mouse
+			 * X/Y values and some cases of invalid Digitizer X/Y
+			 * values commonly reported.
+			 */
 			case HID_USAGE_STYLUS:
 				pen = 1;
 				i++;
-- 
1.7.6.4

