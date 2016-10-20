From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v3 13/18] HID: wacom: Fix sensor outbounds and redefine as offsets from each edge
Date: Wed, 19 Oct 2016 18:03:49 -0700
Message-ID: <20161020010354.4049-13-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
 <20161020010354.4049-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32986 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755244AbcJTBFA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 19 Oct 2016 21:05:00 -0400
Received: by mail-pf0-f195.google.com with SMTP id i85so3840525pfa.0
        for <linux-input@vger.kernel.org>; Wed, 19 Oct 2016 18:05:00 -0700 (PDT)
In-Reply-To: <20161020010354.4049-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

Many of Wacom's display tablets include an "outbound" area where pen
digitizing is possible but outside of the display area. To ensure that
pen coordinates are mapped to the correct on-screen location, the driver
sets the minimum and maximum axis values of X and Y to those coordinates
which coincide with the screen edge. These values are simply the
hardware minimum/maximum plus/minus the outbound size for a particular
edge.

When outbound support was added/updated in ac414da, fa77034, and
ecd618d, we decided to have the wacom_features structs store the desired
minimum and maximum values directly. In hindsight, this was perhaps not
the best choice since it has allowed minor errors to crop up unnoticed.
Some tablets have had their coordinates over-corrected (e.g. most of the
devices "fixed" in ecd618d were already adjusted in ac414da), while
others never had a correction applied (e.g. the ISDv5 325, whose
declared maximum the hardware maximum instead of the outbound maximum).

A less error-prone method of handling the outbound is to let the driver
calculate the correct minimum/maximum values by providing it with both
the actual hardware maximums and the size of the outbound on each edge.
These values are more easy to verify as correct since the values can be
trivially compared against specifications.

This patch reverts the declared maximum values to the actual hardware
maximums, e.g. as declared prior to ac414da (values for these and other
display tablets that were subsuquently introduced have been verified
against specs). Per-edge outbound sizes are stored in the wacom_features
struct as offset_{left,right,top,bottom} and used in combination with
the hardware ranges to calculate effective axis ranges for ABS_X and
ABS_Y.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_wac.c | 62 ++++++++++++++++++++++++++++++++-----------------
 drivers/hid/wacom_wac.h |  6 +++--
 2 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 85e1ad1..5046071 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2674,10 +2674,12 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	__set_bit(BTN_TOUCH, input_dev->keybit);
 	__set_bit(ABS_MISC, input_dev->absbit);
 
-	input_set_abs_params(input_dev, ABS_X, features->x_min,
-			     features->x_max, features->x_fuzz, 0);
-	input_set_abs_params(input_dev, ABS_Y, features->y_min,
-			     features->y_max, features->y_fuzz, 0);
+	input_set_abs_params(input_dev, ABS_X, 0 + features->offset_left,
+			     features->x_max - features->offset_right,
+			     features->x_fuzz, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0 + features->offset_top,
+			     features->y_max - features->offset_bottom,
+			     features->y_fuzz, 0);
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0,
 		features->pressure_max, features->pressure_fuzz, 0);
 
@@ -3389,26 +3391,30 @@ static const struct wacom_features wacom_features_0x317 =
 	  INTUOSPL, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9, .touch_max = 16,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0xF4 =
-	{ "Wacom Cintiq 24HD", 104080, 65200, 2047, 63,
+	{ "Wacom Cintiq 24HD", 104480, 65600, 2047, 63,
 	  WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 16,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0xF8 =
-	{ "Wacom Cintiq 24HD touch", 104080, 65200, 2047, 63, /* Pen */
+	{ "Wacom Cintiq 24HD touch", 104480, 65600, 2047, 63, /* Pen */
 	  WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 16,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0xf6 };
 static const struct wacom_features wacom_features_0xF6 =
 	{ "Wacom Cintiq 24HD touch", .type = WACOM_24HDT, /* Touch */
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0xf8, .touch_max = 10,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0x32A =
-	{ "Wacom Cintiq 27QHD", 119740, 67520, 2047, 63,
+	{ "Wacom Cintiq 27QHD", 120140, 67920, 2047, 63,
 	  WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 0,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x32B =
-	{ "Wacom Cintiq 27QHD touch", 119740, 67520, 2047, 63,
+	{ "Wacom Cintiq 27QHD touch", 120140, 67920, 2047, 63,
 	  WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 0,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x32C };
 static const struct wacom_features wacom_features_0x32C =
 	{ "Wacom Cintiq 27QHD touch", .type = WACOM_27QHDT,
@@ -3423,13 +3429,15 @@ static const struct wacom_features wacom_features_0xC6 =
 	{ "Wacom Cintiq 12WX", 53020, 33440, 1023, 63,
 	  WACOM_BEE, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 10 };
 static const struct wacom_features wacom_features_0x304 =
-	{ "Wacom Cintiq 13HD", 59152, 33448, 1023, 63,
+	{ "Wacom Cintiq 13HD", 59552, 33848, 1023, 63,
 	  WACOM_13HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x333 =
-	{ "Wacom Cintiq 13HD touch", 59152, 33448, 2047, 63,
+	{ "Wacom Cintiq 13HD touch", 59552, 33848, 2047, 63,
 	  WACOM_13HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x335 };
 static const struct wacom_features wacom_features_0x335 =
 	{ "Wacom Cintiq 13HD touch", .type = WACOM_24HDT, /* Touch */
@@ -3446,42 +3454,50 @@ static const struct wacom_features wacom_features_0xF0 =
 	{ "Wacom DTU1631", 34623, 19553, 511, 0,
 	  DTU, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xFB =
-	{ "Wacom DTU1031", 21896, 13760, 511, 0,
+	{ "Wacom DTU1031", 22096, 13960, 511, 0,
 	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 4,
+	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET,
 	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
 static const struct wacom_features wacom_features_0x32F =
-	{ "Wacom DTU1031X", 22472, 12728, 511, 0,
+	{ "Wacom DTU1031X", 22672, 12928, 511, 0,
 	  DTUSX, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 0,
+	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET,
 	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
 static const struct wacom_features wacom_features_0x336 =
-	{ "Wacom DTU1141", 23472, 13203, 1023, 0,
+	{ "Wacom DTU1141", 23672, 13403, 1023, 0,
 	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 4,
+	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET,
 	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
 static const struct wacom_features wacom_features_0x57 =
-	{ "Wacom DTK2241", 95640, 54060, 2047, 63,
+	{ "Wacom DTK2241", 95840, 54260, 2047, 63,
 	  DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 6,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x59 = /* Pen */
-	{ "Wacom DTH2242", 95640, 54060, 2047, 63,
+	{ "Wacom DTH2242", 95840, 54260, 2047, 63,
 	  DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 6,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5D };
 static const struct wacom_features wacom_features_0x5D = /* Touch */
 	{ "Wacom DTH2242",       .type = WACOM_24HDT,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x59, .touch_max = 10,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0xCC =
-	{ "Wacom Cintiq 21UX2", 86800, 65200, 2047, 63,
+	{ "Wacom Cintiq 21UX2", 87200, 65600, 2047, 63,
 	  WACOM_21UX2, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 18,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0xFA =
-	{ "Wacom Cintiq 22HD", 95440, 53860, 2047, 63,
+	{ "Wacom Cintiq 22HD", 95840, 54260, 2047, 63,
 	  WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 18,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x5B =
-	{ "Wacom Cintiq 22HDT", 95440, 53860, 2047, 63,
+	{ "Wacom Cintiq 22HDT", 95840, 54260, 2047, 63,
 	  WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 18,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5e };
 static const struct wacom_features wacom_features_0x5E =
 	{ "Wacom Cintiq 22HDT", .type = WACOM_24HDT,
@@ -3625,18 +3641,20 @@ static const struct wacom_features wacom_features_0x6004 =
 	{ "ISD-V4", 12800, 8000, 255, 0,
 	  TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x307 =
-	{ "Wacom ISDv5 307", 59152, 33448, 2047, 63,
+	{ "Wacom ISDv5 307", 59552, 33848, 2047, 63,
 	  CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x309 };
 static const struct wacom_features wacom_features_0x309 =
 	{ "Wacom ISDv5 309", .type = WACOM_24HDT, /* Touch */
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x0307, .touch_max = 10,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0x30A =
-	{ "Wacom ISDv5 30A", 59152, 33448, 2047, 63,
+	{ "Wacom ISDv5 30A", 59552, 33848, 2047, 63,
 	  CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x30C };
 static const struct wacom_features wacom_features_0x30C =
 	{ "Wacom ISDv5 30C", .type = WACOM_24HDT, /* Touch */
@@ -3652,6 +3670,7 @@ static const struct wacom_features wacom_features_0x325 =
 	{ "Wacom ISDv5 325", 59552, 33848, 2047, 63,
 	  CINTIQ_COMPANION_2, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 11,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x326 };
 static const struct wacom_features wacom_features_0x326 = /* Touch */
 	{ "Wacom ISDv5 326", .type = HID_GENERIC, .oVid = USB_VENDOR_ID_WACOM,
@@ -3681,8 +3700,9 @@ static const struct wacom_features wacom_features_0x33E =
 	  INTUOSHT2, WACOM_INTUOS_RES, WACOM_INTUOS_RES, .touch_max = 16,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0x343 =
-	{ "Wacom DTK1651", 34616, 19559, 1023, 0,
+	{ "Wacom DTK1651", 34816, 19759, 1023, 0,
 	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 4,
+	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET,
 	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
 
 static const struct wacom_features wacom_features_HID_ANY_ID =
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 83ddb2a0..5c5c689 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -181,8 +181,10 @@ struct wacom_features {
 	int x_resolution;
 	int y_resolution;
 	int numbered_buttons;
-	int x_min;
-	int y_min;
+	int offset_left;
+	int offset_right;
+	int offset_top;
+	int offset_bottom;
 	int device_type;
 	int x_phy;
 	int y_phy;
-- 
2.10.0

