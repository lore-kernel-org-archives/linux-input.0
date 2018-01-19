From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 7/7] Input: synaptics - handle errors from input_mt_init_slots()
Date: Fri, 19 Jan 2018 15:06:29 -0800
Message-ID: <20180119230629.49428-8-dmitry.torokhov@gmail.com>
References: <20180119230629.49428-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33148 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756223AbeASXGk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 18:06:40 -0500
In-Reply-To: <20180119230629.49428-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

input_mt_init_slots() may fail, we need to handle this condition.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index feb9c04d0eae2..dcb8e0cfaa1af 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1228,12 +1228,13 @@ static void set_abs_position_params(struct input_dev *dev,
 	input_abs_set_res(dev, y_code, info->y_res);
 }
 
-static void set_input_params(struct psmouse *psmouse,
-			     struct synaptics_data *priv)
+static int set_input_params(struct psmouse *psmouse,
+			    struct synaptics_data *priv)
 {
 	struct input_dev *dev = psmouse->dev;
 	struct synaptics_device_info *info = &priv->info;
 	int i;
+	int error;
 
 	/* Reset default psmouse capabilities */
 	__clear_bit(EV_REL, dev->evbit);
@@ -1256,7 +1257,7 @@ static void set_input_params(struct psmouse *psmouse,
 		/* Relative mode */
 		input_set_capability(dev, EV_REL, REL_X);
 		input_set_capability(dev, EV_REL, REL_Y);
-		return;
+		return 0;
 	}
 
 	/* Absolute mode */
@@ -1271,7 +1272,11 @@ static void set_input_params(struct psmouse *psmouse,
 					ABS_MT_POSITION_X, ABS_MT_POSITION_Y);
 		/* Image sensors can report per-contact pressure */
 		input_set_abs_params(dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
-		input_mt_init_slots(dev, 2, INPUT_MT_POINTER | INPUT_MT_TRACK);
+
+		error = input_mt_init_slots(dev, 2,
+					    INPUT_MT_POINTER | INPUT_MT_TRACK);
+		if (error)
+			return error;
 
 		/* Image sensors can signal 4 and 5 finger clicks */
 		input_set_capability(dev, EV_KEY, BTN_TOOL_QUADTAP);
@@ -1283,10 +1288,13 @@ static void set_input_params(struct psmouse *psmouse,
 		 * Profile sensor in CR-48 tracks contacts reasonably well,
 		 * other non-image sensors with AGM use semi-mt.
 		 */
-		input_mt_init_slots(dev, 2,
-				    INPUT_MT_POINTER |
-				    (cr48_profile_sensor ?
-					INPUT_MT_TRACK : INPUT_MT_SEMI_MT));
+		error = input_mt_init_slots(dev, 2,
+					    INPUT_MT_POINTER |
+					     (cr48_profile_sensor ?
+					      INPUT_MT_TRACK :
+					      INPUT_MT_SEMI_MT));
+		if (error)
+			return error;
 
 		/*
 		 * For semi-mt devices we send ABS_X/Y ourselves instead of
@@ -1326,6 +1334,8 @@ static void set_input_params(struct psmouse *psmouse,
 		    !SYN_CAP_EXT_BUTTONS_STICK(info->ext_cap_10))
 			__set_bit(INPUT_PROP_TOPBUTTONPAD, dev->propbit);
 	}
+
+	return 0;
 }
 
 static ssize_t synaptics_show_disable_gesture(struct psmouse *psmouse,
@@ -1563,7 +1573,12 @@ static int synaptics_init_ps2(struct psmouse *psmouse,
 		     info->capabilities, info->ext_cap, info->ext_cap_0c,
 		     info->ext_cap_10, info->board_id, info->firmware_id);
 
-	set_input_params(psmouse, priv);
+	err = set_input_params(psmouse, priv);
+	if (err) {
+		psmouse_err(psmouse,
+			    "failed to set up capabilities: %d\n", err);
+		goto init_fail;
+	}
 
 	/*
 	 * Encode touchpad model so that it can be used to set
-- 
2.16.0.rc1.238.g530d649a79-goog

