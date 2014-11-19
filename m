From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/2] HID: wacom: Add angular resolution data to some ABS axes
Date: Tue, 18 Nov 2014 16:50:09 -0800
Message-ID: <1416358209-3937-2-git-send-email-killertofu@gmail.com>
References: <1416358209-3937-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:47881 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456AbaKSAua (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Nov 2014 19:50:30 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so5443142pab.2
        for <linux-input@vger.kernel.org>; Tue, 18 Nov 2014 16:50:29 -0800 (PST)
In-Reply-To: <1416358209-3937-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, benjamin.tissores@gmail.com, Jason Gerecke <killertofu@gmail.com>

Provide the resolution of several angular axes (tilt, pen rotation, puck
rotation) to userspace. Because these values are natively degree-based, we
need to convert them to into units/radian as required by the input_absinfo
struct. To ensure wraparound behaves properly for the rotation axes, the
converted value was rounded up rather than rounded nearest.

Notably, the touchring axes (ABS_WHEEL and ABS_THROTTLE) are left without a
a declared resolution because the their low resolution cannot be accurately
represented (the worst-case rounding-induced error would be ~16 degrees).
Pre-scaling the values and range by at least 10x would reduce the error in
the resolution to acceptable levels, but the xf86-input-wacom driver is not
able to use pre-scaled values for these axes at this time.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/hid/wacom_wac.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 525b648..5833731 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1927,7 +1927,9 @@ static void wacom_setup_cintiq(struct wacom_wac *wacom_wac)
 			     0, wacom_wac->features.distance_max, 0, 0);
 	input_set_abs_params(input_dev, ABS_WHEEL, 0, 1023, 0, 0);
 	input_set_abs_params(input_dev, ABS_TILT_X, -64, 63, 0, 0);
+	input_abs_set_res(input_dev, ABS_TILT_X, 57);
 	input_set_abs_params(input_dev, ABS_TILT_Y, -64, 63, 0, 0);
+	input_abs_set_res(input_dev, ABS_TILT_Y, 57);
 }
 
 static void wacom_setup_intuos(struct wacom_wac *wacom_wac)
@@ -1947,6 +1949,7 @@ static void wacom_setup_intuos(struct wacom_wac *wacom_wac)
 	__set_bit(BTN_TOOL_LENS, input_dev->keybit);
 
 	input_set_abs_params(input_dev, ABS_RZ, -900, 899, 0, 0);
+	input_abs_set_res(input_dev, ABS_RZ, 287);
 	input_set_abs_params(input_dev, ABS_THROTTLE, -1023, 1023, 0, 0);
 }
 
@@ -2092,6 +2095,7 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 	case WACOM_24HD:
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
+		input_abs_set_res(input_dev, ABS_Z, 287);
 		input_set_abs_params(input_dev, ABS_THROTTLE, 0, 71, 0, 0);
 		/* fall through */
 
@@ -2106,6 +2110,7 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case WACOM_BEE:
 	case CINTIQ:
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
+		input_abs_set_res(input_dev, ABS_Z, 287);
 
 		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 
@@ -2114,6 +2119,7 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 	case WACOM_13HD:
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
+		input_abs_set_res(input_dev, ABS_Z, 287);
 		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 		wacom_setup_cintiq(wacom_wac);
 		break;
@@ -2122,6 +2128,7 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case INTUOS3L:
 	case INTUOS3S:
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
+		input_abs_set_res(input_dev, ABS_Z, 287);
 		/* fall through */
 
 	case INTUOS:
@@ -2144,6 +2151,7 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 					      0, 0);
 
 			input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
+			input_abs_set_res(input_dev, ABS_Z, 287);
 
 			wacom_setup_intuos(wacom_wac);
 		} else if (features->device_type == BTN_TOOL_FINGER) {
@@ -2162,6 +2170,7 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case INTUOS4L:
 	case INTUOS4S:
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
+		input_abs_set_res(input_dev, ABS_Z, 287);
 		wacom_setup_intuos(wacom_wac);
 
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
@@ -2261,6 +2270,7 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 	case CINTIQ_HYBRID:
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
+		input_abs_set_res(input_dev, ABS_Z, 287);
 		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 
 		wacom_setup_cintiq(wacom_wac);
-- 
2.1.3

