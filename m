From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 3/5] Input: wacom - Introduce wacom_fix_phy_from_hid
Date: Thu,  6 Sep 2012 15:53:28 -0700
Message-ID: <1346972010-1330-3-git-send-email-killertofu@gmail.com>
References: <1346972010-1330-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36548 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019Ab2IFWxq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Sep 2012 18:53:46 -0400
Received: by dady13 with SMTP id y13so1386576dad.19
        for <linux-input@vger.kernel.org>; Thu, 06 Sep 2012 15:53:45 -0700 (PDT)
In-Reply-To: <1346972010-1330-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com, chris@cnpbagwell.com
Cc: Jason Gerecke <killertofu@gmail.com>

The Cintiq 24HD touch cannot use wacom_set_phy_from_res to determine
the physical size of the touch sensor since the pen and touch are
on separate USB devices. The physical size is, however, provided in
the HID descriptor, just scaled to a unit we don't use.

This patch introduces the function wacom_fix_phy_from_hid to let
us make use of the unit and exponent data provided by HID to set
the [xy]_phy variables to an appropriate value. This function
relies on a trimmed-down version of hidinput_calc_abs_res from
the hid-input.c.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_sys.c | 69 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index d67a996..08ab0b0 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -172,6 +172,74 @@ static void wacom_close(struct input_dev *dev)
 }
 
 /*
+ * Calculate the resolution of the X or Y axis, given appropriate HID data.
+ * This function is little more than hidinput_calc_abs_res stripped down.
+ */
+static int wacom_calc_hid_res(int logical_extents, int physical_extents,
+                              unsigned char unit, unsigned char exponent)
+{
+	int prev, unit_exponent;
+
+	/* Check if the extents are sane */
+	if (logical_extents <= 0 || physical_extents <= 0)
+		return 0;
+
+	/* Get signed value of nybble-sized twos-compliment exponent */
+	unit_exponent = exponent;
+	if (unit_exponent > 7)
+		unit_exponent -= 16;
+
+	/* Convert physical_extents to millimeters */
+	if (unit == 0x11) {		/* If centimeters */
+		unit_exponent += 1;
+	} else if (unit == 0x13) {	/* If inches */
+		prev = physical_extents;
+		physical_extents *= 254;
+		if (physical_extents < prev)
+			return 0;
+		unit_exponent -= 1;
+	} else {
+		return 0;
+	}
+
+	/* Apply negative unit exponent */
+	for (; unit_exponent < 0; unit_exponent++) {
+		prev = logical_extents;
+		logical_extents *= 10;
+		if (logical_extents < prev)
+			return 0;
+	}
+	/* Apply positive unit exponent */
+	for (; unit_exponent > 0; unit_exponent--) {
+		prev = physical_extents;
+		physical_extents *= 10;
+		if (physical_extents < prev)
+			return 0;
+	}
+
+	/* Calculate resolution */
+	return logical_extents / physical_extents;
+}
+
+/*
+ * The physical dimension specified by the HID descriptor is likely not in
+ * the "100th of a mm" units expected by wacom_calculate_touch_res. This
+ * function adjusts the value of [xy]_phy based on the unit and exponent
+ * provided by the HID descriptor. If an error occurs durring conversion
+ * (e.g. from the unit being left unspecified) [xy]_phy is not modified.
+ */
+static void wacom_fix_phy_from_hid(struct wacom_features *features)
+{
+	int xres = wacom_calc_hid_res(features->x_max, features->x_phy, features->unit, features->unitExpo);
+	int yres = wacom_calc_hid_res(features->y_max, features->y_phy, features->unit, features->unitExpo);
+
+	if (xres > 0 && yres > 0) {
+		features->x_phy = (100 * features->x_max) / xres;
+		features->y_phy = (100 * features->y_max) / yres;
+	}
+}
+
+/*
  * Static values for max X/Y and resolution of Pen interface is stored in
  * features. This mean physical size of active area can be computed.
  * This is useful to do when Pen and Touch have same active area of tablet.
@@ -531,6 +599,7 @@ static int wacom_retrieve_hid_descriptor(struct usb_interface *intf,
 	error = wacom_parse_hid(intf, hid_desc, features);
 	if (error)
 		goto out;
+	wacom_fix_phy_from_hid(features);
 
  out:
 	return error;
-- 
1.7.12

