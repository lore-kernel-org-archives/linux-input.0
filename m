From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 1/3] input: wacom: Add fuzz and scale features
Date: Thu,  2 Sep 2010 20:18:35 +0200
Message-ID: <1283451517-1711-2-git-send-email-rydberg@euromail.se>
References: <1283451517-1711-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:50210 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753264Ab0IBST2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Sep 2010 14:19:28 -0400
In-Reply-To: <1283451517-1711-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

The signal-to-noise ratio varies between devices, but currently all
devices are treated the same way. In addition, some devices report
very low resolution, which makes the fuzz algorithm ineffective.
Add fuzz and scale parameters to the feature struct, allowing for
tailored treatment of devices.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/tablet/wacom_sys.c |   12 +++++++++++-
 drivers/input/tablet/wacom_wac.c |    9 ++++++---
 drivers/input/tablet/wacom_wac.h |    6 ++++++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 42ba369..979170e 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -219,6 +219,8 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 					features->pressure_max = 255;
 					i += 4;
 				}
+				features->x_max *= features->x_scale;
+				features->x_fuzz *= features->x_scale;
 				break;
 
 			case HID_USAGE_Y:
@@ -251,6 +253,8 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 						i += 4;
 					}
 				}
+				features->y_max *= features->y_scale;
+				features->y_fuzz *= features->y_scale;
 				break;
 
 			case HID_USAGE_FINGER:
@@ -333,8 +337,14 @@ static int wacom_retrieve_hid_descriptor(struct usb_interface *intf,
 	struct usb_host_interface *interface = intf->cur_altsetting;
 	struct hid_descriptor *hid_desc;
 
-	/* default device to penabled */
+	/* default features */
 	features->device_type = BTN_TOOL_PEN;
+	features->x_fuzz = 4;
+	features->y_fuzz = 4;
+	features->pressure_fuzz = 0;
+	features->distance_fuzz = 0;
+	features->x_scale = 1;
+	features->y_scale = 1;
 
 	/* only Tablet PCs need to retrieve the info */
 	if ((features->type != TABLETPC) && (features->type != TABLETPC2FG))
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 40d77ba..bfe5654 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -951,9 +951,12 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 	__set_bit(BTN_TOUCH, input_dev->keybit);
 
-	input_set_abs_params(input_dev, ABS_X, 0, features->x_max, 4, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0, features->y_max, 4, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE, 0, features->pressure_max, 0, 0);
+	input_set_abs_params(input_dev, ABS_X, 0, features->x_max,
+			     features->x_fuzz, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, features->y_max,
+			     features->y_fuzz, 0);
+	input_set_abs_params(input_dev, ABS_PRESSURE, 0, features->pressure_max,
+			     features->pressure_fuzz, 0);
 
 	__set_bit(ABS_MISC, input_dev->absbit);
 
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 99e1a54..51fce64 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -73,6 +73,12 @@ struct wacom_features {
 	int y_phy;
 	unsigned char unit;
 	unsigned char unitExpo;
+	int x_fuzz;
+	int y_fuzz;
+	int pressure_fuzz;
+	int distance_fuzz;
+	int x_scale;
+	int y_scale;
 };
 
 struct wacom_shared {
-- 
1.7.1

