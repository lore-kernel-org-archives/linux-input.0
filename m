From: chris@cnpbagwell.com
Subject: [PATCH v3 5/6] Input: wacom - read 3rd gen Bamboo Touch HID data
Date: Sun, 23 Oct 2011 17:28:59 -0500
Message-ID: <1319408940-2345-6-git-send-email-chris@cnpbagwell.com>
References: <1319408940-2345-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58252 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412Ab1JWW3U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Oct 2011 18:29:20 -0400
Received: by mail-gx0-f174.google.com with SMTP id b1so5195119ggn.19
        for <linux-input@vger.kernel.org>; Sun, 23 Oct 2011 15:29:20 -0700 (PDT)
In-Reply-To: <1319408940-2345-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com, rydberg@euromail.se
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Override invalid pen based pktlen and x/y_max with touch
values from HID report.

Since active area of pen and touch are same on these
devices, set physical x/y size while pen x/y_max and
resolution are still valid.

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
Acked-by: Ping Cheng <pingc@wacom.com>
---

New in v3: Added packet size of Touch device to this patch to make
bisectable.

 drivers/input/tablet/wacom_sys.c |   48 ++++++++++++++++++++++++++++++++++++-
 drivers/input/tablet/wacom_wac.h |    1 +
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 5e1539c..d19886a 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -28,7 +28,9 @@
 #define HID_USAGE_Y_TILT		0x3e
 #define HID_USAGE_FINGER		0x22
 #define HID_USAGE_STYLUS		0x20
-#define HID_COLLECTION			0xc0
+#define HID_COLLECTION			0xa1
+#define HID_COLLECTION_LOGICAL		0x02
+#define HID_COLLECTION_END		0xc0
 
 enum {
 	WCM_UNDEFINED = 0,
@@ -165,6 +167,34 @@ static void wacom_close(struct input_dev *dev)
 		usb_autopm_put_interface(wacom->intf);
 }
 
+static int wacom_parse_logical_collection(unsigned char *report,
+					  struct wacom_features *features)
+{
+	int length = 0;
+
+	if (features->type == BAMBOO_PT) {
+
+		/* Logical collection is only used by 3rd gen Bamboo Touch */
+		features->pktlen = WACOM_PKGLEN_BBTOUCH3;
+		features->device_type = BTN_TOOL_DOUBLETAP;
+
+		/*
+		 * Stylus and Touch have same active area
+		 * so compute physical size based on stylus
+		 * data before its overwritten.
+		 */
+		features->x_phy = (features->x_max * features->x_resolution)
+			/ 100;
+		features->y_phy = (features->y_max * features->y_resolution)
+			/ 100;
+
+		features->x_max = features->y_max =
+			get_unaligned_le16(&report[10]);
+		length = 11;
+	}
+	return length;
+}
+
 /* Interface Descriptor of wacom devices can be incomplete and
  * inconsistent so wacom_features table is used to store stylus
  * device's packet lengths, various maximum values, and tablet
@@ -192,6 +222,10 @@ static void wacom_close(struct input_dev *dev)
  * X/Y maximum as well as the physical size of tablet. Since touch
  * interfaces haven't supported pressure or distance, this is enough
  * information to override invalid values in the wacom_features table.
+ *
+ * 3rd gen Bamboo Touch no longer define a Digitizer-Finger Pysical
+ * Collection. Instead they define a Logical Collection with a single
+ * Logical Maximum for both X and Y.
  */
 static int wacom_parse_hid(struct usb_interface *intf,
 			   struct hid_descriptor *hid_desc,
@@ -354,10 +388,20 @@ static int wacom_parse_hid(struct usb_interface *intf,
 			}
 			break;
 
-		case HID_COLLECTION:
+		case HID_COLLECTION_END:
 			/* reset UsagePage and Finger */
 			finger = usage = 0;
 			break;
+
+		case HID_COLLECTION:
+			i++;
+			switch (report[i]) {
+			case HID_COLLECTION_LOGICAL:
+				i += wacom_parse_logical_collection(&report[i],
+								    features);
+				break;
+			}
+			break;
 		}
 	}
 
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 53eb71b..af94e6d 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -22,6 +22,7 @@
 #define WACOM_PKGLEN_TPC1FG	 5
 #define WACOM_PKGLEN_TPC2FG	14
 #define WACOM_PKGLEN_BBTOUCH	20
+#define WACOM_PKGLEN_BBTOUCH3	64
 
 /* device IDs */
 #define STYLUS_DEVICE_ID	0x02
-- 
1.7.6.4

