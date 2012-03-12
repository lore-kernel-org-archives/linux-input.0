From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2 4/4] input: wacom: Intuos5 multitouch sensor support
Date: Mon, 12 Mar 2012 15:36:45 -0700
Message-ID: <1331591805-4014-1-git-send-email-killertofu@gmail.com>
References: <1331345166-1022-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46988 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab2CLWhU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Mar 2012 18:37:20 -0400
Received: by yenl12 with SMTP id l12so3151039yen.19
        for <linux-input@vger.kernel.org>; Mon, 12 Mar 2012 15:37:18 -0700 (PDT)
In-Reply-To: <1331345166-1022-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, chris@cnpbagwell.com, linuxwacom-devel@lists.sourceforge.net
Cc: Jason Gerecke <killertofu@gmail.com>

Intuos5 tablets with PTH-* model numbers include a multitouch sensor
which use the same touch reports as the 3rd-generation Bamboo. No
useful information is in the HID descriptor for the touch interface
so hardcoded values are used during setup.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
Changes from v1:
 * Fixed calculation of x_phy and y_phy (logic for the 3rd-gen Bamboo
   which I copied is incorrect! Patch on the way.)

 drivers/input/tablet/wacom_sys.c |   24 ++++++++++++++
 drivers/input/tablet/wacom_wac.c |   63 +++++++++++++++++++++++++++++++++++---
 2 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 11b4c05..528e3a4 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -228,6 +228,9 @@ static int wacom_parse_logical_collection(unsigned char *report,
  * 3rd gen Bamboo Touch no longer define a Digitizer-Finger Pysical
  * Collection. Instead they define a Logical Collection with a single
  * Logical Maximum for both X and Y.
+ *
+ * Intuos5 touch interface does not contain useful data. We deal with
+ * this after returning from this function.
  */
 static int wacom_parse_hid(struct usb_interface *intf,
 			   struct hid_descriptor *hid_desc,
@@ -924,6 +927,27 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	if (error)
 		goto fail3;
 
+	/* Intuos5 has no useful data about its touch interface in its
+	 * HID descriptor. If this is the touch interface (wMaxPacketSize
+	 * of WACOM_PKGLEN_BBTOUCH3), override the table values.
+	 */
+	if (features->type >= INTUOS5S && features->type <= INTUOS5L) {
+		if (endpoint->wMaxPacketSize == WACOM_PKGLEN_BBTOUCH3) {
+			features->device_type = BTN_TOOL_FINGER;
+			features->pktlen = WACOM_PKGLEN_BBTOUCH3;
+
+			features->x_phy =
+				(features->x_max * 100) / features->x_resolution;
+			features->y_phy =
+				(features->y_max * 100) / features->y_resolution;
+
+			features->x_max = 4096;
+			features->y_max = 4096;
+		} else {
+			features->device_type = BTN_TOOL_PEN;
+		}
+	}
+
 	wacom_setup_device_quirks(features);
 
 	strlcpy(wacom_wac->name, features->name, sizeof(wacom_wac->name));
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 86827c7..30067ae 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -321,6 +321,9 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 
 	/* Enter report */
 	if ((data[1] & 0xfc) == 0xc0) {
+		if (features->type >= INTUOS5S && features->type <= INTUOS5L)
+			wacom->shared->stylus_in_proximity = true;
+
 		/* serial number of the tool */
 		wacom->serial[idx] = ((data[3] & 0x0f) << 28) +
 			(data[4] << 20) + (data[5] << 12) +
@@ -406,6 +409,9 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 
 	/* Exit report */
 	if ((data[1] & 0xfe) == 0x80) {
+		if (features->type >= INTUOS5S && features->type <= INTUOS5L)
+			wacom->shared->stylus_in_proximity = false;
+
 		/*
 		 * Reset all states otherwise we lose the initial states
 		 * when in-prox next time
@@ -1111,9 +1117,6 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 	case INTUOS4S:
 	case INTUOS4:
 	case INTUOS4L:
-	case INTUOS5S:
-	case INTUOS5:
-	case INTUOS5L:
 	case CINTIQ:
 	case WACOM_BEE:
 	case WACOM_21UX2:
@@ -1121,6 +1124,15 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		sync = wacom_intuos_irq(wacom_wac);
 		break;
 
+	case INTUOS5S:
+	case INTUOS5:
+	case INTUOS5L:
+		if (len == WACOM_PKGLEN_BBTOUCH3)
+			sync = wacom_bpt3_touch(wacom_wac);
+		else
+			sync = wacom_intuos_irq(wacom_wac);
+		break;
+
 	case TABLETPC:
 	case TABLETPC2FG:
 		sync = wacom_tpc_irq(wacom_wac, len);
@@ -1191,7 +1203,7 @@ void wacom_setup_device_quirks(struct wacom_features *features)
 
 	/* these device have multiple inputs */
 	if (features->type == TABLETPC || features->type == TABLETPC2FG ||
-	    features->type == BAMBOO_PT)
+	    features->type == BAMBOO_PT || (features->type >= INTUOS5S && features->type <= INTUOS5L))
 		features->quirks |= WACOM_QUIRK_MULTI_INPUT;
 
 	/* quirk for bamboo touch with 2 low res touches */
@@ -1350,13 +1362,54 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 	case INTUOS5:
 	case INTUOS5L:
+		if (features->device_type == BTN_TOOL_PEN) {
+			__set_bit(BTN_7, input_dev->keybit);
+			__set_bit(BTN_8, input_dev->keybit);
+		}
+		/* fall through */
+
+	case INTUOS5S:
+		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
+
+		if (features->device_type == BTN_TOOL_PEN) {
+			for (i = 0; i < 7; i++)
+				__set_bit(BTN_0 + i, input_dev->keybit);
+
+			input_set_abs_params(input_dev, ABS_DISTANCE, 0,
+					      features->distance_max,
+					      0, 0);
+
+			input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
+
+			wacom_setup_intuos(wacom_wac);
+		} else if (features->device_type == BTN_TOOL_FINGER) {
+			__clear_bit(ABS_MISC, input_dev->absbit);
+
+			__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
+			__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
+			__set_bit(BTN_TOOL_TRIPLETAP, input_dev->keybit);
+			__set_bit(BTN_TOOL_QUADTAP, input_dev->keybit);
+
+			input_mt_init_slots(input_dev, 16);
+
+			input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
+			                     0, 255, 0, 0);
+
+			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
+					     0, features->x_max,
+					     features->x_fuzz, 0);
+			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
+					     0, features->y_max,
+					     features->y_fuzz, 0);
+		}
+		break;
+
 	case INTUOS4:
 	case INTUOS4L:
 		__set_bit(BTN_7, input_dev->keybit);
 		__set_bit(BTN_8, input_dev->keybit);
 		/* fall through */
 
-	case INTUOS5S:
 	case INTUOS4S:
 		for (i = 0; i < 7; i++)
 			__set_bit(BTN_0 + i, input_dev->keybit);
-- 
1.7.9.1

