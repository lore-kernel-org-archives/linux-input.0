From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6/7] Input: synaptics - switch to using input_set_capability
Date: Fri, 19 Jan 2018 15:06:28 -0800
Message-ID: <20180119230629.49428-7-dmitry.torokhov@gmail.com>
References: <20180119230629.49428-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39425 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756214AbeASXGj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 18:06:39 -0500
In-Reply-To: <20180119230629.49428-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Instead of manipulating capability bits directly, use
input_set_capability().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics.c | 49 ++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 3d2e23a0ae39d..feb9c04d0eae2 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1235,25 +1235,31 @@ static void set_input_params(struct psmouse *psmouse,
 	struct synaptics_device_info *info = &priv->info;
 	int i;
 
+	/* Reset default psmouse capabilities */
+	__clear_bit(EV_REL, dev->evbit);
+	bitmap_zero(dev->relbit, REL_CNT);
+	bitmap_zero(dev->keybit, KEY_CNT);
+
 	/* Things that apply to both modes */
 	__set_bit(INPUT_PROP_POINTER, dev->propbit);
-	__set_bit(EV_KEY, dev->evbit);
-	__set_bit(BTN_LEFT, dev->keybit);
-	__set_bit(BTN_RIGHT, dev->keybit);
 
-	if (SYN_CAP_MIDDLE_BUTTON(info->capabilities))
-		__set_bit(BTN_MIDDLE, dev->keybit);
+	input_set_capability(dev, EV_KEY, BTN_LEFT);
+
+	/* Clickpads report only left button */
+	if (!SYN_CAP_CLICKPAD(info->ext_cap_0c)) {
+		input_set_capability(dev, EV_KEY, BTN_RIGHT);
+		if (SYN_CAP_MIDDLE_BUTTON(info->capabilities))
+			input_set_capability(dev, EV_KEY, BTN_MIDDLE);
+	}
 
 	if (!priv->absolute_mode) {
 		/* Relative mode */
-		__set_bit(EV_REL, dev->evbit);
-		__set_bit(REL_X, dev->relbit);
-		__set_bit(REL_Y, dev->relbit);
+		input_set_capability(dev, EV_REL, REL_X);
+		input_set_capability(dev, EV_REL, REL_Y);
 		return;
 	}
 
 	/* Absolute mode */
-	__set_bit(EV_ABS, dev->evbit);
 	set_abs_position_params(dev, &priv->info, ABS_X, ABS_Y);
 	input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
 
@@ -1268,8 +1274,8 @@ static void set_input_params(struct psmouse *psmouse,
 		input_mt_init_slots(dev, 2, INPUT_MT_POINTER | INPUT_MT_TRACK);
 
 		/* Image sensors can signal 4 and 5 finger clicks */
-		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
-		__set_bit(BTN_TOOL_QUINTTAP, dev->keybit);
+		input_set_capability(dev, EV_KEY, BTN_TOOL_QUADTAP);
+		input_set_capability(dev, EV_KEY, BTN_TOOL_QUINTTAP);
 	} else if (SYN_CAP_ADV_GESTURE(info->ext_cap_0c)) {
 		set_abs_position_params(dev, info,
 					ABS_MT_POSITION_X, ABS_MT_POSITION_Y);
@@ -1296,36 +1302,29 @@ static void set_input_params(struct psmouse *psmouse,
 	if (SYN_CAP_PALMDETECT(info->capabilities))
 		input_set_abs_params(dev, ABS_TOOL_WIDTH, 0, 15, 0, 0);
 
-	__set_bit(BTN_TOUCH, dev->keybit);
-	__set_bit(BTN_TOOL_FINGER, dev->keybit);
+	input_set_capability(dev, EV_KEY, BTN_TOUCH);
+	input_set_capability(dev, EV_KEY, BTN_TOOL_FINGER);
 
 	if (synaptics_has_multifinger(priv)) {
-		__set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
-		__set_bit(BTN_TOOL_TRIPLETAP, dev->keybit);
+		input_set_capability(dev, EV_KEY, BTN_TOOL_DOUBLETAP);
+		input_set_capability(dev, EV_KEY, BTN_TOOL_TRIPLETAP);
 	}
 
 	if (SYN_CAP_FOUR_BUTTON(info->capabilities) ||
 	    SYN_CAP_MIDDLE_BUTTON(info->capabilities)) {
-		__set_bit(BTN_FORWARD, dev->keybit);
-		__set_bit(BTN_BACK, dev->keybit);
+		input_set_capability(dev, EV_KEY, BTN_FORWARD);
+		input_set_capability(dev, EV_KEY, BTN_BACK);
 	}
 
 	if (!SYN_CAP_EXT_BUTTONS_STICK(info->ext_cap_10))
 		for (i = 0; i < SYN_CAP_MULTI_BUTTON_NO(info->ext_cap); i++)
-			__set_bit(BTN_0 + i, dev->keybit);
-
-	__clear_bit(EV_REL, dev->evbit);
-	__clear_bit(REL_X, dev->relbit);
-	__clear_bit(REL_Y, dev->relbit);
+			input_set_capability(dev, EV_KEY, BTN_0 + i);
 
 	if (SYN_CAP_CLICKPAD(info->ext_cap_0c)) {
 		__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
 		if (psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids) &&
 		    !SYN_CAP_EXT_BUTTONS_STICK(info->ext_cap_10))
 			__set_bit(INPUT_PROP_TOPBUTTONPAD, dev->propbit);
-		/* Clickpads report only left button */
-		__clear_bit(BTN_RIGHT, dev->keybit);
-		__clear_bit(BTN_MIDDLE, dev->keybit);
 	}
 }
 
-- 
2.16.0.rc1.238.g530d649a79-goog

