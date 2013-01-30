From: Kyle Evans <kevans@android-x86.org>
Subject: [PATCH] wacom: set physical limits for quirky tablet devices
Date: Wed, 30 Jan 2013 10:47:45 -0500
Message-ID: <1359560865-12410-1-git-send-email-kevans@android-x86.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:51059 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439Ab3A3Pqg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jan 2013 10:46:36 -0500
Received: by mail-ia0-f170.google.com with SMTP id k20so2524780iak.1
        for <linux-input@vger.kernel.org>; Wed, 30 Jan 2013 07:46:36 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Kyle Evans <kevans@android-x86.org>

TPC93 has two tools, finger and pen. Pen reports it's limits correctly,
but finger reports limits a screen size too big. This patch will make
the tool usable by the vast majority of users and does not interfere
with users who may still wish to calibrate, or current calibration data.

Sample values were taken from different devices and combined with the
intent that the cursor can reach the edge of the screen for all devices.
---
 drivers/input/tablet/wacom.h     |    2 +-
 drivers/input/tablet/wacom_sys.c |    2 +-
 drivers/input/tablet/wacom_wac.c |   14 +++++++++++---
 drivers/input/tablet/wacom_wac.h |    2 ++
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/input/tablet/wacom.h b/drivers/input/tablet/wacom.h
index b79d451..2883c70 100644
--- a/drivers/input/tablet/wacom.h
+++ b/drivers/input/tablet/wacom.h
@@ -134,7 +134,7 @@ static inline void wacom_schedule_work(struct wacom_wac *wacom_wac)
 extern const struct usb_device_id wacom_ids[];
 
 void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len);
-void wacom_setup_device_quirks(struct wacom_features *features);
+void wacom_setup_device_quirks(struct wacom_features *features, int product_id);
 int wacom_setup_input_capabilities(struct input_dev *input_dev,
 				   struct wacom_wac *wacom_wac);
 #endif
diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 858ad44..f52dbf4 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -1293,7 +1293,7 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 		}
 	}
 
-	wacom_setup_device_quirks(features);
+	wacom_setup_device_quirks(features, id->idProduct);
 
 	strlcpy(wacom_wac->name, features->name, sizeof(wacom_wac->name));
 
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index c2bfe92..b26f08c 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1397,7 +1397,7 @@ static void wacom_setup_intuos(struct wacom_wac *wacom_wac)
 	input_set_abs_params(input_dev, ABS_THROTTLE, -1023, 1023, 0, 0);
 }
 
-void wacom_setup_device_quirks(struct wacom_features *features)
+void wacom_setup_device_quirks(struct wacom_features *features, int product_id)
 {
 
 	/* touch device found but size is not defined. use default */
@@ -1422,6 +1422,14 @@ void wacom_setup_device_quirks(struct wacom_features *features)
 		features->quirks |= WACOM_QUIRK_BBTOUCH_LOWRES;
 	}
 
+	/* TPC93 is a 12" device, but the finger tool reports limits for a 13" screen */
+	if ( product_id == 0x93 && features->device_type == BTN_TOOL_FINGER) {
+		features->x_min = 176;
+		features->x_max = 3960;
+		features->y_min = 216;
+		features->y_max = 3900;
+	}
+
 	if (features->type == WIRELESS) {
 
 		/* monitor never has input and pen/touch have delayed create */
@@ -1450,9 +1458,9 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 	__set_bit(BTN_TOUCH, input_dev->keybit);
 
-	input_set_abs_params(input_dev, ABS_X, 0, features->x_max,
+	input_set_abs_params(input_dev, ABS_X, features->x_min, features->x_max,
 			     features->x_fuzz, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0, features->y_max,
+	input_set_abs_params(input_dev, ABS_Y, features->y_min, features->y_max,
 			     features->y_fuzz, 0);
 
 	if (features->device_type == BTN_TOOL_PEN) {
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 345f1e7..77216e0 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -114,6 +114,8 @@ struct wacom_features {
 	unsigned touch_max;
 	int oVid;
 	int oPid;
+	int x_min;
+	int y_min;
 };
 
 struct wacom_shared {
-- 
1.7.8.6

